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

// Função para inicializar o mapa
function initMap(initialLocation) {
    const options = {
        zoom: 16,
        center: initialLocation
    }; 

    map = new google.maps.Map(
        document.getElementById('map'),
        options
    );

    // Adiciona um evento para quando o mapa terminar de carregar
    google.maps.event.addListenerOnce(map, 'tilesloaded', function() {
        // Após o mapa ser carregado, obtemos a localização do usuário
        navigator.geolocation.getCurrentPosition(position => {
            const userLocation = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
            };

            // Adiciona um marcador na localização inicial do usuário
            addMarker(initialLocation, 'icons/marker_rastech.png', 100);
            // Adiciona um marcador na localização atual do usuário
            addMarker(userLocation, 'icons/marker_house.png', 100);

            // Traça uma linha reta entre as duas localizações
            const lineCoordinates = [
                { lat: initialLocation.lat, lng: initialLocation.lng },
                userLocation
            ];
            const line = new google.maps.Polyline({
                path: lineCoordinates,
                geodesic: true,
                strokeColor: '#006400',
                strokeOpacity: 1.0,
                strokeWeight: 2
            });
            line.setMap(map);

            // Move o mapa para a localização atual do usuário
            map.panTo(userLocation);

            // Desenha a direção
            drawDirection(initialLocation, userLocation);
        });
    });
}

// Função para adicionar marcadores personalizados nos pontos de origem e destino
function addCustomMarkers(start, end) {
    addMarker(start, 'icons/marker_rastech.png', 100); // Adiciona marcador personalizado no ponto de origem
    addMarker(end, 'icons/marker_house.png', 100); // Adiciona marcador personalizado no ponto de destino
}

// Função para desenhar a direção entre dois pontos
function drawDirection(start, end) {
    const directionService = new google.maps.DirectionsService();
    const directionRenderer = new google.maps.DirectionsRenderer({
        suppressMarkers: true // Desativa a exibição dos marcadores padrão
    });

    directionRenderer.setMap(map);

    // Adiciona os marcadores personalizados nos pontos de origem e destino
    addCustomMarkers(start, end);

    calculationAndDisplayRoute(directionService, directionRenderer, start, end);
}

// Função para calcular e exibir a rota
function calculationAndDisplayRoute(directionService, directionRenderer, start, end) {
    const request = {
        origin: start,
        destination: end,
        travelMode: google.maps.DirectionsTravelMode.DRIVING
    };

    directionService.route(request, function (response, status) {
       if( status === google.maps.DirectionsStatus.OK ) {
           directionRenderer.setDirections(response);
       }
    });
}


// Função para adicionar marcador no mapa com ícone personalizado e tamanho ajustável
function addMarker(location, iconUrl, size) {
    if (location) {
        new google.maps.Marker({
            position: location,
            map: map,
            icon: {
                url: iconUrl, // URL do ícone personalizado
                scaledSize: new google.maps.Size(size, size), // Tamanho do ícone (largura x altura)
                origin: new google.maps.Point(0, 0), // Origem do ícone
                anchor: new google.maps.Point(size / 2, size / 2) // Ponto de ancoragem do ícone (centro)
            }
        });
    }
}

// Carregar os dados automaticamente ao carregar a página
carregarUsuario();
