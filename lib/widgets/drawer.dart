import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lenguas/screens/language_select.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:ionicons/ionicons.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<AppState>(
        builder: (context, state, child) => ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('${UserAccount.displayName ?? ''}',
                  style: GoogleFonts.fredokaOne()),
              accountEmail: Text('${UserAccount.email ?? ''}'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: UserAccount.profilePic,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).accentColor,
              ),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Cambiar idioma'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Scaffold(
                    body: LanguageSelectPage(
                      title: 'Selecciona el idioma',
                      onLanguageSelect: (language) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ));
              },
            ),
            ListTile(
                leading: Icon(Icons.update),
                title: Text('Actualizar base de datos'),
                subtitle: Text('Última act.: bla bla bla'),
                onTap: () {
                  Provider.of<AppState>(context, listen: false)
                      .updateLanguageData();
                }),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Ajustes'),
              onTap: () {
                Navigator.of(context).pushNamed('/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Compartir aplicación'),
              onTap: () {
                Share.share(
                    '¿Sabías que hay una app donde puedes acercarte a nuestras lenguas indígenas? ¡Próximamente podrás aprenderlas!\n\nDescárgala en proyecto-miyotl.web.app/descarga');
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Enviar retroalimentación'),
              onTap: () {
                launch(
                  'mailto:miyotl@googlegroups.com?subject=Retroalimentación sobre app',
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Acerca de'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: CircleAvatar(
                    backgroundImage: AssetImage('img/icon-full-new.png'),
                    backgroundColor: Colors.white,
                  ),
                  applicationLegalese:
                      '''Fundadores y mesa directiva: Emilio Álvarez (CEO), Gabriel Rodríguez (CTO), Daniela Madrigal (COO), Carter Dieguiño (CFO y abogado), 
Código: Gabriel Rodríguez
Dibujos y CMO: Camila Varela
Con amor desde Chapingo ❤️''',
                  applicationVersion: 'versión inicial (beta)',
                  children: [
                    ListTile(
                      leading: Icon(Icons.people),
                      title: Text('Ver lista completa de colaboradores'),
                      onTap: () => launch(
                        'https://proyecto-miyotl.web.app/acerca_de',
                        forceWebView: true,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Ionicons.logo_facebook),
                      title: Text('Síguenos en Facebook'),
                      onTap: () => launch('https://fb.me/MiyotlApp'),
                    ),
                    ListTile(
                      leading: Icon(Ionicons.logo_twitter),
                      title: Text('Síguenos en Twitter'),
                      onTap: () => launch('https://twitter.com/MiyotlApp'),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Mándanos un correo'),
                      onTap: () => launch('mailto:miyotl@googlegroups.com'),
                    ),
                    ListTile(
                      leading: Icon(Ionicons.logo_github),
                      title: Text('Colabora en GitHub'),
                      onTap: () => launch('https://github.com/miyotl/miyotl'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
