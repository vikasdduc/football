import 'package:fantacySports/Model/LoginData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../Language/appLocalizations.dart';
import '../../../../Networking/AccessNetwork.dart';
import '../../../../constance/constance.dart';
import '../../../../widget/customButton.dart';
import '../../../../widget/customTextField.dart';
import 'accountInfo.dart';

class Verify_Earnnings extends StatefulWidget {
  const Verify_Earnnings({Key key}) : super(key: key);

  @override
  State<Verify_Earnnings> createState() => _Verify_EarnningsState();
}

class _Verify_EarnningsState extends State<Verify_Earnnings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of('Verify'),
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
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              height: 100,
              width: MediaQuery.of(context).size.width,
              color: Color(0xffF6F5FB),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Get Verified",
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Theme.of(context).primaryColor,
                                letterSpacing: 0.6,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          "Verify your account details for a seamless experience",
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color:
                                    Theme.of(context).textTheme.bodyText2.color,
                                letterSpacing: 0.6,
                                fontSize: 14,
                                // fontWeight:
                                // FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage(
                          ConstanceData.archer,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.phone),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              ' Mobile Number',
                              style: Theme.of(context).textTheme.caption.copyWith(
                                color:
                                Theme.of(context).textTheme.bodyText2.color,
                                letterSpacing: 0.6,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                    // fontWeight:
                                    // FontWeight.bold,
                                  ),
                            ),
                            Expanded(child: SizedBox()),
                            Expanded(child: SizedBox()),

                            // Expanded(child: SizedBox()),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: SizedBox()),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '${ConstanceData.prof.phone}',
                              style: Theme.of(context).textTheme.caption.copyWith(
                                    color:
                                        Theme.of(context).textTheme.bodyText2.color,
                                    letterSpacing: 0.6,
                                    fontSize: 16,
                                    // fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Expanded(child: SizedBox()),
                            Expanded(child: SizedBox()),
                            Expanded(child: SizedBox()),
                          ],
                        ),

                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      'Verified',
                      style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.green,
                        letterSpacing: 0.6,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
            ),
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.email),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                ' Email address',
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .color,
                                      letterSpacing: 0.6,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Expanded(child: SizedBox()),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(child: SizedBox()),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  'For a more relevant fantasy experience',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(child: SizedBox()),
                        ConstanceData.prof.is_email_verified
                            ? Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  'Verified',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Colors.green,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              )
                            : ElevatedButton(
                                child: Text(
                                  'Verify',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                        // fontWeight:
                                        // FontWeight.bold,
                                      ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.grey.shade200),
                                ),
                                onPressed: () {
                                  var _otpcontroller = TextEditingController();
                                  access_network()
                                      .mobile_email_Register(login_data(
                                          ConstanceData.prof.email,
                                          '',
                                          false,
                                          ''))
                                      .then((_) {
                                    Fluttertoast.showToast(
                                        msg: "${_}",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20))),
                                      context: context,
                                      builder: (context) => Container(
                                        // height:280,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Center(
                                              child: Text(
                                                AppLocalizations.of(
                                                    'Enter the otp'),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .color,
                                                      letterSpacing: 0.6,
                                                      fontSize: 18,
                                                    ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            // CustomTextField(
                                            //   hintText: AppLocalizations.of('Enter Address'),
                                            //   controller: _controller,
                                            // ),
                                            Card(
                                              elevation: 7,
                                              color: Color(0xffF1F5F6),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              shadowColor: Color(0xffE9EBEC),
                                              child: StatefulBuilder(
                                                builder: (cont, setStates) {
                                                  return TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller: _otpcontroller,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 14,
                                                              right: 14),
                                                      focusColor: Colors.white,
                                                      border: InputBorder.none,

                                                      hintText: 'Enter the OTP',
                                                      hintStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption
                                                                    .color
                                                                    .withOpacity(
                                                                        0.9),
                                                                letterSpacing:
                                                                    0.6,
                                                                fontSize: 14,
                                                              ),
                                                      // border: OutlineInputBorder(
                                                      //   borderRadius: BorderRadius.circular(5),
                                                      // ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            CustomButton(
                                              text:
                                                  AppLocalizations.of('Verify'),
                                              onTap: () {
                                                access_network()
                                                    .email_verify(
                                                        '${ConstanceData.prof.email}',
                                                        _otpcontroller.text)
                                                    .then((_) {
                                                  Fluttertoast.showToast(
                                                      msg: "${_}",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                  Navigator.pop(context);
                                                });
                                              },
                                            ),
                                            CustomButton(
                                              text:
                                                  AppLocalizations.of('Cancel'),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                },
                              ),
                        Expanded(child: SizedBox()),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
            ),
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(FontAwesomeIcons.piggyBank),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                ' Bank account',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .color,
                                      letterSpacing: 0.6,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Expanded(child: SizedBox()),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(child: SizedBox()),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  'For withdrawal to your bank account',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(child: SizedBox()),
                        ConstanceData.prof.is_bank_verified
                            ? Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  'Verified',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Colors.green,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              )
                            : ElevatedButton(
                                child: Text(
                                  'Verify',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                        // fontWeight:
                                        // FontWeight.bold,
                                      ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.grey.shade200),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AccountInfoPage(),
                                    ),
                                  );
                                },
                              ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
            ),
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(FontAwesomeIcons.idCard),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                ' PAN card',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .color,
                                      letterSpacing: 0.6,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Expanded(child: SizedBox()),
                              Expanded(child: SizedBox()),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(child: SizedBox()),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  'For safety and security of all transactions',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(child: SizedBox()),
                        ConstanceData.prof.is_pan_verified
                            ? Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  'Verified',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Colors.green,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              )
                            : ElevatedButton(
                                child: Text(
                                  'Verify',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                        // fontWeight:
                                        // FontWeight.bold,
                                      ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.grey.shade200),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AccountInfoPage(),
                                    ),
                                  );
                                },
                              ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
