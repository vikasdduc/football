import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/modules/home/drawer/more/help.dart';
import 'package:fantacySports/modules/home/drawer/more/inviteCode.dart';
import 'package:fantacySports/modules/home/drawer/more/redirectPage.dart';
import 'package:fantacySports/modules/home/drawer/more/whatsappUpdate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpDesk extends StatefulWidget {
  @override
  _HelpDeskState createState() => _HelpDeskState();
}

class _HelpDeskState extends State<HelpDesk> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.color,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of('Help Desk'),
          style: Theme.of(context).textTheme.caption.copyWith(
                color: Colors.white,
                letterSpacing: 0.6,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey.shade300,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          left: 10,
          top: 10,
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Topics',
              style: Theme.of(context).textTheme.caption.copyWith(
                color: Colors.black,
                letterSpacing: 0.6,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      container(
                          AppLocalizations.of('Community Guidelines'),
                          Icons.calendar_view_day_outlined, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RedirectPage('Community Guidelines','https://theapnateam.com/community-guidelines.html'),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 4,
                      ),
                      container(
                        AppLocalizations.of('Enter Contest Code'),
                        Icons.code_rounded,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InviteCodePage(),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      container(
                        AppLocalizations.of('WhatsApp Updates'),
                        FontAwesomeIcons.whatsapp,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WhatsAppUpdatePage(),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      container(
                        AppLocalizations.of('How To Play'),
                        Icons.gamepad,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RedirectPage('How To Play','https://theapnateam.com/play.html'),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      // container(
                      //   AppLocalizations.of('Jobs'),
                      //   Icons.backpack,
                      //       () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) =>
                      //             RedirectPage('Jobs'),
                      //       ),
                      //     );
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 4,
                      // ),
                      container(
                        AppLocalizations.of('About Us'),
                        FontAwesomeIcons.trophy,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RedirectPage('About Us','https://theapnateam.com/about.html'),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      container(
                        AppLocalizations.of('Legality'),
                        Icons.calendar_view_day_outlined,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RedirectPage('Legality','https://theapnateam.com/legality.html'),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      container(
                        AppLocalizations.of('Refund'),
                        Icons.money,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RedirectPage('Refund','https://theapnateam.com/refund.html'),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      container(
                        AppLocalizations.of('Terms and\tConditions'),
                        Icons.file_present,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RedirectPage('Terms and Conditions','https://theapnateam.com/terms-condition.html'),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      container(
                        AppLocalizations.of('Privacy Policy'),
                        Icons.file_present,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RedirectPage('Privacy Policy','https://theapnateam.com/privacy-policy.html'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget container(String txt1, IconData icon, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: InkWell(
            onTap: () {
              onTap();
            },
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).textTheme.headline6.color,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  txt1,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).textTheme.headline6.color,
                        letterSpacing: 0.6,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(url) async {
    if (!await launch(url))
      throw 'Could not launch ${url}';
  }
}
