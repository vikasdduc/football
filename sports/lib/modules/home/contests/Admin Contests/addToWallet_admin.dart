import 'dart:math';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import '../../../../Language/appLocalizations.dart';
import '../../../../Model/ContestJoined.dart';
import '../../../../Model/Date_transaction.dart';
import '../../../../Model/Paytm_Token.dart';
import '../../../../Model/Profile.dart';
import '../../../../Model/Transaction.dart';
import '../../../../Model/generic_response.dart';
import '../../../../Networking/AccessNetwork.dart';
import '../../../../constance/constance.dart';
import '../../../../main.dart';
import '../../../../widget/customButton.dart';
import '../Join/Select_Team.dart';
import 'addPlayers_admin.dart';

class AddToWalletAdmin extends StatefulWidget {
  // final fee, list, index, time, cid, match_id, contest_id, teams, coupon, entry,team_id;
  final fee,
      list,
      index,
      time,
      cid,
      match_id,
      contest_id,
      teams,
      coupon,
      entry,
      team_id;
  final List<int> selectedRadioTile;

  AddToWalletAdmin(
      this.fee,
      this.list,
      this.index,
      this.time,
      this.cid,
      this.match_id,
      this.contest_id,
      this.teams,
      this.coupon,
      this.entry,
      this.team_id,
      this.selectedRadioTile);

  @override
  State<AddToWalletAdmin> createState() => _AddToWalletAdminState();
}

class _AddToWalletAdminState extends State<AddToWalletAdmin> {
  int totalAmount = 0;

  TextEditingController _controller = TextEditingController();
  TextEditingController _couponcontroller = TextEditingController();
  String coupon = '';

  int total_fee;

  AlertDialog alert;

  @override
  void initState() {
    super.initState();
    print('fee ${widget.fee}');
    totalAmount = int.parse(widget.fee.toString()).toInt().round()*(widget.selectedRadioTile.isEmpty?1:widget.selectedRadioTile.length);
    total_fee =
        (totalAmount);
    totalAmount = totalAmount - int.parse(ConstanceData.prof.balance.toString());
    _controller = TextEditingController();
    ConstanceData.contest_joined_bill = contest_joined(total_fee.toString(),
        ConstanceData.prof.balance.toString(), totalAmount.toString());

    Future.delayed(Duration.zero, () {
      if (widget.coupon != '') {
        _couponcontroller.text = widget.coupon;
        access_network()
            .apply_coupon(_couponcontroller.text, totalAmount.toString(),
                ConstanceData.prof.id.toString())
            .then((_) {
          if (_['message'] == 'Final Amount') {
            setState(() {
              // totalAmount = double.parse(_['data'].toString()).toInt();
              // total_fee = (totalAmount);
              coupon = _couponcontroller.text;
            });
            Fluttertoast.showToast(
                msg: "Cupon applied successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            _couponcontroller.text = '';
            Fluttertoast.showToast(
                msg: "${_['message']}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _razorpay.clear();
    _couponcontroller.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
              color: Theme.of(context).primaryColor,
            ),
            Container(
              height: AppBar().preferredSize.height,
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      AppLocalizations.of('Add Cash'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Colors.white,
                            letterSpacing: 0.6,
                            fontSize: 22,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: AppBar().preferredSize.height,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.wallet,
                      color: Colors.orange,
                      size: 22,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      AppLocalizations.of('Current Balance'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).textTheme.headline6.color,
                            letterSpacing: 0.6,
                            fontSize: 16,
                          ),
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      "₹${ConstanceData.prof.balance == null ? 0 : ConstanceData.prof.balance}",
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).textTheme.headline6.color,
                            letterSpacing: 0.6,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
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
                        height: 75,
                        decoration: BoxDecoration(
                            // color: Colors.green.withOpacity(0.1),
                            // border: Border(bottom: BorderSide(color: Colors.green)),
                            ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 14, right: 14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of('Total Fee'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: Colors.black,
                                          letterSpacing: 0.6,
                                          fontSize: 12,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${ total_fee}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(
                                        'To be deducted from wallet'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: Colors.black,
                                          letterSpacing: 0.6,
                                          fontSize: 12,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '- ${(int.parse(ConstanceData.prof.balance.toString()))}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of('Total payable'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: Colors.black,
                                          letterSpacing: 0.6,
                                          fontSize: 12,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${totalAmount}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of('Have a Coupon Code?'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).textTheme.headline6.color,
                            letterSpacing: 0.6,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 150,
                          child: Center(
                            child: TextField(
                              onChanged: (txt) {
                                // setState(() {
                                //   coupon = txt == null ? '' : txt;
                                // });
                              },
                              controller: _couponcontroller,
                              cursorColor: Colors.black,
                              decoration: new InputDecoration(
                                hintText: 'Enter Coupon Code',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .color,
                                      letterSpacing: 0.6,
                                      fontSize: 16,
                                    ),
                                enabledBorder: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .color,
                                )),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.black)),
                              ),
                              keyboardType: TextInputType.name,
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
                          ),
                        ),
                        Material(
                          child: InkWell(
                            onTap: () {
                              if (_couponcontroller.text.length > 0) {
                                var txt = _couponcontroller.text;
                                access_network()
                                    .apply_coupon(
                                        _couponcontroller.text,
                                        totalAmount.toString(),
                                        ConstanceData.prof.id.toString())
                                    .then((_) {
                                  if (_['message'] == 'Final Amount') {
                                    setState(() {
                                      // totalAmount = totalAmount-
                                      //     double.parse(_['data'].toString())
                                      //         .toInt();
                                      // total_fee = (double.parse(_['data'].toString())
                                      //     .toInt() +
                                      //     int.parse(ConstanceData.prof.balance
                                      //         .toString()));
                                      coupon = _couponcontroller.text;
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Coupon applied successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    _couponcontroller.text = '';
                                    Fluttertoast.showToast(
                                        msg: "${_['message']}",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                });
                              } else {}
                            },
                            child: Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: coupon.length > 0
                                      ? Colors.grey.shade200
                                      : Colors.grey.shade500,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  'APPLY CODE',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Colors.grey.shade900,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
                          border:
                              Border(bottom: BorderSide(color: Colors.green)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 14, right: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of('Amount to add'),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.green,
                                      letterSpacing: 0.6,
                                      fontSize: 12,
                                    ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${totalAmount}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
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
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, bottom: 20),
              child: CustomButton(
                text: AppLocalizations.of('Add ₹${totalAmount}'),
                color: Colors.green,
                onTap: () async {
                  if (totalAmount != 0) {
                    startpayment();
                  } else {}
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startpayment() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Card(
        color: Theme.of(context).appBarTheme.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.color,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of('Select Payment Option'),
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.black,
                        letterSpacing: 0.6,
                        fontSize: 18,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // RazorPay();
                    paytm();
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          'assets/images/paytm.webp',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Paytm",
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              letterSpacing: 0.6,
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // RazorPay();
                    // paytm();
                    cashfree();
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/images/cashfree.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Cashfree",
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              letterSpacing: 0.6,
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
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
      Navigator.pushReplacementNamed(context, Routes.HOST);
    } else {}
  }

  int getFee() {
    print('${widget.fee.toString().split('')}');
    if (int.parse(widget.fee
            .toString()
            .split('')[widget.fee.toString().split('').length - 1]) ==
        0) {
      return int.parse(widget.fee.toString()).toInt().round();
    } else {
      var a = 10 -
          int.parse(widget.fee
              .toString()
              .split('')[widget.fee.toString().split('').length - 1]);
      print('b ${a} ${int.parse(widget.fee.toString()) + a}');
      return int.parse(widget.fee.toString()) + a;
    }
  }

  void paytm() async {
    String r = Random().nextInt(999999).toString().padLeft(6, '0');
    access_network()
        .paytm_do_payment(ConstanceData.prof.id.toString(),
            'order_JFLkEB0mzZDRTH', totalAmount.toString())
        .then((_) {
      paytm_token token = _;
      continuePayment(token.order_id, token.txnToken);
    });
  }

  void continuePayment(orderId, token) {
    var response = AllInOneSdk.startTransaction(
        ConstanceData.mid,
        orderId,
        totalAmount.toString(),
        token,
        '${ConstanceData.callbackurl}?ORDER_ID=${orderId}',
        ConstanceData.isStaging,
        true,
        false);
    response.then((value) {
      access_network().transactionStatus(orderId.toString()).then((value) => {
            if (value == "TXN_SUCCESS")
              {show(true, orderId, value)}
            else
              {show(false, orderId, 'Transaction Failed')}
          });
    }).catchError((onError) {
      if (onError is PlatformException) {
        print('as t2 ${onError}');
        Navigator.pop(context);
        show(false, orderId, onError);
      } else {
        print('as t3 ${onError.message}');
        Navigator.pop(context);
        show(false, orderId, onError);
      }
    });
  }

  show(bool success, String id, dynamic value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Text(
                success ? 'Transaction successful' : 'Transaction failed',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: success ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
              ),
            ],
          ),
          content: SizedBox(
            height: 130,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: success
                        ? Colors.green.withOpacity(0.25)
                        : Colors.red.withOpacity(0.25),
                    // border color
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    success ? Icons.check : Icons.cancel,
                    color:
                        success ? Colors.green.shade900 : Colors.red.shade900,
                    size: 50,
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                Text(
                  success
                      ? 'Your Transaction Id is ${id}'
                      : 'Please try again later',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: success ? Colors.green : Colors.red,
                        fontSize: 13,
                      ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                if (success) {
                  Navigator.pop(context);
                }
                Navigator.pop(context);
              },
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.all(7),
                  child: new Text(
                    'Done',
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: success ? Colors.green : Colors.red,
                          fontSize: 14,
                        ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).whenComplete(() {
      if (success) {
        showLoaderDialog(context);
        access_network().getWallet().then((value) {
          if (value.status) {
            if (mounted) {
              setState(() {
                ConstanceData.wallet_amount =
                    int.parse(value.wallet_amount.toString());
                ConstanceData.winnings = int.parse(value.winnings.toString());
              });
            } else {
              ConstanceData.wallet_amount =
                  int.parse(value.wallet_amount.toString());
              ConstanceData.winnings = int.parse(value.winnings.toString());
            }
          }
          access_network().kyc_get().then((value) {
            CheckValid(value);
            setState(() {
              ConstanceData.setProfile(Profile.fromJson(value['Get_Kyc_data']));
            });
            join(widget.selectedRadioTile.length).then((value2) {
              Fluttertoast.showToast(
                  msg: "${value2.message}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              if (value2.status) {
                access_network().getTeam().then((value3) {
                  fetchContest();
                });
              }
            });
          });
        });
      }
      Future.value(false);
    });
    return Future.delayed(Duration(seconds: 3), () {
      return Future.value(false);
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

  void cashfree() async {
    showLoaderDialog(context);
    access_network()
        .cashfreeTransaction(
            await ConstanceData.getId(),
            totalAmount.toString(),
            ConstanceData.prof.phone.toString(),
            ConstanceData.prof.name,
            ConstanceData.prof.email)
        .then((value) {
      Navigator.pop(context);
      print(value.notify_url);
      if (value.status) {
        print('orser ${value.orderid}');
        var data = {
          'stage': 'TEST',
          'appId': ConstanceData.cashfreeID,
          'orderId': value.orderid.toString(),
          'notifyUrl': value.notify_url,
          'orderCurrency': 'INR',
          'tokenData': value.cashfreeToken.cftoken,
          'orderAmount': totalAmount.toString(),
          'customerName': ConstanceData.prof.name,
          'customerEmail': ConstanceData.prof.email,
          'customerPhone': ConstanceData.prof.phone.toString(),
        };
        print(data);
        CashfreePGSDK.doPayment(data).then((value) {
          if (value["txStatus"] == "SUCCESS") {
            show(true, value["orderId"], value);
          } else {
            show(false, value["orderId"], value);
          }
        });
      } else {
        Fluttertoast.showToast(
            msg: value.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        show(false, value.orderid, value);
      }

      // Navigator.push(context,
      //     MaterialPageRoute(builder: (BuildContext context) {
      //   return CashFreeWebview(
      //     value.paymentLink,
      //   );
      // }));
    });
  }

  void fetchContest() {
    access_network()
        .getCompletions(widget.match_id.toString())
        .then((value) => {
              ConstanceData.setContests(value),
              Navigator.popUntil(context, ModalRoute.withName("/home")),
            });
  }

  Future<GenericResponse> join(int length) async {
    if (length > 1) {
      return await access_network().join_multiple_contest(
          widget.contest_id.toString(),
          ConstanceData.prof.id.toString(),
          widget.match_id.toString(),
          widget.cid.toString(),
          // widget.dataTeams[selectedRadioTile[0]].id.toString(),
          widget.selectedRadioTile[0].toString(),
          widget.coupon,
          widget.selectedRadioTile);
    } else {
      return await access_network().join_contest(
          widget.contest_id.toString(),
          ConstanceData.prof.id.toString(),
          widget.match_id.toString(),
          widget.cid.toString(),
          widget.team_id.toString(),
          widget.coupon);
    }
  }
}
