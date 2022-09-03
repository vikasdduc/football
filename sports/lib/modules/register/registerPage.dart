import 'dart:convert';

import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/LoginData.dart';
import 'package:fantacySports/Model/Profile.dart';
import 'package:fantacySports/Model/SignUpData.dart';
import 'package:fantacySports/Model/signup_data.dart';
import 'package:fantacySports/Networking/AccessNetwork.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/modules/login/otp.dart';
import 'package:fantacySports/modules/register/verify.dart';
import 'package:fantacySports/widget/customButton.dart';
import 'package:fantacySports/widget/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sms_autofill/sms_autofill.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  PhoneAuthCredential phone;
  bool mobileOTP = true;
  String appSignature;
  AlertDialog alert;

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Center(
                      child: Text(
                        'Sign up',
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: rowContent(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 1.5,
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width / 2 -
                                        35,
                                    child: Container(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    ' OR ',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5,
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width / 2 -
                                        35,
                                    child: Container(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                controller: _mobileController,
                                hintText: AppLocalizations.of('Mobile No.'),
                              ),
                              SizedBox(
                                height: 3,
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
                              CustomTextField(
                                controller: _nameController,
                                hintText: AppLocalizations.of('Name'),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text('Enter your full name',
                                    style: TextStyle(fontSize: 11.5)),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              CustomTextField(
                                controller: _emailController,
                                hintText: AppLocalizations.of('Email'),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text('No Spam. We promise!',
                                    style: TextStyle(fontSize: 11.5)),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              // Container(
                              //   height: 50,
                              //   width: MediaQuery.of(context).size.width,
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Container(
                              //         child: Row(
                              //           children: [
                              //             Radio(
                              //               activeColor:
                              //                   Theme.of(context).primaryColor,
                              //               onChanged: (value) {
                              //                 setState(() {
                              //                   mobileOTP = value;
                              //                 });
                              //               },
                              //               value: true,
                              //               groupValue: mobileOTP,
                              //             ),
                              //             Icon(
                              //               Icons.phone,
                              //             ),
                              //             Text('Mobile'),
                              //           ],
                              //         ),
                              //       ),
                              //       Container(
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Radio(
                              //               activeColor:
                              //                   Theme.of(context).primaryColor,
                              //               onChanged: (value) {
                              //                 setState(() {
                              //                   mobileOTP = value;
                              //                 });
                              //               },
                              //               value: false,
                              //               groupValue: mobileOTP,
                              //             ),
                              //             Icon(Icons.email),
                              //             Text('Email'),
                              //           ],
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 3,
                              // ),
                              // Padding(
                              //   padding: EdgeInsets.only(left: 5),
                              //   child: Text('Where do you want your OTP',
                              //       style: TextStyle(fontSize: 11.5)),
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'By Registering you are also agreeing to our',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                  Flexible(
                                    child: TextButton(
                                      child: Text('T&C',
                                          style: TextStyle(
                                            color:
                                            Theme
                                                .of(context)
                                                .primaryColor,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      onPressed: () {
                                        _launchURL();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 5, right: 5),
                                child: CustomButton(
                                  text: AppLocalizations.of('Register'),
                                  onTap: () async {
                                    // Navigator.popAndPushNamed(
                                    //     context, Routes.LOGIN);
                                    showLoaderDialog(context);
                                    if (_emailController.text.isNotEmpty &&
                                        isEmail(_emailController.text.toString()
                                            .trim())) {
                                      if (!mobileOTP) {
                                        if (_nameController.text.isNotEmpty) {
                                          signUpWithEmail();
                                        } else {
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                              msg: "Enter a name",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      } else {
                                        if (_isNumeric(
                                            _mobileController.text) &&
                                            _mobileController.text.length ==
                                                10) {
                                          if (_nameController.text.isNotEmpty) {
                                            signUpWithMobile();
                                          } else {
                                            Navigator.pop(context);
                                            Fluttertoast.showToast(
                                                msg: "Enter a name",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        } else {
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                              msg:
                                              "Enter a valid mobile number",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      }
                                    } else {
                                      print(_emailController.text);
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                          msg: "Enter a valid email address",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                ),
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
            //         onTap: () {
            //           facebookLogin();
            //           // Fluttertoast.showToast(
            //           // msg: "Coming soon",
            //           // toastLength: Toast.LENGTH_SHORT,
            //           // gravity: ToastGravity.CENTER,
            //           // timeInSecForIosWeb: 1,
            //           // backgroundColor: Colors.red,
            //           // textColor: Colors.white,
            //           // fontSize: 16.0);
            //         },
            //         splashColor: Color(0xff4b95f5),
            //         child: Container(
            //           height: 45,
            //           decoration: BoxDecoration(
            //             // color: Colors.white,
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
            //                   style: Theme
            //                       .of(context)
            //                       .textTheme
            //                       .bodyText2
            //                       .copyWith(
            //                     color: Color(0xff1877F2),
            //                     fontWeight: FontWeight.bold,
            //                     letterSpacing: 0.6,
            //                     fontSize: 16,
            //                   ),
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
                    onTap: () {
                      signInWithGoogle();
                    },
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
                              style: Theme
                                  .of(context)
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

  void signUpWithEmail() async {
    access_network()
        .mobile_email_Register1(login_data(
        _emailController.text,
        _mobileController.text,
        mobileOTP,
        // await generate()
        appSignature
    ))
        .then((value) =>
    {
      Navigator.pop(context),
      Fluttertoast.showToast(
          msg: "${value}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0),
      check(value)
    });
  }

  void signUpWithMobile() async {
    access_network()
        .mobile_email_Register1(login_data(
        _emailController.text,
        _mobileController.text,
        mobileOTP,
        // await generate()
        appSignature
    ))
        .then((value) =>
    {
      Navigator.pop(context),
      Fluttertoast.showToast(
          msg: "${value}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0),
      print(value),
      check(value)
    });
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

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void facebookLogin() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result
                .accessToken.token}'));
        final profile = json.decode(graphResponse.body);
        signUpWithFacebook(
            profile["email"], profile["name"], 'facebook',
            result.accessToken.token);
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

  void signInWithGoogle() {
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
        access_network()
            .signUpWithFacebook(
            acc.email, acc.displayName.toString(), 'google',
            auth.accessToken.toString())
            .then((value) =>
        {
          Fluttertoast.showToast(
              msg: "${value}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0),
          validate(value, acc.email)
        });
      });
    });
  }

  void signUpWithFacebook(String email, String name, String s, String token) {
    access_network().signUpWithFacebook(email, name, s, token).then((value) =>
    {
      // Navigator.pop(context),
      Fluttertoast.showToast(
          msg: "${value}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0),
      validate(value, email)
    });
  }

  validate(value, email) {
    if (value.toString() != 'Mobile number or Email Already Exist') {
      byPassOTP(email);
      // signupOthers(value,email);
      // Navigator.popAndPushNamed(context, Routes.LOGIN);
    } else {
      print('signed out  ${value}');
      auth.signOut();
    }
  }


  void byPassOTP(email) async {
    access_network()
        .login(SignUpData(
      name: '',
      email: email,
      mobileOTP: false,
      login_by: 'manual',
      phone: 0,
      // vcode: await generate(),
      vcode: '${appSignature}',
    ))
        .then((value) =>
    {
      ConstanceData.setProfile(
          Profile.fromJson(value['data'])),
      print(ConstanceData.prof),
      Navigator.pushReplacementNamed(
          context, Routes.HOME),
    });
  }


  @override
  void initState() {
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
        print('Sign ${appSignature}');
      });
    });
    super.initState();

  }

  check(value) {
    if (value == null || value.toString() == 'Already Registered!!') {} else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              verify(
                data: signup_data(
                  _nameController.text,
                  _emailController.text,
                  _mobileController.text,
                  mobileOTP,
                ),
              ),
        ),
      );
    }
  }

  void _launchURL() async {
    if (!await launch(ConstanceData.tNC))
      throw 'Could not launch ${ConstanceData.tNC}';
  }

// Future<String> generate() async {
//   String signature = await SmsVerification.getAppSignature();
//   print('signature ${signature}');
//   return signature;
// }

// void signupOthers(value, email) {
//   access_network()
//       .signup(SignUpData(
//     id: value['id'].toString(),
//     name: widget.data.name,
//     email: widget.data.email,
//     mobileOTP: widget.data.mobileOTP,
//     login_by: 'manual',
//     phone: int.parse(widget.data.mobile),
//   ))
//       .then((value) => {
//     print("23 ${value}"),
//     Fluttertoast.showToast(
//         msg: "${value['message']}",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0),
//     if (value['message'].toString() ==
//         'SignUp has been successfully!!')
//       {
//         access_network()
//             .login(SignUpData(
//           name: widget.data.name,
//           email: widget.data.email,
//           mobileOTP: widget.data.mobileOTP,
//           login_by: 'manual',
//           phone: widget.data.mobileOTP
//               ? int.parse(widget.data.mobile)
//               : 0,
//         ))
//             .then((value) => {
//           Navigator.pop(context),
//           ConstanceData.setProfile(
//               Profile.fromJson(value['data'])),
//           print(ConstanceData.prof),
//           Navigator.pushReplacementNamed(
//               context, Routes.HOME),
//         })
//         // Navigator.popAndPushNamed(context, Routes.LOGIN)
//       }
//     else
//       {
//         print('done2 ${value['message']} 1 ${value}'),
//         Navigator.pop(context),
//       }
//   });
// }
}
