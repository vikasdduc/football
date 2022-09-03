import 'dart:convert';
import 'package:fantacySports/Language/LanguageData.dart';
import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/main.dart';
import 'package:fantacySports/modules/referralCode/referralCode.dart';
import 'package:fantacySports/widget/customButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fantacySports/constance/constance.dart' as constance;

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    myContext = context;
    _loadNextScreen();
    super.initState();
  }

  BuildContext myContext;

  _loadNextScreen() async {
    if (!mounted) return;
    if (constance.allTextData == null) {
      constance.allTextData = AllTextData.fromJson(
        json.decode(
          await DefaultAssetBundle.of(myContext)
              .loadString("jsonFile/languagetext.json"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7E0000),
      body: Container(

        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(30),
                child: Image.asset(
                  ConstanceData.homeLogo,
                  scale: 7,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CustomButton(
                text: AppLocalizations.of('Register'),
                onTap: () {
                  // Navigator.pushReplacementNamed(context, Routes.REGISTER);
                  Navigator.pushNamed(context, Routes.REGISTER);
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CustomButtonBorder(
                text: AppLocalizations.of("Let's Play"),
                onTap: () {
                  Navigator.pushNamed(context, Routes.LOGIN);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            rowText(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget rowText() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of('Invited by a friend'),
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  letterSpacing: 0.6,
                ),
          ),
          SizedBox(
            height: 4,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReferralCodePage(),
                ),
              );
            },
            child: Text(
              AppLocalizations.of('Enter code'),
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
