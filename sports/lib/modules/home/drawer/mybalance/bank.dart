import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Model/BANK.dart';
import '../../../../Networking/AccessNetwork.dart';
import '../../../../Testing/Preview.dart';
import '../../../../constance/constance.dart';
import '../../../../widget/customButton.dart';
import '../../../../widget/customTextField.dart';

class BankPage extends StatefulWidget {
  var bank;
  @override
  _BankPageState createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  var _nameController = TextEditingController();
  var _bankController = TextEditingController();
  var _accountController = TextEditingController();
  var _ifscController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile image;


  @override
  void dispose() {
    super.dispose();
    _bankController.dispose();
    _nameController.dispose();
    _accountController.dispose();
    _ifscController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.image,
                              color: Colors.black87,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of('Verify Your Bank Account'),
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: GestureDetector(
                            onTap: () async {
                              try {
                                image = await _picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 50,
                                );
                              } catch (e) {
                                print(e);
                              }
                              if (image != null) {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PreviewPage(image),
                                  ),
                                );
                                print(result);
                                if (result == 'Yes') {
                                  setState(() {
                                    widget.bank = image;
                                  });
                                } else {
                                  setState(() {
                                    widget.bank = null;
                                    image = null;
                                  });
                                }
                              }
                            },
                            child: Card(
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(
                                        'Upload Bank Passbook Image'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: Colors.grey.shade700,
                                          fontSize: 12,
                                          letterSpacing: 0.6,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          controller: _nameController,
                          hintText: AppLocalizations.of('Name*'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Text(
                            AppLocalizations.of('Account Name'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6,
                                      fontSize: 10,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          controller: _accountController,
                          hintText: AppLocalizations.of('Account number*'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Text(
                            AppLocalizations.of('Bank Account'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6,
                                      fontSize: 10,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          controller: _ifscController,
                          hintText: AppLocalizations.of('IFSC code*'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Text(
                            AppLocalizations.of('Enter your banks IFSC'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6,
                                      fontSize: 10,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          controller: _bankController,
                          hintText: AppLocalizations.of('Bank name*'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Text(
                            AppLocalizations.of('Enter your Banks name'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6,
                                      fontSize: 10,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            AppLocalizations.of('All fields are mandatory'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Colors.black54,
                                      letterSpacing: 0.6,
                                      fontSize: 12,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: CustomButton(
                            onTap: (){
                              if (_nameController.text.isNotEmpty&&_bankController.text.isNotEmpty&&_accountController.text.isNotEmpty&&_ifscController.text.isNotEmpty) {
                                if (widget.bank!=null) {
                                  if (_isNumeric(_accountController.text)) {
                                    uploadAll();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                        "Enter a valid account number",
                                        toastLength: Toast
                                            .LENGTH_SHORT,
                                        gravity: ToastGravity
                                            .CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                        Colors.red,
                                        textColor:
                                        Colors.white,
                                        fontSize: 16.0);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                      "Please Upload a image",
                                      toastLength: Toast
                                          .LENGTH_SHORT,
                                      gravity: ToastGravity
                                          .CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                      Colors.red,
                                      textColor:
                                      Colors.white,
                                      fontSize: 16.0);
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                    "Enter all the details",
                                    toastLength: Toast
                                        .LENGTH_SHORT,
                                    gravity: ToastGravity
                                        .CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor:
                                    Colors.red,
                                    textColor:
                                    Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            color: Colors.green,
                            text:
                                AppLocalizations.of('Submit For Verification'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }
  void uploadAll() {
      access_network().sendBank(bank(ConstanceData.prof.id.toString(),_nameController.text,_accountController.text,
          _ifscController.text,_bankController.text,widget.bank.path)).then((_){
        print('Done');
        Navigator.of(context).pop();
      });
  }
}
