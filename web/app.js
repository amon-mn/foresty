// Configure o Firebase
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
  
  // Inicialize o Firestore
  var db = firebase.firestore();
  
  // Referência para a coleção 'users'
  var usersRef = db.collection('users');
  
  // Função para consultar QR Code
  function consultarQrCode() {
    window.location.href = "produto.html";
  }
  
  // Função para carregar os usuários e lotes
function carregarUsuariosELotes() {
    usersRef.get().then((querySnapshot) => {
        var usersList = document.getElementById('users');
        querySnapshot.forEach((userDoc) => {
            var userName = userDoc.data().name;
            var userLi = document.createElement('li');
            userLi.textContent = "Usuário: " + userName;
            usersList.appendChild(userLi);

            // Referência para a subcoleção 'lotes' do usuário atual
            var lotesRef = userDoc.ref.collection('lotes');
            lotesRef.get().then((lotesQuerySnapshot) => {
                lotesQuerySnapshot.forEach((loteDoc) => {
                    // Mapear os documentos de lote para objetos ProductBatch
                    var loteData = loteDoc.data();
                    var lote = new ProductBatch({
                        id: loteData.id,
                        nomeLote: loteData.nomeLote,
                        largura: loteData.largura,
                        comprimento: loteData.comprimento,
                        area: loteData.area,
                        latitude: loteData.latitude,
                        longitude: loteData.longitude,
                        finalidade: loteData.finalidade,
                        outraFinalidade: loteData.outraFinalidade,
                        ambiente: loteData.ambiente,
                        outroAmbiente: loteData.outroAmbiente,
                        tipoCultivo: loteData.tipoCultivo,
                        outroTipoCultivo: loteData.outroTipoCultivo,
                        nomeProduto: loteData.nomeProduto,
                        atividades: loteData.atividades.map((activity) => new BatchActivity(activity)),
                        colheita: loteData.colheita ? new Harvest(loteData.colheita) : null,
                        qrCode: loteData.qrCode ? new BatchQrCode(loteData.qrCode) : null
                    });

                    var loteLi = document.createElement('li');
                    loteLi.textContent = "Nome do Lote: " + lote.nomeLote;
                    loteLi.classList.add('lote');
                    userLi.appendChild(loteLi);
                });
            }).catch((error) => {
                console.error("Erro ao obter lotes do usuário " + userDoc.id + ": ", error);
            });
        });
    }).catch((error) => {
        console.error("Erro ao obter usuários: ", error);
    });
}

/*
// Função para carregar as informações dos produtores do banco de dados
function carregarInformacoes() {
    // Objeto para armazenar as informações dos produtos e produtores
    var informacoes = {
        produtos: [],
        produtores: []
    };

    // Obtendo os produtores do banco de dados
    return produtoresRef.get()
        .then((querySnapshot) => {
            // Iterando sobre cada documento de produtor
            querySnapshot.forEach((produtorDoc) => {
                var produtorData = produtorDoc.data();
                var produtor = {
                    cpf: produtorData.cpf,
                    endereco: produtorData.endereco,
                    email: produtorData.email
                };
                informacoes.produtores.push(produtor);
            });

            // Obtendo os lotes dos produtores
            return Promise.all(informacoes.produtores.map((produtor) => {
                // Referência para a subcoleção 'lotes' do produtor atual
                var lotesRef = produtoresRef.doc(produtor.id).collection('lotes');
                return lotesRef.get()
                    .then((lotesQuerySnapshot) => {
                        // Iterando sobre cada documento de lote
                        lotesQuerySnapshot.forEach((loteDoc) => {
                            var loteData = loteDoc.data();
                            var produto = {
                                nomeProduto: loteData.nomeProduto,
                                idLote: loteData.id,
                                peso: loteData.qrCode.peso,
                                unidade: loteData.qrCode.unidade
                            };
                            informacoes.produtos.push(produto);
                        });
                    });
            }));
        })
        .then(() => {
            // Retornando o objeto com as informações dos produtos e produtores
            return informacoes;
        })
        .catch((error) => {
            console.error("Erro ao carregar informações:", error);
            throw error;
        });
}

// Chamando a função para carregar as informações quando a página HTML é carregada
document.addEventListener('DOMContentLoaded', function () {
    carregarInformacoes()
        .then((informacoes) => {
            // Atualizando os elementos HTML com as informações carregadas
            document.getElementById('productName').textContent = informacoes.produtos[0].nomeProduto;
            document.getElementById('batchId').textContent = informacoes.produtos[0].idLote;
            document.getElementById('qrCodeInfo').textContent = informacoes.produtos[0].peso + ' ' + informacoes.produtos[0].unidade;
            document.getElementById('cpf').textContent = informacoes.produtores[0].cpf;
            document.getElementById('endereco').textContent = informacoes.produtores[0].endereco;
            document.getElementById('email').textContent = informacoes.produtores[0].email;
        })
        .catch((error) => {
            console.error("Erro ao carregar informações:", error);
        });
});
*/

// Função para carregar os usuários e lotes do banco de dados
async function carregarUsuariosELotes() {
    try {
        const querySnapshot = await usersRef.get();
        const produtos = [];
        const produtores = [];

        querySnapshot.forEach((userDoc) => {
            const userData = userDoc.data();

            // Informações do produtor
            const produtor = {
                cpf: userData.cpf,
                endereco: userData.endereco,
                email: userData.email
            };
            produtores.push(produtor);

            // Referência para a subcoleção 'lotes' do usuário atual
            const lotesRef = userDoc.ref.collection('lotes');
            lotesRef.get().then((lotesQuerySnapshot) => {
                lotesQuerySnapshot.forEach((loteDoc) => {
                    // Mapear os documentos de lote para objetos ProductBatch
                    const loteData = loteDoc.data();
                    const produto = {
                        idLote: loteData.id,
                        nomeProduto: loteData.nomeProduto,
                        peso: loteData.qrCode ? loteData.qrCode.peso : '',
                        unidade: loteData.qrCode ? loteData.qrCode.unidade : ''
                    };
                    produtos.push(produto);
                });
            }).catch((error) => {
                console.error("Erro ao obter lotes do usuário " + userDoc.id + ": ", error);
            });
        });

        // Retornando as informações dos produtos e produtores
        return { produtos, produtores };
    } catch (error) {
        console.error("Erro ao obter usuários: ", error);
        return null;
    }
}

  
  // Chama a função para carregar usuários e lotes quando a página carregar
  document.addEventListener('DOMContentLoaded', function () {
    carregarUsuariosELotes();
  });
  