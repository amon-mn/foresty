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
            const address = userData.street + ', ' + userData.neighborhood + ' - <br>' + userData.city + ', ' + userData.state + ' - ' + userData.cep;
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
                const atividades = loteDoc.data().atividades;

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

                function obterDetalhesAgrotoxico(atividades) {
                    nomePraga = null;
                    quantidadePraga = null;
                    unidadePraga = null;

                    nomeSolo = null;
                    quantidadeSolo = null;

                    nomeDoencas = null;
                    quandidadeDoencas = null;

                    nomeAdubacao = null;
                    quantidadeAdubacao = null;

                    nomeCapina = null;
                    quantidadeCapina = null;

                    if (atividades && atividades.length > 0) {
                        for (let i = 0; i < atividades.length; i++) {
                            const atividade = atividades[i];
                            if (atividade.manejoPragas && atividade.manejoPragas.nomeAgrotoxico !== "") {
                                const manejoPragas = atividade.manejoPragas;
                                nomePraga = manejoPragas.nomeAgrotoxico;
                                quantidadePraga = manejoPragas.quantidadeAplicadaAgrotoxico;
                                unidadePraga = manejoPragas.unidadeAplicadaAgrotoxico;
                            }
                            if (atividade.preparoSolo && atividade.preparoSolo.produtoUtilizado !== "") {
                                const preparoSolo = atividade.preparoSolo;
                                nomeSolo = preparoSolo.produtoUtilizado;
                                quantidadeSolo = preparoSolo.doseAplicada;
                            }
                            if (atividade.manejoDoencas && atividade.manejoDoencas.nomeDoenca !== "" && atividade.manejoDoencas.tipoVetor == "Químico") {
                                const manejoDoencas = atividade.manejoDoencas;
                                nomeDoencas = manejoDoencas.produtoUtilizado;
                                quandidadeDoencas = manejoDoencas.doseAplicada;
                            }
                            if (atividade.adubacaoCobertura && atividade.adubacaoCobertura.produtoUtilizado != "" && atividade.adubacaoCobertura.tipoAdubacao == "Química") {
                                const adubacaoCobertura = atividade.adubacaoCobertura;
                                nomeAdubacao = adubacaoCobertura.produtoUtilizado;
                                quantidadeAdubacao = adubacaoCobertura.doseAplicada;
                            }
                            if (atividade.capina && atividade.capina.nomeProduto !== "" && atividade.capina.tipo == "Química") {
                                const capina = atividade.capina;
                                nomeCapina = capina.nomeProduto;
                                quantidadeCapina = capina.quantidadeAplicada;
                            }
                        }
                    }

                    return {
                        nomePraga,
                        quantidadePraga,
                        unidadePraga,

                        nomeSolo,
                        quantidadeSolo,

                        nomeDoencas,
                        quandidadeDoencas,

                        nomeAdubacao,
                        quantidadeAdubacao,

                        nomeCapina,
                        quantidadeCapina,
                    };
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
                const detalhesAgrotoxico = obterDetalhesAgrotoxico(atividades); // Obter detalhes do agrotóxico

                loteLi.innerHTML =
                    "<br><span class='bullet'>Produto</span><br>" +
                    "<span>" + nomeProduto + "</span><br><br>" +
                    "<span class='bullet'>Quantidade</span><br>" +
                    "<span>" + peso + "  </span><span class='bullet'> </span><span>" + unidade + "</span><br><br>" +
                    "<span class='bullet'>ID do Lote</span><br>" +
                    "<span>" + batchId + "</span><br><br>" +
                    "<span class='bullet'>Nome da Propriedade</span><br>" +
                    "<span>" + propertyName + "</span><br><br>" +
                    "<span class='bullet'>Endereço</span><br>" +
                    "<span>" + address + "</span><br><br>" +
                    "<span class='bullet'>CPF/CNPJ</span><br>" +
                    "<span>" + mascararCpfCnpj(cpf) + "</span><br><br>" +
                    "<span class='bullet'>Data de Plantio</span><br>" +
                    "<span>" + formatarData(dataDaAtividade) + "</span><br><br>" +
                    "<span class='bullet'>Data da Colheita</span><br>" +
                    "<span>" + formatarData(dataDaColheita) + "</span><br><br>";

                // Verifica se o tipo de cultivo é 'Orgânico' ou 'Agroecológico' e adiciona a frase apropriada
                // Verifica se é orgânico e adiciona a imagem apropriada
                if (isOrganico === true) {
                    loteLi.innerHTML += "<img src='icons/logo_produto_organico.png' alt='Orgânico' class='organic-image'>";
                } else {
                    // Adiciona a linha de tipo de cultivo apenas se não for orgânico
                    if (tipoCultivo === 'Orgânico' || tipoCultivo === 'Agroecológico') {
                        loteLi.innerHTML += "<span class='bullet'>Tipo de Cultivo</span><br>";
                        loteLi.innerHTML += "<span>Cultivado de forma orgânica/agroecológica<br> sem uso de agroquímicos.</span><br><br>";
                    } else {
                        loteLi.innerHTML += "<span class='bullet'>Tipo de Cultivo</span><br>";
                        loteLi.innerHTML += "<span>" + tipoCultivo + "</span><br><br>";
                        loteLi.innerHTML += "<span class='bullet'>Data de Aplicação</span><br>";
                        loteLi.innerHTML += "<span>" + formatarData(dataDaAtividade) + "</span><br><br>";
                        if (nomePraga != null) {
                            loteLi.innerHTML += "<span class='bullet'>Tipo de Atividade</span><br>";
                            loteLi.innerHTML += "<span>" + 'Manejo de Pragas' + "</span><br><br>";

                            loteLi.innerHTML += "<span class='bullet'>Agrotóxico Aplicado</span><br>";
                            loteLi.innerHTML += "<span>" + detalhesAgrotoxico.nomePraga + "</span><br><br>";

                            loteLi.innerHTML += "<span class='bullet'>Quantidade Aplicada</span><br>";
                            loteLi.innerHTML += "<span>" + detalhesAgrotoxico.quantidadePraga + "  </span><span class='bullet'> </span><span>" + detalhesAgrotoxico.unidadePraga + "</span><br><br>";
                        }
                        if (nomeSolo != null) {
                            loteLi.innerHTML += "<span class='bullet'>Tipo de Atividade</span><br>";
                            loteLi.innerHTML += "<span>" + 'Preparo de Solo' + "</span><br><br>";

                            loteLi.innerHTML += "<span class='bullet'>Adubação pré-plantio</span><br>";
                            loteLi.innerHTML += "<span>" + 'Química' + "</span><br><br>";

                            loteLi.innerHTML += "<span class='bullet'>Produto Utilizado</span><br>";
                            loteLi.innerHTML += "<span>" + detalhesAgrotoxico.nomeSolo + "</span><br><br>";

                            loteLi.innerHTML += "<span class='bullet'>Dose Aplicada</span><br>";
                            loteLi.innerHTML += "<span>" + detalhesAgrotoxico.quantidadeSolo + "</span><br><br>";
                        }
                        if (nomeDoencas != null) {
                            loteLi.innerHTML += "<span class='bullet'>Tipo de Atividade</span><br>";
                            loteLi.innerHTML += "<span>" + 'Manejo de Doenças' + "</span><br><br>";

                            loteLi.innerHTML += "<span class='bullet'>Controle de vetores</span><br>";
                            loteLi.innerHTML += "<span>" + 'Químico' + "</span><br><br>";

                            loteLi.innerHTML += "<span class='bullet'>Produto Utilizado</span><br>";
                            loteLi.innerHTML += "<span>" + detalhesAgrotoxico.nomeDoencas + "</span><br><br>";
                            loteLi.innerHTML += "<span class='bullet'>Dose Aplicada</span><br>";
                            loteLi.innerHTML += "<span>" + detalhesAgrotoxico.quandidadeDoencas + "</span><br><br>";
                        }
                        if (nomeAdubacao != null) {
                            loteLi.innerHTML += "<span class='bullet'>Tipo de Atividade</span><br>";
                            loteLi.innerHTML += "<span>" + 'Adubação de Cobertura' + "</span><br><br>";

                            loteLi.innerHTML += "<span class='bullet'>Adubação pós-plantio</span><br>";
                            loteLi.innerHTML += "<span>" + 'Química' + "</span><br><br>";

                            loteLi.innerHTML += "<span class='bullet'>Produto Utilizado</span><br>";
                            loteLi.innerHTML += "<span>" + detalhesAgrotoxico.nomeAdubacao + "</span><br><br>";

                            loteLi.innerHTML += "<span class='bullet'>Dose Aplicada</span><br>";
                            loteLi.innerHTML += "<span>" + detalhesAgrotoxico.quantidadeAdubacao + "</span><br><br>";
                        }
                        if (nomeCapina != null) {
                            loteLi.innerHTML += "<span class='bullet'>Tipo de Atividade</span><br>";
                            loteLi.innerHTML += "<span>" + 'Capina' + "</span><br><br>";

                            loteLi.innerHTML += "<span class='bullet'>Tipo de Capina</span><br>";
                            loteLi.innerHTML += "<span>" + 'Química' + "</span><br><br>";

                            loteLi.innerHTML += "<span class='bullet'>Produto Utilizado</span><br>";
                            loteLi.innerHTML += "<span>" + detalhesAgrotoxico.nomeCapina + "</span><br><br>";

                            loteLi.innerHTML += "<span class='bullet'>Dose Aplicada</span><br>";
                            loteLi.innerHTML += "<span>" + detalhesAgrotoxico.quantidadeCapina + "</span><br><br>";
                        }
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
    google.maps.event.addListenerOnce(map, 'tilesloaded', function () {
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