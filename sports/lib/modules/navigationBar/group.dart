import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Networking/AccessNetwork.dart';
import '../../widget/customTextField.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  AlertDialog alert;
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneController = TextEditingController();
  var _queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // showLoaderDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey.shade200,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: AppLocalizations.of('Enter Name'),
                controller: _nameController,
              ),
              CustomTextField(
                hintText: AppLocalizations.of('Enter Email'),
                controller: _emailController,
              ),
              CustomTextField(
                hintText: AppLocalizations.of('Enter Phone Number'),
                controller: _phoneController,
              ),
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
                      maxLines: 5,
                      controller: _queryController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 14, right: 14),
                        focusColor: Colors.white,
                        border: InputBorder.none,
                        hintText: AppLocalizations.of('Enter your query'),
                        hintStyle:
                            Theme.of(context).textTheme.headline6.copyWith(
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    if (_queryController.text.isNotEmpty &&
                        _nameController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _phoneController.text.isNotEmpty &&
                        isEmail(_emailController.text) &&
                        _isNumeric(_phoneController.text)&&_phoneController.text.length==10) {
                      update();
                    } else {
                      Fluttertoast.showToast(
                          msg: "Enter the correct details",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Container(
                    color: Colors.green,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
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

  showLoaderDialog(BuildContext context) {
    alert = AlertDialog(
      content: Container(
        child: Column(
          children: [
            CustomTextField(
              hintText: AppLocalizations.of('Enter Team Name'),
              // controller: _teamController,
            ),
            CustomTextField(
              hintText: AppLocalizations.of('Enter Team Name'),
              // controller: _teamController,
            ),
          ],
        ),
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

  void update() {
    access_network()
        .create_query(_queryController.text, _nameController.text,
        _emailController.text, _phoneController.text.toString())
        .then((_) {
      _queryController.clear();
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
    });
  }
}
