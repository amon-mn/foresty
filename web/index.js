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
            const propertyName = userData.propertyName || userData.name;
            const address = userData.street + ', ' + userData.neighborhood + ' - ' + userData.city + ', ' + userData.state + ' - ' + userData.cep;
            const cpf = userData.cpf;
            // Recuperar os dados específicos do lote
            const loteRef = userRef.ref.collection('lotes').doc(batchId);
            const loteDoc = await loteRef.get();
            if (loteDoc.exists) {
                const nomeProduto = loteDoc.data().nomeProduto;
                const etiqueta = loteDoc.data().qrcode ? loteDoc.data().qrcode.etiqueta : null;
                const peso = etiqueta ? etiqueta.peso || "Sem informação" : "Sem informação";
                const unidade = etiqueta ? etiqueta.unidade || "Sem informação" : "Sem informação";
                const colheita = loteDoc.data().colheita;
                const dataDaColheita = colheita ? colheita.dataDaColheita || "Sem informação" : "Sem informação";
                const tipoCultivo = loteDoc.data().tipoCultivo;
                const qrcode = loteDoc.data().qrcode;
                const isOrganico = qrcode ? qrcode.isOrganico || "Sem informação" : "Sem informação";

                // Função para extrair apenas os números do CPF/CNPJ
                function extrairNumeros(cpfCnpj) {
                    return cpfCnpj.replace(/\D/g, ''); // Remove todos os caracteres não numéricos
                }

                // Função para mascarar parcialmente o CPF/CNPJ
                function mascararCpfCnpj(cpfCnpj) {
                    const numeros = extrairNumeros(cpfCnpj); // Extrai apenas os números
                    if (numeros.length === 11) { // Se for um CPF
                        return '***.' + numeros.substring(3, 6) + '.' + numeros.substring(6, 9) + '-' + '**';
                    } else if (numeros.length === 14) { // Se for um CNPJ
                        return numeros.substring(0, 2) + '.***.***/' + numeros.substring(8, 12) + '*';
                    } else {
                        return 'CPF/CNPJ inválido';
                    }
                }


                // Acessando a data da atividade
                let dataDaAtividade = "Sem informação"; // Define um valor padrão
                const atividades = loteDoc.data().atividades;
                if (atividades && atividades.length > 0) {
                    // Se existirem atividades, encontre a data da atividade
                    for (let i = 0; i < atividades.length; i++) {
                        const atividade = atividades[i];
                        if (atividade.dataDaAtividade) {
                            dataDaAtividade = atividade.dataDaAtividade;
                            break; // Para de procurar assim que encontrar a primeira data de atividade
                        }
                    }
                }

                // Função para formatar a data no formato DD/MM/AAAA
                function formatarData(data) {
                    const dataObj = new Date(data);
                    dataObj.setDate(dataObj.getDate() + 1); // Adiciona um dia à data
                    const dia = String(dataObj.getDate()).padStart(2, '0'); // Garante que o dia tenha dois dígitos
                    const mes = String(dataObj.getMonth() + 1).padStart(2, '0'); // Garante que o mês tenha dois dígitos
                    const ano = dataObj.getFullYear();
                    return `${dia}/${mes}/${ano}`;
                }
                
                // Exibindo as informações do lote
                const loteLi = document.createElement('li');
                loteLi.innerHTML = 
                    "<span class='bullet'>Produto:</span> " + nomeProduto + "<br>" +
                    "<span class='bullet'>Peso:</span> " + peso + "  <span class='bullet'> </span> " + unidade + "<br>" +
                    "<span class='bullet'>ID do Lote:</span> " + batchId + "<br>" +
                    "<span class='bullet'>Nome da Propriedade:</span> " + propertyName + "<br>" +
                    "<span class='bullet'>Endereço:</span> " + address + "<br>" +
                    "<span class='bullet'>CPF/CNPJ:</span> " + mascararCpfCnpj(cpf) + "<br>" +
                    "<span class='bullet'>Data de Plantio:</span> " + formatarData(dataDaAtividade) + "<br>" +
                    "<span class='bullet'>Data da Colheita:</span> " + formatarData(dataDaColheita) + "<br>" ;
                    // Verifica se o tipo de cultivo é 'Orgânico' ou 'Agroecológico' e adiciona a frase apropriada
                    // Verifica se é orgânico e adiciona a imagem apropriada
                    if (isOrganico === true) {
                        // Adiciona a imagem com o tamanho desejado
                        loteLi.innerHTML += "<img src='icons/logo_produto_organico.png' alt='Orgânico' style='width: 150px'>";
                    } else {
                        // Adiciona a linha de tipo de cultivo apenas se não for orgânico
                        if (tipoCultivo === 'Orgânico' || tipoCultivo === 'Agroecológico') {
                            loteLi.innerHTML += "<span class='bullet'>Tipo de Cultivo:</span> Cultivado de forma orgânica/agroecológica sem uso de agroquímicos.<br>";
                        } else {
                            loteLi.innerHTML += "<span class='bullet'>Tipo de Cultivo:</span> " + tipoCultivo + "<br>";
                        }
                    }

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
        });
    });
}

// Função para adicionar marcadores personalizados nos pontos de origem e destino
function addCustomMarkers(start, end) {
    addMarker(start, 'icons/marker_rastech.png', 100); // Adiciona marcador personalizado no ponto de origem
    addMarker(end, 'icons/marker_house.png', 100); // Adiciona marcador personalizado no ponto de destino
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
