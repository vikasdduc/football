import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/KYC_Data.dart';
import 'package:fantacySports/Model/Profile.dart';
import 'package:fantacySports/Networking/AccessNetwork.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/widget/customButton.dart';
import 'package:fantacySports/widget/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'Preview.dart';

class KYC extends StatefulWidget {
  KYC({Key key}) : super(key: key);
  var pan, bank;

  @override
  _KYCState createState() => _KYCState();
}

class _KYCState extends State<KYC> {
  TextEditingController _teamController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile imagePan, imageBank;
  bool isMale = true;
  bool isFemale = false;
  bool isSwitched1 = false;
  bool isSwitched2 = false;

  AlertDialog alert;


  @override
  void dispose() {
    _teamController.dispose();
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
          AppLocalizations.of('KYC'),
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
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    AppLocalizations.of('Team Name'),
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
                  hintText: AppLocalizations.of('Enter Team Name'),
                  controller: _teamController,
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                CustomButton(
                  text: AppLocalizations.of('PAN Verify'),
                  onTap: () async {
                    try {
                      imagePan = await _picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 50,
                      );
                    } catch (e) {
                      print(e);
                    }
                    if (imagePan != null) {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreviewPage(imagePan),
                        ),
                      );
                      if (result == 'Yes') {
                        setState(() {
                          widget.pan = imagePan;
                        });
                      } else {
                        setState(() {
                          widget.pan = null;
                          imagePan = null;
                        });
                      }
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color:
                          widget.pan != null ? Colors.green : Color(0xff0E2F56),
                      shape: BoxShape.circle,
                      // border: Border.all(color: widget.bank!=null?Colors.green:Color(0xff0E2F56))
                    ),
                    child: Icon(
                      Icons.check,
                      color:
                          widget.pan != null ? Colors.white : Color(0xff0E2F56),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                CustomButton(
                  text: AppLocalizations.of('Bank Verify'),
                  onTap: () async {
                    try {
                      imageBank = await _picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 50,
                      );
                    } catch (e) {
                      print(e);
                    }
                    if (imageBank != null) {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreviewPage(imageBank),
                        ),
                      );
                      print(result);
                      if (result == 'Yes') {
                        setState(() {
                          widget.bank = imageBank;
                        });
                      } else {
                        setState(() {
                          widget.bank = null;
                          imageBank = null;
                        });
                      }
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: widget.bank != null
                          ? Colors.green
                          : Color(0xff0E2F56),
                      shape: BoxShape.circle,
                      // border: Border.all(color: widget.bank!=null?Colors.green:Color(0xff0E2F56))
                    ),
                    child: Icon(
                      Icons.check,
                      color: widget.bank != null
                          ? Colors.white
                          : Color(0xff0E2F56),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: CustomButton(
              text: AppLocalizations.of('Save'),
              onTap: () async {
                showLoaderDialog(context);
                List<File> pan = new List<File>();
                List<File> bank = new List<File>();
                File file1 = new File(imagePan.path);
                File file2 = new File(imageBank.path);
                pan.add(file1);
                bank.add(file2);
                kyc data = kyc(
                  imagePan.path,
                  imageBank.path,
                  _teamController.text == null ? "" : _teamController.text,
                );
                var value;
                access_network().sendKyc(data).whenComplete(() async => {
                  value = await access_network().kyc_get(),
                  CheckValid(value['message']),
                  print(value),
                      ConstanceData.setProfile(
                          Profile.fromJson(value['Get_Kyc_data'])),
                  Navigator.pop(context),
                  Navigator.pop(context),
                    });
              },
            ),
          ),
          SizedBox(
            height: 10,
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

  CheckValid(value) async{
    if(value['message']=='Token is Expired'){
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.pushReplacementNamed(
          context, Routes.HOST);
    }else{

    }

  }
}
