import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Idealização:',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 72.0),
                  child: Divider(),
                ),
                Column(children: [
                  Text(
                    'Dra. Therezinha de Jesus Pinto Fraxe',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Dr. Janderlin Patrick Rodrigues Carneiro',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Dra. Monica Suani Barbosa da Costa',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Dr. Vinicius Verona Carvalho Gonçalves',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Dr. Jaisson Miyosi Oka',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Dra. Gislany Mendonça de Sena',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ]),
                Text(
                  'Apoio:',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 72.0),
                  child: Divider(),
                ),
                Image.asset(
                  'lib/assets/fapeam.png', // Substitua pelo caminho da primeira imagem
                  width: 70,
                  height: 70,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Projeto',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' • '),
                      TextSpan(
                        text:
                            'C&T AGROFLORESTA: Uso de tecnologias para a redução e para redução do desmatamento e inclusão socioprodutiva de comunidades rurais em situação de vulnerabilidade socioeconômica',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4), // Espaço entre os textos
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Edital',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' • '),
                      TextSpan(
                        text: 'EDITAL N. 010/2021- CT&I ÁREAS PRIORITÁRIAS',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4), // Espaço entre os textos
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Coordenador',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' • '),
                      TextSpan(
                        text: 'Therezinha de Jesus Pinto Fraxe/FAPEAM',
                      ),
                    ],
                  ),
                ),
                Text(
                  'Parceria:',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 72.0),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/ufam_logo.png', // Substitua pelo caminho da primeira imagem
                      width: 70,
                      height: 70,
                    ),
                    SizedBox(width: 32),
                    Image.asset(
                      'lib/assets/acariquara_logo.png', // Substitua pelo caminho da segunda imagem
                      width: 70,
                      height: 70,
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Desenvolvimento:',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 72.0),
                  child: Divider(),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ProfileCard(
                    urlImage: 'lib/assets/profile_amaotech.jpg',
                    title: 'AMAO Tech',
                    subTitle: 'Startup P, D & I',
                    description:
                        'Somos uma startup de Pesquisa e Desenvolvimento focada em utilizar tecnologia de ponta para otimizar processos e soluções na região amazônica',
                    icons: [FontAwesomeIcons.instagram],
                    redirectUrls: ['https://www.instagram.com/amao.tech/'],
                    iconColors: [Color.fromARGB(255, 188, 42, 141)],
                  ),
                ),
                /*
                CarouselSlider(
                  options: CarouselOptions(
                    height: 475,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                  ),
                  items: [
                    
                    ProfileCard(
                      urlImage: 'lib/assets/profile_henriquebarkett.jpg',
                      title: 'Henrique Barkett',
                      subTitle: 'Mobile Developer',
                      description:
                          'Quero crescer e evoluir como desenvolvedor de software, contribuindo para projetos inovadores e fazendo a diferença no mundo da tecnologia. Busco oportunidades para aplicar minha paixão pela programação e criar soluções que impactem positivamente a vida das pessoas.',
                      icons: [
                        FontAwesomeIcons.github,
                        FontAwesomeIcons.linkedin
                      ],
                      redirectUrls: [
                        'https://github.com/henriquebarkett/',
                        'https://www.linkedin.com/in/henriquebarkett/'
                      ],
                      iconColors: [Colors.black, Colors.blue],
                    ),
                    ProfileCard(
                      urlImage: 'lib/assets/profile_amonmn.jpg',
                      title: 'Amon Menezes',
                      subTitle: 'Mobile Developer',
                      description:
                          'Desenvolvedor Android com 3 anos de experiência em Java e Flutter, focado em criar aplicativos inovadores. Comprometido em aprender novas tecnologias, resolver desafios e contribuir para uma equipe que busca constantemente soluções excepcionais.',
                      icons: [
                        FontAwesomeIcons.github,
                        FontAwesomeIcons.linkedin
                      ],
                      redirectUrls: [
                        'https://github.com/amon-mn/',
                        'https://www.linkedin.com/in/amonmenezesnegreiros/'
                      ],
                      iconColors: [Colors.black, Colors.blue],
                    ),
                    
                  ],
                ),
                */
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String urlImage;
  final String title;
  final String subTitle;
  final String description;
  final List<String> redirectUrls;
  final List<Color> iconColors;
  final List<IconData> icons; // Adicionado o parâmetro para os ícones

  ProfileCard({
    required this.urlImage,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.redirectUrls,
    required this.iconColors,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white.withOpacity(0.90),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 60.0,
              backgroundImage: AssetImage(urlImage),
            ),
            SizedBox(height: 16.0),
            Text(
              title,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            Text(
              subTitle,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5),
            ),
            SizedBox(height: 16.0),
            Text(
              description,
              style: TextStyle(fontSize: 11.0),
              textAlign: TextAlign.justify,
            ),
            Divider(),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (icons.isNotEmpty)
                  RoundedSocialIcon(
                    icon: icons[0],
                    backgroundColor: iconColors[0],
                    redirectUrl: redirectUrls[0],
                  ),
                if (icons.length == 2)
                  RoundedSocialIcon(
                    icon: icons[1],
                    backgroundColor: iconColors[1],
                    redirectUrl: redirectUrls[1],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedSocialIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final String redirectUrl;

  RoundedSocialIcon({
    required this.icon,
    required this.backgroundColor,
    required this.redirectUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchURL(redirectUrl);
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
