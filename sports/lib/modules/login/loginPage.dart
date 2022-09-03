import 'dart:convert';

import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/LoginData.dart';
import 'package:fantacySports/Model/Profile.dart';
import 'package:fantacySports/Model/SignUpData.dart';
import 'package:fantacySports/Model/signup_data.dart';
import 'package:fantacySports/Networking/AccessNetwork.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/modules/login/otp.dart';
import 'package:fantacySports/widget/customButton.dart';
import 'package:fantacySports/widget/customTextField.dart';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sms_autofill/sms_autofill.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _textFieldController = TextEditingController();

  AlertDialog alert;

  bool mobileOTP;

  String appSignature;

  @override
  void initState() {
    super.initState();
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
        print('Sign ${appSignature}');
      });
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, Routes.HOST);
        return Future.value(false);
      },
      child: Scaffold(
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
                          'Log in',
                          style: TextStyle(
                            fontSize: 35,
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
                                rowContent(),
                                SizedBox(
                                  height: 25,
                                ),
                                CustomTextField(
                                  controller: _userNameController,
                                  hintText: AppLocalizations.of(
                                      'Email/Mobile Number'),
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
                                  height: 30,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: CustomButton(
                                    color: Colors.green,
                                    text: AppLocalizations.of('Login'),
                                    onTap: () {
                                      showLoaderDialog(context);
                                      if (_userNameController.text.isNotEmpty) {
                                        if (_isNumeric(
                                            _userNameController.text)) {
                                          mobileOTP = true;
                                          signInWithMobile();
                                        } else {
                                          if (isEmail(
                                              _userNameController.text)) {
                                            mobileOTP = false;
                                            signInWithEmail();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Enter a valid email address",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            Navigator.pop(context);
                                          }
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Enter your email address",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Routes.REGISTER);
                                        },
                                        child: Text(
                                          AppLocalizations.of(
                                              'Don\'t have an account?'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                color: Colors.black54,
                                                letterSpacing: 0.6,
                                                fontSize: 16,
                                                //           decoration: TextDecoration.underline,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
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
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  Widget rowContent() {
    return Column(
      children: [
        Row(
          children: [
            // Expanded(
            //   child: Card(
            //     // shadowColor: Color(0xff1877F2),
            //     shadowColor: Colors.white,
            //     elevation: 5,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5),
            //     ),
            //     child: Material(
            //       child: InkWell(
            //         enableFeedback: true,
            //         onTap: () => facebookLogin(),
            //         splashColor: Color(0xff4b95f5),
            //         child: Container(
            //           height: 45,
            //           decoration: BoxDecoration(
            //               // color: Colors.white,
            //               borderRadius: BorderRadius.circular(5)),
            //           child: Padding(
            //             padding: const EdgeInsets.only(left: 4, right: 2),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Icon(
            //                   FontAwesomeIcons.facebookF,
            //                   color: Color(0xff1877F2),
            //                   size: 20,
            //                 ),
            //                 SizedBox(
            //                   width: 2,
            //                 ),
            //                 Text(
            //                   AppLocalizations.of('Facebook'),
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .bodyText2
            //                       .copyWith(
            //                         color: Color(0xff1877F2),
            //                         fontWeight: FontWeight.bold,
            //                         letterSpacing: 0.6,
            //                         fontSize: 16,
            //                       ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   width: 2,
            // ),
            Expanded(
              child: Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Material(
                  child: InkWell(
                    enableFeedback: true,
                    onTap: () => signInWithGoogle(),
                    splashColor: Color(0xffff2728),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.googlePlusG,
                              color: Color(0xffD30001),
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of('Google'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    color: Color(0xffD30001),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.6,
                                    fontSize: 16,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  void signInWithEmail() async {
    mobileOTP = false;
    sendOtp();
  }

  void sendOtp() async {
    // String signature = await SmsVerification.getAppSignature();
    // print('OTP ${signature}');
    access_network()
        .mobile_email_Register(login_data(
          mobileOTP ? '' : _userNameController.text,
          mobileOTP ? _userNameController.text : '',
          mobileOTP,
          // await generate(),
          appSignature,
        ))
        .then((value) => {
              Navigator.pop(context),
              Fluttertoast.showToast(
                  msg: "${value}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0),
              verifyReturn(value),
            });
  }

  void signInWithMobile() {
    mobileOTP = true;
    if (_userNameController.text.length == 10) {
      sendOtp();
    } else {
      Fluttertoast.showToast(
          msg: "Oops, looks like the number you entered is too short",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    }
  }

  void sendMsg() async {
    Navigator.pop(context);
    // showLoaderDialog(context);
    // access_network()
    //     .forgotPassword(_textFieldController.text.toString())
    //     .then((value) => {Navigator.pop(context)});
  }

  verifyReturn(value) {
    if (value != null && value != 'You are not register!!') {
      if (value == "OTP send in your email please check!" ||
          value == "OTP has been Sent successfully!!" ||
          value == "OTP send in your email please check!") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(signup_data(
              '',
              mobileOTP ? '' : _userNameController.text,
              mobileOTP ? _userNameController.text : '',
              mobileOTP,
            )),
          ),
        );
      }
    }
  }

  login(Email, type) async {
    access_network()
        .login(SignUpData(
          name: '',
          email: Email,
          mobileOTP: false,
          login_by: type,
          phone: 0,
          // vcode: await generate(),
          vcode: appSignature,
        ))
        .then((value) => {
              ConstanceData.setProfile(Profile.fromJson(value['data'])),
              print(ConstanceData.prof),
              Navigator.pushReplacementNamed(context, Routes.HOME),
            });
  }

  void facebookLogin() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}'));
        final profile = json.decode(graphResponse.body);
        // signUpWithFacebook(
        //     profile["email"], 'facebook', result.accessToken.token);
        login(profile["email"], 'facebook');
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('cancelledByUser');
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        Fluttertoast.showToast(
            msg: "${result.errorMessage}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        break;
    }
  }

  signInWithGoogle() {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        // you can add extras if you require
      ],
    );

    _googleSignIn.signIn().then((GoogleSignInAccount acc) async {
      GoogleSignInAuthentication auth = await acc.authentication;
      print(acc.id);
      print(acc.email);
      print(acc.displayName);
      print(acc.photoUrl);

      acc.authentication.then((GoogleSignInAuthentication auth) async {
        print(auth.idToken);
        print(auth.accessToken);
        login(acc.email, 'google');
      });
    });
  }

// Future<String> generate() async {
//   String signature = await SmsVerification.getAppSignature();
//   print('signature ${signature}');
//   return signature;
// }
}
