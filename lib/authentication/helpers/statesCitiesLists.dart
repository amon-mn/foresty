class StatesAndCities {
  List<String> statesList = [
    'Acre',
    'Alagoas',
    'Amapá',
    'Amazonas',
    'Bahia',
    'Ceará',
    'Distrito Federal',
    'Espírito Santo',
    'Goiás',
    'Maranhão',
    'Mato Grosso',
    'Mato Grosso do Sul',
    'Minas Gerais',
    'Pará',
    'Paraíba',
    'Paraná',
    'Pernambuco',
    'Piauí',
    'Rio de Janeiro',
    'Rio Grande do Norte',
    'Rio Grande do Sul',
    'Rondônia',
    'Roraima',
    'Santa Catarina',
    'São Paulo',
    'Sergipe',
    'Tocantins',
  ];
  Map<String, List<String>> citiesByState = {
    'Acre': [
      'Acrelândia',
      'Assis Brasil',
      'Brasiléia',
      'Bujari',
      'Capixaba',
      'Cruzeiro do Sul',
      'Epitaciolândia',
      'Feijó',
      'Jordão',
      'Mâncio Lima',
      'Manoel Urbano',
      'Marechal Thaumaturgo',
      'Plácido de Castro',
      'Porto Acre',
      'Porto Walter',
      'Rio Branco',
      'Rodrigues Alves',
      'Santa Rosa do Purus',
      'Sena Madureira',
      'Senador Guiomard',
      'Tarauacá',
      'Xapuri',
    ],
    'Alagoas': [
      'Água Branca',
      'Anadia',
      'Arapiraca',
      'Atalaia',
      'Barra de Santo Antônio',
      'Barra de São Miguel',
      'Batalha',
      'Belém',
      'Belo Monte',
      'Boca da Mata',
      'Branquinha',
      'Cacimbinhas',
      'Cajueiro',
      'Campestre',
      'Campo Alegre',
      'Campo Grande',
      'Canapi',
      'Capela',
      'Carneiros',
      'Chã Preta',
      'Coité do Nóia',
      'Colônia Leopoldina',
      'Coqueiro Seco',
      'Coruripe',
      'Craíbas',
      'Delmiro Gouveia',
      'Dois Riachos',
      'Estrela de Alagoas',
      'Feira Grande',
      'Feliz Deserto',
      'Flexeiras',
      'Girau do Ponciano',
      'Ibateguara',
      'Igaci',
      'Igreja Nova',
      'Inhapi',
      'Jacaré dos Homens',
      'Jacuípe',
      'Japaratinga',
      'Jaramataia',
      'Jequiá da Praia',
      'Joaquim Gomes',
      'Jundiá',
      'Junqueiro',
      'Lagoa da Canoa',
      'Limoeiro de Anadia',
      'Maceió',
      'Major Isidoro',
      'Mar Vermelho',
      'Maragogi',
      'Maravilha',
      'Marechal Deodoro',
      'Maribondo',
      'Mata Grande',
      'Matriz de Camaragibe',
      'Messias',
      'Minador do Negrão',
      'Monteirópolis',
      'Murici',
      'Novo Lino',
      'Olho d\'Água das Flores',
      'Olho d\'Água do Casado',
      'Olho d\'Água Grande',
      'Olivença',
      'Ouro Branco',
      'Palestina',
      'Palmeira dos Índios',
      'Pão de Açúcar',
      'Pariconha',
      'Paripueira',
      'Passo de Camaragibe',
      'Paulo Jacinto',
      'Penedo',
      'Piaçabuçu',
      'Pilar',
      'Pindoba',
      'Piranhas',
      'Poço das Trincheiras',
      'Porto Calvo',
      'Porto de Pedras',
      'Porto Real do Colégio',
      'Quebrangulo',
      'Rio Largo',
      'Roteiro',
      'Santa Luzia do Norte',
      'Santana do Ipanema',
      'Santana do Mundaú',
      'São Brás',
      'São José da Laje',
      'São José da Tapera',
      'São Luís do Quitunde',
      'São Miguel dos Campos',
      'São Miguel dos Milagres',
      'São Sebastião',
      'Satuba',
      'Senador Rui Palmeira',
      'Tanque d\'Arca',
      'Taquarana',
      'Teotônio Vilela',
      'Traipu',
      'União dos Palmares',
      'Viçosa',
    ],
    'Amapá': [
      'Macapá',
      'Santana',
      // Add more cities of Amapá if needed
    ],
    'Amazonas': [
      'Alvarães',
      'Amaturá',
      'Anamã',
      'Anori',
      'Apuí',
      'Atalaia do Norte',
      'Autazes',
      'Barcelos',
      'Barreirinha',
      'Benjamin Constant',
      'Beruri',
      'Boa Vista do Ramos',
      'Boca do Acre',
      'Borba',
      'Caapiranga',
      'Carauari',
      'Careiro',
      'Careiro da Várzea',
      'Coari',
      'Codajás',
      'Eirunepé',
      'Guajará',
      'Humaitá',
      'Ipixuna',
      'Iranduba',
      'Itacoatiara',
      'Itamarati',
      'Itapiranga',
      'Japurá',
      'Juruá',
      'Jutaí',
      'Lábrea',
      'Manacapuru',
      'Manaquiri',
      'Manaus',
      'Manicoré',
      'Maués',
      'Nhamundá',
      'Nova Olinda do Norte',
      'Novo Airão',
      'Novo Aripuanã',
      'Parintins',
      'Presidente Figueiredo',
      'Rio Preto da Eva',
      'Santa Isabel do Rio Negro',
      'Santo Antônio do Içá',
      'São Gabriel da Cachoeira',
      'São Paulo de Olivença',
      'São Sebastião do Uatumã',
      'Silves',
      'Tabatinga',
      'Tefé',
      'Tonantins',
      'Uarini',
      'Urucará',
      'Urucurituba',
    ],
    'Bahia': [
      'Salvador',
      'Feira de Santana',
      // Add more cities of Bahia if needed
    ],
    'Ceará': [
      'Fortaleza',
      'Caucaia',
      // Add more cities of Ceará if needed
    ],
    'Distrito Federal': [
      'Brasília',
      'Planaltina',
      // Add more cities of Distrito Federal if needed
    ],
    'Espírito Santo': [
      'Vitória',
      'Vila Velha',
      // Add more cities of Espírito Santo if needed
    ],
    'Goiás': [
      'Goiânia',
      'Aparecida de Goiânia',
      // Add more cities of Goiás if needed
    ],
    'Maranhão': [
      'São Luís',
      'Imperatriz',
      // Add more cities of Maranhão if needed
    ],
    'Mato Grosso': [
      'Cuiabá',
      'Várzea Grande',
      // Add more cities of Mato Grosso if needed
    ],
    'Mato Grosso do Sul': [
      'Campo Grande',
      'Dourados',
      // Add more cities of Mato Grosso do Sul if needed
    ],
    'Minas Gerais': [
      'Belo Horizonte',
      'Uberlândia',
      // Add more cities of Minas Gerais if needed
    ],
    'Pará': [
      'Belém',
      'Ananindeua',
      // Add more cities of Pará if needed
    ],
    'Paraíba': [
      'João Pessoa',
      'Campina Grande',
      // Add more cities of Paraíba if needed
    ],
    'Paraná': [
      'Curitiba',
      'Londrina',
      // Add more cities of Paraná if needed
    ],
    'Pernambuco': [
      'Recife',
      'Jaboatão dos Guararapes',
      // Add more cities of Pernambuco if needed
    ],
    'Piauí': [
      'Teresina',
      'Parnaíba',
      // Add more cities of Piauí if needed
    ],
    'Rio de Janeiro': [
      'Rio de Janeiro',
      'Niterói',
      // Add more cities of Rio de Janeiro if needed
    ],
    'Rio Grande do Norte': [
      'Natal',
      'Mossoró',
      // Add more cities of Rio Grande do Norte if needed
    ],
    'Rio Grande do Sul': [
      'Porto Alegre',
      'Caxias do Sul',
      // Add more cities of Rio Grande do Sul if needed
    ],
    'Rondônia': [
      'Porto Velho',
      'Ji-Paraná',
      // Add more cities of Rondônia if needed
    ],
    'Roraima': [
      'Boa Vista',
      'Caracaraí',
      // Add more cities of Roraima if needed
    ],
    'Santa Catarina': [
      'Florianópolis',
      'Joinville',
      // Add more cities of Santa Catarina if needed
    ],
    'São Paulo': [
      'São Paulo',
      'Campinas',
      // Add more cities of São Paulo if needed
    ],
    'Sergipe': [
      'Aracaju',
      'Nossa Senhora do Socorro',
      // Add more cities of Sergipe if needed
    ],
    'Tocantins': [
      'Palmas',
      'Araguaína',
      // Add more cities of Tocantins if needed
    ],
  };
}
