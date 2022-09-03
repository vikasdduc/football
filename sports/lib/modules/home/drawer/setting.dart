import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/Profile.dart';
import 'package:fantacySports/Model/SaveProfileData.dart';
import 'package:fantacySports/Networking/AccessNetwork.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/widget/customButton.dart';
import 'package:fantacySports/widget/customTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool isMale = true;
  bool isFemale = false;
  bool isSwitched1 = false;
  String dateSelected;
  bool isSwitched2 = false;

  AlertDialog alert;

  @override
  void initState() {
    super.initState();
    print('Init');
    _birthDateController.text = ConstanceData.prof.dob;
    _addressController.text = ConstanceData.prof.address;
    _cityController.text = ConstanceData.prof.city;
    _pinCodeController.text = ConstanceData.prof.pincode;
    dateSelected = ConstanceData.prof.dob;
    _stateController.text = ConstanceData.prof.state;
  }

  @override
  void dispose() {
    _birthDateController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _pinCodeController.dispose();
    _stateController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of('My Info & Settings'),
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    AppLocalizations.of('Name'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          letterSpacing: 0.6,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  elevation: 7,
                  color: Color(0xffF1F5F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  shadowColor: Color(0xffE9EBEC),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 10),
                    height: 50,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${ConstanceData.prof.name}',
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .color
                                          .withOpacity(0.9),
                                      letterSpacing: 0.6,
                                      fontSize: 14,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    AppLocalizations.of('Phone'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          letterSpacing: 0.6,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  elevation: 7,
                  color: Color(0xffF1F5F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  shadowColor: Color(0xffE9EBEC),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${ConstanceData.prof.phone}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .color
                                          .withOpacity(0.9),
                                      letterSpacing: 0.6,
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          var _controller = TextEditingController();
                          var _otpcontroller = TextEditingController();
                          access_network()
                              .send_otp('', '${ConstanceData.prof.phone}')
                              .then((_) {});
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20))),
                            context: context,
                            builder: (context) => Container(
                              // height:280,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      AppLocalizations.of('Enter the otp'),
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
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    shadowColor: Color(0xffE9EBEC),
                                    child: StatefulBuilder(
                                      builder: (cont, setStates) {
                                        return TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: _otpcontroller,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                left: 14, right: 14),
                                            focusColor: Colors.white,
                                            border: InputBorder.none,

                                            hintText: 'Enter the OTP',
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .caption
                                                      .color
                                                      .withOpacity(0.9),
                                                  letterSpacing: 0.6,
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
                                    text: AppLocalizations.of('Verify'),
                                    onTap: () {
                                      access_network()
                                          .verify_otp(
                                              '',
                                              '${ConstanceData.prof.phone}',
                                              _otpcontroller.text)
                                          .then((_) {
                                        if (_ != 'Verification Failed!') {
                                          showModalBottomSheet(
                                            isDismissible: true,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20),
                                                    topLeft:
                                                        Radius.circular(20))),
                                            context: context,
                                            builder: (context) => Container(
                                              // height:280,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                          topLeft:
                                                              Radius.circular(
                                                                  20))),
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
                                                          'Enter the mobile to update'),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption
                                                          .copyWith(
                                                            color: Theme.of(
                                                                    context)
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
                                                  CustomTextField(
                                                    hintText: AppLocalizations.of(
                                                        'Enter mobile Address'),
                                                    controller: _controller,
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  CustomButton(
                                                    text: AppLocalizations.of(
                                                        'Update'),
                                                    onTap: () {
                                                      if (_controller.text
                                                              .isNotEmpty &&
                                                          _isNumeric(_controller
                                                              .text) &&
                                                          _controller.text
                                                                  .length ==
                                                              10) {
                                                        access_network()
                                                            .email_phone_update(
                                                                '',
                                                                _controller
                                                                    .text,
                                                                ConstanceData
                                                                    .prof.id
                                                                    .toString())
                                                            .then((_) {
                                                          Fluttertoast.showToast(
                                                              msg: "${_}",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .CENTER,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0);
                                                          access_network()
                                                              .kyc_get()
                                                              .then((value) => {
                                                                    CheckValid(
                                                                        value[
                                                                            'message']),
                                                                    Navigator.pop(
                                                                        context),
                                                                    setState(
                                                                        () {
                                                                      ConstanceData
                                                                          .setProfile(
                                                                              Profile.fromJson(value['Get_Kyc_data']));
                                                                    }),
                                                                    Navigator.pop(
                                                                        context)
                                                                  });
                                                        });
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Enter a valid mobile",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      }
                                                    },
                                                  ),
                                                  CustomButton(
                                                    text: AppLocalizations.of(
                                                        'Cancel'),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Wrong OTP",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          Navigator.pop(context);
                                        }
                                      });
                                    },
                                  ),
                                  CustomButton(
                                    text: AppLocalizations.of('Cancel'),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Change',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    AppLocalizations.of('Email'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          letterSpacing: 0.6,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  elevation: 7,
                  color: Color(0xffF1F5F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  shadowColor: Color(0xffE9EBEC),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  ConstanceData.prof.email,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color
                                            .withOpacity(0.9),
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          var _controller = TextEditingController();
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20))),
                            context: context,
                            builder: (context) => Container(
                              // height:280,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      AppLocalizations.of(
                                          'Enter the email to update'),
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
                                  CustomTextField(
                                    hintText: AppLocalizations.of(
                                        'Enter Email Address'),
                                    controller: _controller,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomButton(
                                    text: AppLocalizations.of('Update'),
                                    onTap: () {
                                      if (_controller.text.isNotEmpty &&
                                          isEmail(_controller.text)) {
                                        access_network()
                                            .email_phone_update(
                                                _controller.text,
                                                '',
                                                ConstanceData.prof.id
                                                    .toString())
                                            .then((_) {
                                          Fluttertoast.showToast(
                                              msg: "${_}",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          access_network()
                                              .kyc_get()
                                              .then((value) => {
                                                    CheckValid(
                                                        value['message']),
                                                    Navigator.pop(context),
                                                    setState(() {
                                                      ConstanceData.setProfile(
                                                          Profile.fromJson(value[
                                                              'Get_Kyc_data']));
                                                    }),
                                                    print(value['Get_Kyc_data'])
                                                  });
                                        });
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Enter a valid email",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    },
                                  ),
                                  CustomButton(
                                    text: AppLocalizations.of('Cancel'),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Change',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    AppLocalizations.of('Date of Birth'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          letterSpacing: 0.6,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  elevation: 7,
                  color: Color(0xffF1F5F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  shadowColor: Color(0xffE9EBEC),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${dateSelected == null ? 'Please select your date of birth' : dateSelected}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .color
                                          .withOpacity(0.9),
                                      letterSpacing: 0.6,
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          var now = DateTime.now();
                          var formatterDate = DateFormat('dd/MM/yyyy');
                          String actualDate = formatterDate.format(now);
                          var list = actualDate.split('/');
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1930, 1, 1),
                              maxTime: DateTime(int.parse(list[2]),
                                  int.parse(list[1]), int.parse(list[0])),
                              onChanged: (date) {}, onConfirm: (date) {
                            setState(() {
                              dateSelected = date.year.toString() +
                                  "-" +
                                  date.month.toString() +
                                  "-" +
                                  date.day.toString();
                            });
                          });
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    AppLocalizations.of('Gender'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).textTheme.bodyText2.color,
                          letterSpacing: 0.6,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      isMale == true
                          ? Icon(
                              FontAwesomeIcons.dotCircle,
                              color: Theme.of(context).primaryColor,
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  isMale = true;
                                  isFemale = false;
                                });
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.5),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        AppLocalizations.of('Male'),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.5),
                              letterSpacing: 0.6,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      isFemale == true
                          ? Icon(
                              FontAwesomeIcons.dotCircle,
                              color: Theme.of(context).primaryColor,
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  isMale = false;
                                  isFemale = true;
                                });
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.5),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        AppLocalizations.of('Female'),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.5),
                              letterSpacing: 0.6,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Container(
          //   height: 50,
          //   color: Theme.of(context).appBarTheme.color,
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 20, right: 20),
          //     child: Row(
          //       children: [
          //         Text(
          //           AppLocalizations.of('Allow SMS notifications'),
          //           style: Theme.of(context).textTheme.caption.copyWith(
          //                 color: Theme.of(context).textTheme.headline6.color,
          //                 letterSpacing: 0.6,
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //         ),
          //         Expanded(child: SizedBox()),
          //         CupertinoSwitch(
          //           value: isSwitched1,
          //           onChanged: (value) {
          //             setState(() {
          //               isSwitched1 = value;
          //             });
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 15,
          ),
          // Container(
          //   height: 50,
          //   color: Theme.of(context).appBarTheme.color,
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 20, right: 20),
          //     child: Row(
          //       children: [
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               AppLocalizations.of('Make Me Discoverable'),
          //               style: Theme.of(context).textTheme.caption.copyWith(
          //                     color:
          //                         Theme.of(context).textTheme.headline6.color,
          //                     letterSpacing: 0.6,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //             ),
          //             SizedBox(
          //               height: 5,
          //             ),
          //             Text(
          //               AppLocalizations.of(
          //                   'Friends can find and follow you when they sync their\nphone contacts'),
          //               style: Theme.of(context).textTheme.caption.copyWith(
          //                     color: Colors.black26,
          //                     letterSpacing: 0.6,
          //                     fontSize: 10,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //             ),
          //           ],
          //         ),
          //         Expanded(child: SizedBox()),
          //         CupertinoSwitch(
          //           value: isSwitched2,
          //           onChanged: (value) {
          //             setState(() {
          //               isSwitched2 = value;
          //             });
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    AppLocalizations.of('Address'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          letterSpacing: 0.6,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  hintText: AppLocalizations.of('Enter Address'),
                  controller: _addressController,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    AppLocalizations.of('City'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          letterSpacing: 0.6,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  hintText: AppLocalizations.of('Enter City'),
                  controller: _cityController,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    AppLocalizations.of('Pin code'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          letterSpacing: 0.6,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  hintText: AppLocalizations.of('Enter pin code'),
                  controller: _pinCodeController,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    AppLocalizations.of('State'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          letterSpacing: 0.6,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  hintText: AppLocalizations.of('Enter state'),
                  controller: _stateController,
                ),

                SizedBox(
                  height: 25,
                ),
                // Row(
                //   children: [
                //     Icon(
                //       Icons.exit_to_app,
                //       size: 18,
                //     ),
                //     SizedBox(
                //       width: 5,
                //     ),
                //     // Text(
                //     //   AppLocalizations.of('Logout'),
                //     //   style: Theme.of(context).textTheme.caption.copyWith(
                //     //         letterSpacing: 0.6,
                //     //         fontSize: 12,
                //     //         fontWeight: FontWeight.bold,
                //     //       ),
                //     // ),
                //     Expanded(child: SizedBox()),
                //     // Text(
                //     //   AppLocalizations.of('Suspend Account'),
                //     //   style: Theme.of(context).textTheme.caption.copyWith(
                //     //         letterSpacing: 0.6,
                //     //         fontSize: 12,
                //     //         fontWeight: FontWeight.bold,
                //     //       ),
                //     // ),
                //   ],
                // ),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  text: AppLocalizations.of('Update Profile'),
                  onTap: () {
                    showLoaderDialog(context);
                    access_network()
                        .profile(SaveProfileData(
                            name: ConstanceData.prof.name,
                            id: ConstanceData.id.toString(),
                            address: _addressController.text,
                            city: _cityController.text,
                            state: _stateController.text,
                            dob: dateSelected,
                            pincode: _pinCodeController.text.toString(),
                            gender: isMale ? 'Male' : 'Female'))
                        .then((value) => {
                              CheckValid(value),
                              access_network().kyc_get().then((value) => {
                                    CheckValid(value['message']),
                                    Navigator.pop(context),
                                    setState(() {
                                      ConstanceData.setProfile(Profile.fromJson(
                                          value['Get_Kyc_data']));
                                    }),
                                    print(value['Get_Kyc_data'])
                                  })
                            });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
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

  CheckValid(value) async {
    if (value == 'Token is Expired') {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.pushReplacementNamed(context, Routes.HOST);
    } else {}
  }

  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
