import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/widget/customButton.dart';
import 'package:fantacySports/widget/customTextField.dart';
import 'package:flutter/material.dart';

class InviteCodePage extends StatefulWidget {
  @override
  _InviteCodePageState createState() => _InviteCodePageState();
}

class _InviteCodePageState extends State<InviteCodePage> {
  TextEditingController _codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.color,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of('Invite Code'),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              AppLocalizations.of(
                  'If you have a contest invite code, enter it and join'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Colors.black87,
                    letterSpacing: 0.6,
                    fontSize: 12,
                  ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: Card(
              elevation: 5,
              child: Container(
                color: Theme.of(context).appBarTheme.color.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        hintText: AppLocalizations.of('Invite Code'),
                        controller: _codeController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                          text: AppLocalizations.of('Join This Contest')),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
