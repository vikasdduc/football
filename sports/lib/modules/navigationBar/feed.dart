import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Model/Feed.dart';
import '../../Networking/AccessNetwork.dart';
import '../../constance/constance.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  List<feed> list = List<feed>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.color,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of('Feed'),
          style: Theme.of(context).textTheme.caption.copyWith(
                color: Colors.white,
                letterSpacing: 0.6,
            fontSize: 18,
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
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 20),
          //   child: Icon(
          //     Icons.search,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (cont,index){
                  var data = list[index];
                  return GestureDetector(
                    onTap: ()async{
                      if (!await launch('${data.url}'))
                      throw 'Could not launch ${data.url}';
                    },
                    child: Container(
                      // height: 600,
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).disabledColor.withOpacity(0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:Colors.white,
                                  child: Image.asset(
                                    ConstanceData.finalLogo,
                                    // color: Colors.white,
                                    height: 20,
                                    width: 20,
                                    // size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of('Apna Team'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .color,
                                            letterSpacing: 0.6,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Icon(
                                          Icons.check_circle,
                                          color: Theme.of(context).primaryColor,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width:5,
                                        ),
                                        Text(
                                          AppLocalizations.of('${data.ago}'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .color,
                                            letterSpacing: 0.6,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                // Icon(
                                //   Icons.more_vert,
                                //   color: Theme.of(context).textTheme.headline6.color,
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14),
                            child: Text(
                              AppLocalizations.of(
                                  '${data.description}'),
                              style: Theme.of(context).textTheme.caption.copyWith(
                                color:
                                Theme.of(context).textTheme.headline6.color,
                                letterSpacing: 0.6,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 14),
                          //   child: Text(
                          //     AppLocalizations.of('#Fantancy #KxIpvDc'),
                          //     style: Theme.of(context).textTheme.caption.copyWith(
                          //       color:
                          //       Theme.of(context).textTheme.headline6.color,
                          //       letterSpacing: 0.6,
                          //       fontSize: 12,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              data.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                          // Container(
                          //   height: 40,
                          //   width: MediaQuery.of(context).size.width,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(left: 50, right: 50),
                          //     child: Row(
                          //       children: [
                          //         Icon(
                          //           FontAwesomeIcons.smile,
                          //           size: 16,
                          //         ),
                          //         SizedBox(
                          //           width: 5,
                          //         ),
                          //         Text(
                          //           AppLocalizations.of('React'),
                          //           style:
                          //           Theme.of(context).textTheme.caption.copyWith(
                          //             color: Theme.of(context)
                          //                 .textTheme
                          //                 .headline6
                          //                 .color,
                          //             letterSpacing: 0.6,
                          //             fontSize: 12,
                          //           ),
                          //         ),
                          //         Expanded(child: SizedBox()),
                          //         Icon(
                          //           Icons.share,
                          //           size: 16,
                          //         ),
                          //         SizedBox(
                          //           width: 5,
                          //         ),
                          //         Text(
                          //           AppLocalizations.of('Share'),
                          //           style:
                          //           Theme.of(context).textTheme.caption.copyWith(
                          //             color: Theme.of(context)
                          //                 .textTheme
                          //                 .headline6
                          //                 .color,
                          //             letterSpacing: 0.6,
                          //             fontSize: 12,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         color: Color(0xffEFEFF4),
            //         child: Padding(
            //           padding: const EdgeInsets.only(
            //               left: 14, right: 14, top: 14, bottom: 14),
            //           child: Column(
            //             children: [
            //               Row(
            //                 children: [
            //                   Text(
            //                     AppLocalizations.of('Profiles To Follow'),
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .caption
            //                         .copyWith(
            //                       color: Colors.black87,
            //                       letterSpacing: 0.6,
            //                       fontSize: 14,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   Expanded(child: SizedBox()),
            //                   Text(
            //                     AppLocalizations.of('View All'),
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .caption
            //                         .copyWith(
            //                       color: Colors.black87,
            //                       letterSpacing: 0.6,
            //                       fontSize: 10,
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: 5,
            //                   ),
            //                   Icon(
            //                     Icons.arrow_forward_ios,
            //                     color: Colors.black87,
            //                     size: 10,
            //                   )
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Container(
            //                 height: 200,
            //                 child: ListView(
            //                   scrollDirection: Axis.horizontal,
            //                   children: [
            //                     card(
            //                       AppLocalizations.of('Fantancy'),
            //                       AppLocalizations.of('Official'),
            //                     ),
            //                     card(
            //                       AppLocalizations.of('Fantancy'),
            //                       AppLocalizations.of('Official'),
            //                     ),
            //                     card(
            //                       AppLocalizations.of('Fantancy'),
            //                       AppLocalizations.of('Official'),
            //                     ),
            //                     card(
            //                       AppLocalizations.of('Fantancy'),
            //                       AppLocalizations.of('Official'),
            //                     ),
            //                     card(
            //                       AppLocalizations.of('Fantancy'),
            //                       AppLocalizations.of('Official'),
            //                     ),
            //                     card(
            //                       AppLocalizations.of('Fantancy'),
            //                       AppLocalizations.of('Official'),
            //                     ),
            //                     card(
            //                       AppLocalizations.of('Fantancy'),
            //                       AppLocalizations.of('Official'),
            //                     ),
            //                   ],
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // Container(
            //   color: Theme.of(context).appBarTheme.color,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       SizedBox(
            //         height: 15,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 20, right: 20),
            //         child: Row(
            //           children: [
            //             CircleAvatar(
            //               backgroundColor: Theme.of(context).primaryColor,
            //               child: Icon(
            //                 FontAwesomeIcons.trophy,
            //                 color: Colors.white,
            //                 size: 20,
            //               ),
            //             ),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Row(
            //                   children: [
            //                     Text(
            //                       AppLocalizations.of('Fantancy'),
            //                       style: Theme.of(context)
            //                           .textTheme
            //                           .caption
            //                           .copyWith(
            //                             color: Theme.of(context)
            //                                 .textTheme
            //                                 .headline6
            //                                 .color,
            //                             letterSpacing: 0.6,
            //                             fontSize: 14,
            //                             fontWeight: FontWeight.bold,
            //                           ),
            //                     ),
            //                     SizedBox(
            //                       width: 2,
            //                     ),
            //                     Icon(
            //                       Icons.check_circle,
            //                       color: Theme.of(context).primaryColor,
            //                       size: 12,
            //                     ),
            //                   ],
            //                 ),
            //                 Text(
            //                   AppLocalizations.of('34 min. ago'),
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .caption
            //                       .copyWith(
            //                         color: Theme.of(context)
            //                             .textTheme
            //                             .bodyText2
            //                             .color,
            //                         letterSpacing: 0.6,
            //                         fontSize: 12,
            //                       ),
            //                 ),
            //               ],
            //             ),
            //             Expanded(child: SizedBox()),
            //             Icon(
            //               Icons.more_vert,
            //               color: Theme.of(context).textTheme.bodyText2.color,
            //             ),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: 15,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 14),
            //         child: Text(
            //           AppLocalizations.of(
            //               'He has been a part of the Fantancy Team for the last 3\noccasions'),
            //           style: Theme.of(context).textTheme.caption.copyWith(
            //                 color:
            //                     Theme.of(context).textTheme.bodyText2.color,
            //                 letterSpacing: 0.6,
            //                 fontSize: 12,
            //               ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 20,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 14),
            //         child: Text(
            //           AppLocalizations.of(
            //               'Will M. Shami feature in your Fantancy tonight?\n#FantacyIPL #FantacyPics #KXIPvDC'),
            //           style: Theme.of(context).textTheme.caption.copyWith(
            //                 color:
            //                     Theme.of(context).textTheme.bodyText2.color,
            //                 letterSpacing: 0.6,
            //                 fontSize: 12,
            //               ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 15,
            //       ),
            //       Container(
            //         height: 200,
            //         width: MediaQuery.of(context).size.width,
            //         child: Image.asset(
            //           ConstanceData.slider2,
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //       Container(
            //         height: 40,
            //         width: MediaQuery.of(context).size.width,
            //         child: Padding(
            //           padding: const EdgeInsets.only(left: 50, right: 50),
            //           child: Row(
            //             children: [
            //               Icon(
            //                 FontAwesomeIcons.smile,
            //                 size: 16,
            //               ),
            //               SizedBox(
            //                 width: 5,
            //               ),
            //               Text(
            //                 AppLocalizations.of('React'),
            //                 style:
            //                     Theme.of(context).textTheme.caption.copyWith(
            //                           color: Theme.of(context)
            //                               .textTheme
            //                               .bodyText2
            //                               .color,
            //                           letterSpacing: 0.6,
            //                           fontSize: 12,
            //                         ),
            //               ),
            //               Expanded(child: SizedBox()),
            //               Icon(
            //                 Icons.share,
            //                 size: 16,
            //               ),
            //               SizedBox(
            //                 width: 5,
            //               ),
            //               Text(
            //                 AppLocalizations.of('Share'),
            //                 style:
            //                     Theme.of(context).textTheme.caption.copyWith(
            //                           color: Theme.of(context)
            //                               .textTheme
            //                               .bodyText2
            //                               .color,
            //                           letterSpacing: 0.6,
            //                           fontSize: 12,
            //                         ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       Divider(),
            //       Container(
            //         height: 40,
            //         width: MediaQuery.of(context).size.width,
            //         child: Padding(
            //           padding: const EdgeInsets.only(left: 30, right: 50),
            //           child: Row(
            //             children: [
            //               Icon(
            //                 FontAwesomeIcons.smile,
            //                 size: 16,
            //               ),
            //               Icon(
            //                 FontAwesomeIcons.smile,
            //                 size: 16,
            //               ),
            //               Icon(
            //                 FontAwesomeIcons.smile,
            //                 size: 16,
            //               ),
            //               SizedBox(
            //                 width: 5,
            //               ),
            //               Text(
            //                 AppLocalizations.of('474 people'),
            //                 style:
            //                     Theme.of(context).textTheme.caption.copyWith(
            //                           color: Theme.of(context)
            //                               .textTheme
            //                               .bodyText2
            //                               .color,
            //                           letterSpacing: 0.6,
            //                           fontSize: 12,
            //                         ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget card(
    String txt1,
    String txt2,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Container(
          height: 60,
          width: 130,
          color: Theme.of(context).appBarTheme.color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  FontAwesomeIcons.trophy,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      txt1,
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).textTheme.headline6.color,
                            letterSpacing: 0.6,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                    size: 12,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                txt2,
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.bodyText2.color,
                      letterSpacing: 0.6,
                      fontSize: 12,
                    ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 25,
                width: 80,
                decoration: BoxDecoration(
                  color: Color(0xff0E2F56),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of('FOLLOW'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.white,
                          letterSpacing: 0.6,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() {
    access_network().get_feed_details().then((_){
      setState(() {
        list = _;
      });
    });
  }
}
