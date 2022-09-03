import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/LoginData.dart';
import 'package:fantacySports/Model/Profile.dart';
import 'package:fantacySports/Model/SignUpData.dart';
import 'package:fantacySports/Model/signup_data.dart';
import 'package:fantacySports/Networking/AccessNetwork.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/widget/customButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiver/async.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../main.dart';

class verify extends StatefulWidget {
  final signup_data data;

  verify({Key key, @required this.data}) : super(key: key);

  @override
  __verifyState createState() => __verifyState();
}

class __verifyState extends State<verify> {
  TextEditingController _Controller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  int time = 60;
  CountdownTimer countdownTimer;
  final intRegex = RegExp(r'\d+', multiLine: true);
  AlertDialog alert;

  String appSignature;

  String txt = '';

  @override
  void initState() {
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
    new CountdownTimer(
            new Duration(
              seconds: 60,
            ),
            new Duration(seconds: 1))
        .listen((data) {
      try {
        if (mounted) {
          setState(() {
            time = data.remaining.inSeconds;
          });
        }
      } catch (e) {
        print(e);
      }
    });
    // _startListeningSms();
    super.initState();

    // _startListeningSms();
    listen();
  }

  void listen() async {
    await SmsAutoFill()
        .listenForCode(smsCodeRegexPattern: RegExp('\d{3}[a-zA-Z0-9]').pattern);
  }

  // _startListeningSms() {
  //   SmsVerification.startListeningSms().then((message) {
  //     setState(() {
  //       var _otpCode = SmsVerification.getCode(message, intRegex);
  //       _Controller.text = _otpCode;
  //       verifyOtp();
  //       print('${_otpCode}');
  //     });
  //   });
  // }

  @override
  void dispose() {
    // _Controller.dispose();
    // SmsVerification.stopListening();
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    AppLocalizations.of(
                        'OTP sent to ${widget.data.mobileOTP ? widget.data.mobile : widget.data.email}'),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.white,
                          letterSpacing: 0.6,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).disabledColor,
                    ),
                    borderRadius: BorderRadius.circular(4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of('Enter the OTP you receivedtext'),
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Theme.of(context).textTheme.caption.color,
                            letterSpacing: 0.6,
                            fontSize: 14,
                          ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 30, right: 30),
                    //   child: PinCodeFields(
                    //     controller: _Controller,
                    //     fieldHeight: 40,
                    //     fieldWidth: 40,
                    //     length: 4,
                    //     obscureText: false,
                    //     keyboardType: TextInputType.number,
                    //     activeBorderColor: Theme.of(context).primaryColor,
                    //     margin: EdgeInsets.all(10),
                    //     borderColor: Theme.of(context).disabledColor,
                    //   ),
                    // ),
                    PinFieldAutoFill(
                      // smsCodeRegexPattern: '\d{3}[a-zA-Z0-9]',
                      autoFocus: true,
                      currentCode: txt,
                      enableInteractiveSelection: true,
                      controller: _Controller,
                      onCodeSubmitted: (code) {
                        if (code.length == 4) {
                          // FocusScope.of(context).requestFocus(FocusNode());
                          verifyOtp(code);
                        }
                      },
                      onCodeChanged: (code) {
                        setState(() {
                          txt = code;
                        });
                        if (code.length == 4) {
                          verifyOtp(code);
                        }
                      },
                      codeLength: 4,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of('You should  receive the OTP in'),
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.white,
                        letterSpacing: 0.6,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  AppLocalizations.of('$time Second..'),
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.yellow,
                        letterSpacing: 0.6,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            time == 0
                ? Material(
                    color: Colors.transparent,
                    child: Container(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          showLoaderDialog(context);
                          sendOtp();
                        },
                        child: Text(
                          'Resend',
                          style: TextStyle(
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: time == 0 ? 20 : 40,
            ),
            CustomButton(
              text: AppLocalizations.of('Next'),
              onTap: () {
                showLoaderDialog(context);
                if (_Controller.text.isNotEmpty) {
                  verifyOtp(_Controller.text.toString());
                } else {
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: "Enter the otp sent to you",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    new CountdownTimer(
            new Duration(
              seconds: 60,
            ),
            new Duration(seconds: 1))
        .listen((data) {
      print('Something');
      print('Remaining time: ${data.remaining.inSeconds}');
      if (mounted) {
        setState(() {
          time = data.remaining.inSeconds;
        });
      }
    });
  }

  void verifyOtp(code) async {
    access_network()
        .verify_OTP(
            widget.data.mobile, widget.data.email, widget.data.mobileOTP, code)
        .then((value) => {checkSuccess(value)});
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

  checkSuccess(value) async {
    if (value['message'] != "Your OTP is Incorrect!") {
      access_network()
          .signup(SignUpData(
            id: '',
            name: widget.data.name,
            email: widget.data.email,
            mobileOTP: widget.data.mobileOTP,
            login_by: 'manual',
            phone: int.parse(widget.data.mobile),
            vcode: '${appSignature}',
          ))
          .then((value) => {
                Fluttertoast.showToast(
                    msg: "${value['message']}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0),
                if (value['message'].toString() ==
                    'SignUp has been successfully!!')
                  {
                    access_network()
                        .login(SignUpData(
                          name: widget.data.name,
                          email: widget.data.email,
                          mobileOTP: widget.data.mobileOTP,
                          login_by: 'manual',
                          phone: widget.data.mobileOTP
                              ? int.parse(widget.data.mobile)
                              : 0,
                          vcode: '${appSignature}',
                        ))
                        .then((value) => {
                              Navigator.pop(context),
                              ConstanceData.setProfile(
                                  Profile.fromJson(value['data'])),
                              print(ConstanceData.prof),
                              Navigator.pushReplacementNamed(
                                  context, Routes.HOME),
                            })
                    // Navigator.popAndPushNamed(context, Routes.LOGIN)
                  }
                else
                  {
                    print('done2 ${value['message']} 1 ${value}'),
                    Navigator.pop(context),
                  }
              });
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "${value['message']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void sendOtp() async {
    access_network()
        .mobile_email_Register1(login_data(
            widget.data.email,
            widget.data.mobile,
            widget.data.mobileOTP,
            // await generate(),
            appSignature))
        .then((value) => {
              Fluttertoast.showToast(
                  msg: "${value}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0),
              Navigator.pop(context),
            });
  }

  void signUpWithMobile() async {
    access_network()
        .mobile_email_Register1(login_data(
            widget.data.email,
            widget.data.mobile,
            widget.data.mobileOTP,
            // await generate(),
            ''))
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
              print(value),
              check(value)
            });
  }

  void signUpWithEmail() async {
    access_network()
        .mobile_email_Register1(login_data(
            widget.data.email,
            widget.data.mobile,
            widget.data.mobileOTP,
            // await generate(),
            ''))
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
              check(value)
            });
  }

  check(value) {
    if (value == null || value.toString() == 'Already Registered!!') {
      Navigator.pop(context);
    } else {}
  }

// Future<String> generate() async {
//   String signature = await SmsVerification.getAppSignature();
//   print('signature ${signature}');
//   return signature;
// }

// getGen() async {
//   return await generate();
// }
}
