import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/main.dart';
import 'package:fantacySports/widget/customButton.dart';
import 'package:fantacySports/widget/customTextField.dart';
import 'package:flutter/material.dart';

class ReferralCodePage extends StatefulWidget {
  @override
  _ReferralCodePageState createState() => _ReferralCodePageState();
}

class _ReferralCodePageState extends State<ReferralCodePage> {
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _inviteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.color,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,

      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Referal',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Cinzel',
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                controller: _inviteController,
                                hintText:
                                    AppLocalizations.of('Enter invite code'),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                    'Enter the referralCode',
                                    style: TextStyle(fontSize: 11.5)),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                controller: _mobileController,
                                hintText: AppLocalizations.of('Mobile No.'),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                    'You will receive an OTP for verification',
                                    style: TextStyle(fontSize: 11.5)),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                controller: _emailController,
                                hintText: AppLocalizations.of('Email'),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                    'You will receive an OTP for verification',
                                    style: TextStyle(fontSize: 11.5)),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                controller: _passwordController,
                                hintText: AppLocalizations.of('Password'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: CustomButton(
                                  text: AppLocalizations.of('Register'),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of('Already a user?'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .color,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.6,
                                          fontSize: 14,
                                        ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.popAndPushNamed(
                                          context, Routes.LOGIN);
                                    },
                                    child: Text(
                                      AppLocalizations.of('Log in'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.6,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
