import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/Profile.dart';
import 'package:fantacySports/Model/Transaction.dart';
import 'package:fantacySports/Networking/AccessNetwork.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/modules/home/drawer/mybalance/accountInfo.dart';
import 'package:fantacySports/modules/home/drawer/mybalance/transaction.dart';
import 'package:fantacySports/modules/matchDetail/contestDetail/addCash.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../../../Model/Date_transaction.dart';
import '../../../../main.dart';
import '../../../../widget/customButton.dart';
import 'All_Transactions.dart';
import 'Verify.dart';

class MyBalancePage extends StatefulWidget {
  @override
  _MyBalancePageState createState() => _MyBalancePageState();
}

class _MyBalancePageState extends State<MyBalancePage> {
  AlertDialog alert;
  var uuid = Uuid();
  var order_id;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of('My Balance'),
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
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            AppLocalizations.of('Total Balance'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .color,
                                      letterSpacing: 0.6,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "₹${ConstanceData.wallet_amount}",
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                  letterSpacing: 0.6,
                                  fontSize: 12,
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => {
                                  order_id = uuid.v4(),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddCashPage(),
                                    ),
                                  ).then((_) {
                                    showLoaderDialog(context);
                                    access_network().kyc_get().then((value) => {
                                          value['message'] == 'Token is Expired'
                                              ? logout()
                                              : print('valid'),
                                          ConstanceData.setProfile(
                                              Profile.fromJson(
                                                  value['Get_Kyc_data'])),

                                        });
                                  })
                                },
                                child: Container(
                                  height: 25,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of('Add Cash'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: Colors.white,
                                            letterSpacing: 0.6,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () => {
                                  showWithdrawDialog(context),

                                },
                                child: Container(
                                  height: 25,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of('Withdraw'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: Colors.white,
                                            letterSpacing: 0.6,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Container(
                        //   height: 300,
                        //   child: ConstanceData.transactions != null &&
                        //           ConstanceData.transactions.length > 0
                        //       ? ListView.builder(
                        //           itemCount: ConstanceData
                        //               .transactions[0].transactions.length,
                        //           shrinkWrap: true,
                        //           itemBuilder: (con, count) {
                        //             var data = ConstanceData
                        //                 .transactions[0].transactions[count];
                        //             return Container(
                        //               color: Colors.white,
                        //               child: Container(
                        //                 // color: Colors.grey.shade100,
                        //                 child: Column(
                        //                   children: [
                        //                     SizedBox(
                        //                       height: 10,
                        //                     ),
                        //                     // Divider(),
                        //                     Padding(
                        //                       padding: const EdgeInsets.only(
                        //                           left: 8, right: 8),
                        //                       child: Row(
                        //                         mainAxisAlignment:
                        //                             MainAxisAlignment
                        //                                 .spaceBetween,
                        //                         children: [
                        //                           Text(
                        //                             "${data.amount.toString().split('')[0] == '-' ? '-' + '₹${data.amount.toString().substring(1)}' : '₹' + data.amount.toString()}",
                        //                             style: Theme.of(context)
                        //                                 .textTheme
                        //                                 .caption
                        //                                 .copyWith(
                        //                                   color:
                        //                                       Theme.of(context)
                        //                                           .textTheme
                        //                                           .headline6
                        //                                           .color,
                        //                                   letterSpacing: 0.6,
                        //                                   fontSize: 16,
                        //                                 ),
                        //                           ),
                        //                           Expanded(child: SizedBox()),
                        //                           Text(
                        //                             AppLocalizations.of(
                        //                                 '${data.description}'),
                        //                             style: Theme.of(context)
                        //                                 .textTheme
                        //                                 .caption
                        //                                 .copyWith(
                        //                                   color:
                        //                                       Theme.of(context)
                        //                                           .textTheme
                        //                                           .bodyText2
                        //                                           .color,
                        //                                   letterSpacing: 0.6,
                        //                                   fontSize: 12,
                        //                                   // fontWeight:
                        //                                   // FontWeight.bold,
                        //                                 ),
                        //                           ),
                        //                           Expanded(child: SizedBox()),
                        //                           data.description == 'winnings'
                        //                               ? ElevatedButton(
                        //                                   child: Text(
                        //                                     'Verify',
                        //                                     style: Theme.of(
                        //                                             context)
                        //                                         .textTheme
                        //                                         .caption
                        //                                         .copyWith(
                        //                                           color: Theme.of(
                        //                                                   context)
                        //                                               .textTheme
                        //                                               .bodyText2
                        //                                               .color,
                        //                                           letterSpacing:
                        //                                               0.6,
                        //                                           fontSize: 12,
                        //                                           // fontWeight:
                        //                                           // FontWeight.bold,
                        //                                         ),
                        //                                   ),
                        //                                   style: ButtonStyle(
                        //                                     backgroundColor:
                        //                                         MaterialStateProperty
                        //                                             .all(Colors
                        //                                                 .grey
                        //                                                 .shade200),
                        //                                   ),
                        //                                   onPressed: () {
                        //                                     Navigator.push(
                        //                                       context,
                        //                                       MaterialPageRoute(
                        //                                         builder: (context) => Verify_Earnnings(),
                        //                                       ),
                        //                                     );
                        //                                   },
                        //                                 )
                        //                               : Container(),
                        //                           Expanded(child: SizedBox()),
                        //                           Icon(
                        //                             Icons.error_outline,
                        //                             color: Colors.blue,
                        //                             size: 20,
                        //                           )
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     data.description != 'winnings'
                        //                         ?SizedBox(
                        //                       height: 10,
                        //                     ):SizedBox(
                        //                       height: 5,
                        //                     ),
                        //                     data.description == 'winnings'
                        //                         ?Text(
                        //                       "You need to verify your account before withdrawals",
                        //                       style: Theme.of(context)
                        //                           .textTheme
                        //                           .caption
                        //                           .copyWith(
                        //                         color:
                        //                         Theme.of(context)
                        //                             .primaryColor,
                        //                         letterSpacing: 0.6,
                        //                         fontSize: 12,
                        //                       ),
                        //                     ):Container(),
                        //                     data.description == 'winnings'
                        //                         ?SizedBox(
                        //                       height: 5,
                        //                     ):Container(),
                        //                     Divider(
                        //                       height: 0.3,
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             );
                        //           },
                        //         )
                        //       : Center(
                        //           child: Text('No Prior Transactions'),
                        //         ),
                        // )
                        Container(
                          color: Colors.white,
                          child: Container(
                            // color: Colors.grey.shade100,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                // Divider(),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                                'Total amount added'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .color,
                                                  letterSpacing: 0.6,
                                                  fontSize: 14,
                                                  // fontWeight:
                                                  // FontWeight.bold,
                                                ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "₹${ConstanceData.transactions == null || ConstanceData.transactions.length <= 0 ? "0" : ConstanceData.transactions[0].amount}",
                                            // "₹${ConstanceData.transactions == null || ConstanceData.transactions.length <= 0 ? "0" : ConstanceData.transactions[0].transactions[0].amount}",
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  letterSpacing: 0.6,
                                                  fontSize: 16,
                                                ),
                                          ),
                                          // Expanded(child: SizedBox()),
                                        ],
                                      ),
                                      Expanded(child: SizedBox()),
                                      // data.description == 'winnings'
                                      Expanded(child: SizedBox()),
                                      Icon(
                                        Icons.error_outline,
                                        color: Colors.blue,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                                // data.description != 'winnings'

                                // data.description == 'winnings'
                                // data.description == 'winnings'
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  height: 0.3,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Container(
                            // color: Colors.grey.shade100,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                // Divider(),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of('Winnings'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .color,
                                                  letterSpacing: 0.6,
                                                  fontSize: 14,
                                                  // fontWeight:
                                                  // FontWeight.bold,
                                                ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "₹${ConstanceData.winnings}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  letterSpacing: 0.6,
                                                  fontSize: 16,
                                                ),
                                          ),
                                          // Expanded(child: SizedBox()),
                                        ],
                                      ),
                                      Expanded(
                                          flex: 5,
                                          child: SizedBox()),
                                      // data.description == 'winnings'
                                      ElevatedButton(
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
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.grey.shade200),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Verify_Earnnings(),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.error_outline,
                                        color: Colors.blue,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                                // data.description != 'winnings'
                                SizedBox(
                                  height: 5,
                                ),
                                // data.description == 'winnings'
                                Text(
                                  "You need to verify your account before withdrawals",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                      ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                // data.description == 'winnings'
                                false
                                    ? SizedBox(
                                        height: 5,
                                      )
                                    : Container(),
                                Divider(
                                  height: 0.3,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Container(
                            // color: Colors.grey.shade100,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                // Divider(),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of('CASH BONUS'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .color,
                                                  letterSpacing: 0.6,
                                                  fontSize: 14,
                                                  // fontWeight:
                                                  // FontWeight.bold,
                                                ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "₹0",
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  letterSpacing: 0.6,
                                                  fontSize: 16,
                                                ),
                                          ),
                                          // Expanded(child: SizedBox()),
                                        ],
                                      ),
                                      Expanded(child: SizedBox()),
                                      // data.description == 'winnings'
                                      Expanded(child: SizedBox()),
                                      Icon(
                                        Icons.error_outline,
                                        color: Colors.blue,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                                // data.description != 'winnings'

                                // data.description == 'winnings'
                                // data.description == 'winnings'
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  height: 0.3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // container(AppLocalizations.of('My Recent Transactions'), () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => TransactionPage(),
                //     ),
                //   );
                // }),
                container(
                  AppLocalizations.of('KYC Verification'),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountInfoPage(),
                      ),
                    );
                  },
                ),
                container(
                  AppLocalizations.of('All Transactions'),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => all_transactions(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget container(String txt1, VoidCallback onTap) {
    return Card(
      child: Container(
        height: 50,
        color: Theme.of(context).appBarTheme.color.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: InkWell(
            onTap: () {
              onTap();
            },
            child: Row(
              children: [
                Text(
                  txt1,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).textTheme.headline6.color,
                        letterSpacing: 0.6,
                        fontSize: 14,
                      ),
                ),
                Expanded(child: SizedBox()),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black26,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CheckValid(value) async {
    if (value == 'Token is Expired') {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      ConstanceData.transactions.clear();
      Navigator.pushReplacementNamed(context, Routes.HOST);
    } else {}
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      showLoaderDialog(context);
      access_network().getWallet().then((value) {
        if (value.status) {
          setState(() {
            ConstanceData.wallet_amount =
                int.parse(value.wallet_amount.toString());
            ConstanceData.winnings = int.parse(value.winnings.toString());
          });
        }
        access_network().kyc_get().then((value) => {
              value['message'] == 'Token is Expired'
                  ? logout()
                  : print('valid'),
              ConstanceData.setProfile(Profile.fromJson(value['Get_Kyc_data'])),
          Navigator.pop(context)
              // access_network()
              //     .TransactionHistory(value['Get_Kyc_data']['id'].toString())
              //     .then((value) => {
              //           if (value != null && value.length > 0)
              //             {
              //               if (mounted)
              //                 {
              //                   setState(() {
              //                     ConstanceData.setTransactions(value);
              //                     Navigator.pop(context);
              //                   })
              //                 }
              //               else
              //                 {
              //                   ConstanceData.setTransactions(value),
              //                   Navigator.pop(context),
              //                 }
              //             }
              //           else
              //             {
              //               if (mounted)
              //                 {
              //                   setState(() {
              //                     ConstanceData.setTransactions(
              //                         new List<date_transaction>());
              //                     Navigator.pop(context);
              //                   })
              //                 }
              //               else
              //                 {
              //                   ConstanceData.setTransactions(
              //                       new List<date_transaction>()),
              //                   Navigator.pop(context)
              //                 }
              //             }
              //         })
            });
      });
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

  fetchProfile() async {
    Navigator.pop(context);
  }

  logout() {
    ConstanceData.clear();
    try {
      ConstanceData.transactions.clear();
    } catch (e) {
      print(e);
    }
    Navigator.pushReplacementNamed(context, Routes.HOST);
  }

  // getTransacion() {
  //   for (var a in ConstanceData.transactions[0].transactions) {
  //     if (a.description.toString().trim() == 'Amount added') {
  //       return a;
  //     }
  //   }
  // }

  showWithdrawDialog(BuildContext context) {
    var _controller=TextEditingController();
    var totalAmount=0;
    alert = AlertDialog(
      title: Text(
          AppLocalizations.of('Withdraw money'),
          style:
          Theme.of(context).textTheme.caption.copyWith(
            color: Colors.green,
            letterSpacing: 0.6,
            fontSize: 12,
          ),
      ),
      content: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
        return SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 80,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            border: Border(bottom: BorderSide(color: Colors.green)),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 8, left: 14, right: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of('Amount to Withdraw'),
                                  style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                    color: Colors.green,
                                    letterSpacing: 0.6,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  onChanged: (txt) {
                                    setState(() {
                                      print(txt);
                                      if (txt != '' &&
                                          txt != null &&
                                          txt != 'null') {
                                        setState(() {totalAmount = int.parse(txt);});
                                      } else {
                                        totalAmount = 0;
                                      }
                                    });
                                  },
                                  controller: _controller,
                                  decoration: new InputDecoration.collapsed(
                                    hintText: 'Amount',
                                  ),
                                  keyboardType: TextInputType.number,
                                  style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                    letterSpacing: 0.6,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 14 , bottom: 20),
                child: CustomButton(
                  text: AppLocalizations.of('Add ₹${totalAmount}'),
                  onTap: () async {
                    if (totalAmount != 0&&totalAmount<=ConstanceData.wallet_amount) {
                      startWihdraw(totalAmount);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Enter a valid amount",
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
        );
      },),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void startWihdraw(totalAmount) {
    access_network()
        .payout(
        ConstanceData.id.toString(),
        totalAmount)
        .then((value) {
      Fluttertoast.showToast(
          msg: value,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
      access_network().getWallet().then((value) {
        if (value.status) {
          setState(() {
            ConstanceData.wallet_amount =
                int.parse(value.wallet_amount.toString());
            ConstanceData.winnings = int.parse(value.winnings.toString());
          });
        }
        access_network().kyc_get().then((value) => {
          value['message'] == 'Token is Expired'
              ? logout()
              : print('valid'),
          ConstanceData.setProfile(Profile.fromJson(value['Get_Kyc_data'])),

        });
      });
    });
  }

}
