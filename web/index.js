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

// Função para extrair o ID do usuário da URL
function getUserIdFromUrl() {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get('userId');
}

// Função para carregar e exibir as informações do produto, do produtor e do usuário
async function carregarUsuarioELotes() {
    const userId = getUserIdFromUrl(); // Obtem o ID do usuário da URL
    if (!userId) {
        console.error("ID do usuário não encontrado na URL.");
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

            // A mesma lógica para carregar os lotes permanece inalterada
            const usersList = document.getElementById('users');
            usersList.innerHTML = ''; // Limpar a lista antes de adicionar os novos lotes

            const lotesRef = userRef.ref.collection('lotes');
            const lotesQuerySnapshot = await lotesRef.get();
            lotesQuerySnapshot.forEach(loteDoc => {
                const loteLi = document.createElement('li');
                const nomeLote = loteDoc.data().nomeLote;
                const nomeProduto = loteDoc.data().nomeProduto;
                const etiqueta = loteDoc.data().qrcode ? loteDoc.data().qrcode.etiqueta : null; // Verifica se 'qrcode' existe
                const peso = etiqueta ? etiqueta.peso || "Sem informação" : "Sem informação"; // Verifica se 'etiqueta' existe
                const unidade = etiqueta ? etiqueta.unidade || "Sem informação" : "Sem informação"; // Verifica se 'etiqueta' existe
                const loteId = loteDoc.id; // Adicionando o ID do lote
                loteLi.innerHTML = "<span class='bullet'>ID do Lote:</span> " + loteId + "<br>" +
                                    "<span class='bullet'>Nome do Lote:</span> " + nomeLote + "<br>" +
                                    "<span class='bullet'>Nome do Produto:</span> " + nomeProduto + "<br>" +
                                    "<span class='bullet'>Peso:</span> " + peso + "  <span class='bullet'>Unidade:</span> " + unidade;
                loteLi.classList.add('lote');
                usersList.appendChild(loteLi);
            });
        } else {
            console.error("O usuário com o ID especificado não foi encontrado.");
        }
    } catch (error) {
        console.error("Erro ao carregar usuário e lotes: ", error);
    }
}

// Carregar os dados automaticamente ao carregar a página
carregarUsuarioELotes();
