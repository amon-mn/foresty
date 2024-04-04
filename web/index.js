// Configuração do Firebase
var firebaseConfig = {
    apiKey: "AIzaSyCDll66xmGhwbYBFRRBxj8lvQIFrwXydqw",
    authDomain: "forest-traceability.firebaseapp.com",
    projectId: "forest-traceability",
    storageBucket: "forest-traceability.appspot.com",
    messagingSenderId: "883889030916",
    appId: "1:883889030916:web:1a9ce44e058b39d7fa7251",
    measurementId: "G-3Q760CMJBM"
};
firebase.initializeApp(firebaseConfig);

// Referência ao Firestore
const db = firebase.firestore();

// Função para extrair o ID do usuário e o ID do lote da URL
function getUserAndLoteIdFromUrl() {
    const urlParams = new URLSearchParams(window.location.search);
    const userId = urlParams.get('userId');
    const batchId = urlParams.get('batchId'); 
    return { userId, batchId }; 
}

// Função para carregar e exibir as informações do produto, do produtor e do usuário
async function carregarUsuario() {
    const { userId, batchId } = getUserAndLoteIdFromUrl(); // Obtém os IDs da URL
    if (!userId || !batchId) {
        console.error("IDs do usuário ou do batch não encontrados na URL.");
        return;
    }
    try {
        // Recuperar os dados do usuário a partir do Firestore
        const userRef = await db.collection('users').doc(userId).get();
        if (userRef.exists) {
            const userData = userRef.data();
            const userName = userData.name;

            // Inserindo o nome do usuário no elemento de usuário
            document.getElementById('userName').textContent = "Usuário: " + userName;

            // Recuperar os dados específicos do lote
            const loteRef = userRef.ref.collection('lotes').doc(batchId);
            const loteDoc = await loteRef.get();
            if (loteDoc.exists) {
                const nomeLote = loteDoc.data().nomeLote;
                const nomeProduto = loteDoc.data().nomeProduto;
                const etiqueta = loteDoc.data().qrcode ? loteDoc.data().qrcode.etiqueta : null;
                const peso = etiqueta ? etiqueta.peso || "Sem informação" : "Sem informação";
                const unidade = etiqueta ? etiqueta.unidade || "Sem informação" : "Sem informação";
                
                // Exibindo as informações do lote
                const loteLi = document.createElement('li');
                loteLi.innerHTML = "<span class='bullet'>ID do Lote:</span> " + batchId + "<br>" +
                    "<span class='bullet'>Nome do Lote:</span> " + nomeLote + "<br>" +
                    "<span class='bullet'>Nome do Produto:</span> " + nomeProduto + "<br>" +
                    "<span class='bullet'>Peso:</span> " + peso + "  <span class='bullet'>Unidade:</span> " + unidade;
                loteLi.classList.add('lote');
                document.getElementById('users').innerHTML = ''; // Limpar a lista antes de adicionar os novos lotes
                document.getElementById('users').appendChild(loteLi);

                // Atualizar a localização inicial do mapa
                const latitude = loteDoc.data().latitude;
                const longitude = loteDoc.data().longitude;
                if (latitude && longitude) {
                    initMap({ lat: latitude, lng: longitude });
                } else {
                    console.error("As coordenadas de latitude e longitude não foram encontradas para o lote.");
                }
            } else {
                console.error("O lote com o ID especificado não foi encontrado.");
            }
        } else {
            console.error("O usuário com o ID especificado não foi encontrado.");
        }
    } catch (error) {
        console.error("Erro ao carregar usuário e lote: ", error);
    }
}

function initMap(initialLocation) {
    const options = {
        zoom: 16,
        center: initialLocation
    }; 

    map = new google.maps.Map(
        document.getElementById('map'),
        options
    );

    // Adiciona um marcador na localização inicial do usuário
    addMarker(initialLocation);
}

function addMarker(location) {
    if (location) {
        new google.maps.Marker({
            position: location,
            map: map
        });
    }
}

// Carregar os dados automaticamente ao carregar a página
carregarUsuario();