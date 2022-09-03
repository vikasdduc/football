import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:flutter/material.dart';

import '../../../../constance/constance.dart';

class InvitePage extends StatefulWidget {
  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          contact(
            "Aakash domadiya",
            "AKASH8287MN",
            "Level 19",
            AssetImage(ConstanceData.palyerProfilePic),
          ),
          contact(
            "Aakash domadiya",
            "AKASH8287MN",
            "Level 19",
            AssetImage(ConstanceData.palyerProfilePic),
          ),
          contact(
            "Aakash domadiya",
            "AKASH8287MN",
            "Level 19",
            AssetImage(ConstanceData.palyerProfilePic),
          ),
          contact(
            "Aakash domadiya",
            "AKASH8287MN",
            "Level 19",
            AssetImage(ConstanceData.palyerProfilePic),
          ),
          contact(
            "Aakash domadiya",
            "AKASH8287MN",
            "Level 19",
            AssetImage(ConstanceData.palyerProfilePic),
          ),
          contact(
            "Aakash domadiya",
            "AKASH8287MN",
            "Level 19",
            AssetImage(ConstanceData.palyerProfilePic),
          ),
          contact(
            "Aakash domadiya",
            "AKASH8287MN",
            "Level 19",
            AssetImage(ConstanceData.palyerProfilePic),
          ),
          contact(
            "Aakash domadiya",
            "AKASH8287MN",
            "Level 19",
            AssetImage(ConstanceData.palyerProfilePic),
          ),
          contact(
            "Aakash domadiya",
            "AKASH8287MN",
            "Level 19",
            AssetImage(ConstanceData.palyerProfilePic),
          )
        ],
      ),
    );
  }

  Widget contact(String txt1, String txt2, String txt3, AssetImage image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).appBarTheme.color,
                      backgroundImage: image),
                  InkWell(
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.call,
                        color: Theme.of(context).appBarTheme.color,
                        size: 10,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    txt1,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).textTheme.headline6.color,
                          letterSpacing: 0.6,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    txt2,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.black38,
                          letterSpacing: 0.6,
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                        ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    txt3,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.black38,
                          letterSpacing: 0.6,
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                        ),
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              Container(
                height: 25,
                width: 80,
                decoration: BoxDecoration(
                  color: Color(0xff317E2F),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of('FOLLOW'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).appBarTheme.color,
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
        SizedBox(
          height: 8,
        ),
        Divider(
          indent: 60,
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
