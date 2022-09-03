import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/modules/home/drawer/inviteFriend.dart/contact.dart';
import 'package:flutter/material.dart';

import 'invite.dart';

class InviteContactPage extends StatefulWidget {
  @override
  _InviteContactPageState createState() => _InviteContactPageState();
}

class _InviteContactPageState extends State<InviteContactPage> {
  bool isContact = true;
  bool isInvite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Theme.of(context).primaryColor,
          ),
          Container(
            height: AppBar().preferredSize.height,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 22,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    AppLocalizations.of('My Contacts'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          letterSpacing: 0.6,
                          fontSize: 22,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isContact = true;
                        isInvite = false;
                      });
                    },
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: isContact == true
                            ? Theme.of(context).textTheme.headline6.color
                            : Theme.of(context).appBarTheme.color,
                        border: Border.all(
                          color: Theme.of(context).disabledColor,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of('My Contacts'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: isContact == true
                                    ? Theme.of(context).appBarTheme.color
                                    : Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                letterSpacing: 0.6,
                                fontSize: 14,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isInvite = true;
                        isContact = false;
                      });
                    },
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: isInvite == true
                            ? Theme.of(context).textTheme.headline6.color
                            : Theme.of(context).appBarTheme.color,
                        border: Border.all(
                          color: Theme.of(context).disabledColor,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of('Invite Friends'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: isInvite == true
                                    ? Theme.of(context).appBarTheme.color
                                    : Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                letterSpacing: 0.6,
                                fontSize: 14,
                              ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          isContact == true
              ? ContactPage()
              : isInvite == true
                  ? InvitePage()
                  : SizedBox(),
        ],
      ),
    );
  }
}
