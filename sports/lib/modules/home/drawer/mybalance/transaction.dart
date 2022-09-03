import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../Networking/AccessNetwork.dart';
import '../../../../constance/constance.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

enum time { Last_1_month, Last_3_month, Last_6_month, Last_1_year }

class _TransactionPageState extends State<TransactionPage> {
  time _currentA = time.Last_1_month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of('Transaction Statement'),
          style: Theme.of(context).textTheme.caption.copyWith(
                color: Theme.of(context).appBarTheme.color,
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
            color: Theme.of(context).appBarTheme.color,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(
                            'Choose time period for emailing transaction\nstatement:'),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              letterSpacing: 0.6,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Radio(
                                value: time.Last_1_month,
                                groupValue: _currentA,
                                onChanged: (value) {
                                  setState(() {
                                    _currentA = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              AppLocalizations.of('Last 1 month'),
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Radio(
                                value: time.Last_3_month,
                                groupValue: _currentA,
                                onChanged: (value) {
                                  setState(() {
                                    _currentA = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              AppLocalizations.of('Last 3 month'),
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Radio(
                                value: time.Last_6_month,
                                groupValue: _currentA,
                                onChanged: (value) {
                                  setState(() {
                                    _currentA = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              AppLocalizations.of('Last 6 month'),
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Radio(
                                value: time.Last_1_year,
                                groupValue: _currentA,
                                onChanged: (value) {
                                  setState(() {
                                    _currentA = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              AppLocalizations.of('Last 1 year'),
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            switch (_currentA) {
                              case time.Last_1_month:
                                sendInfo(1);
                                break;
                              case time.Last_3_month:
                                sendInfo(2);
                                break;
                              case time.Last_6_month:
                                sendInfo(3);
                                break;
                              default:
                                sendInfo(4);
                                break;
                            }
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                AppLocalizations.of('Next'),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color:
                                          Theme.of(context).appBarTheme.color,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6,
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendInfo(int i) {
    access_network()
        .transaction_history_req(ConstanceData.prof.id.toString(), i.toString())
        .then((_) {
      Fluttertoast.showToast(
          msg: "$_",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
