import 'dart:math';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:fantacySports/Model/Winner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Language/appLocalizations.dart';
import '../../../Model/Date_transaction.dart';
import '../../../Model/Paytm_Token.dart';
import '../../../Model/Profile.dart';
import '../../../Model/Transaction.dart';
import '../../../Networking/AccessNetwork.dart';
import '../../../constance/constance.dart';
import '../../../main.dart';
import '../../../widget/customButton.dart';
import 'Join/Select_Team_Create_Contest.dart';
import 'addTeam.dart';

class AddToWallet extends StatefulWidget {
  final fee,
      list,
      index,
      time,
      cid,
      match_id,
      name,
      size,
      total_prize,
      dataTeams,
      winner;

  AddToWallet(
      this.fee,
      this.list,
      this.index,
      this.time,
      this.cid,
      this.match_id,
      this.name,
      this.size,
      this.total_prize,
      this.dataTeams,
      this.winner);

  @override
  State<AddToWallet> createState() => _AddToWalletState();
}

class _AddToWalletState extends State<AddToWallet> {
  int totalAmount = 0;

  Razorpay _razorpay;
  TextEditingController _controller;

  AlertDialog alert;

  @override
  void initState() {
    super.initState();
    totalAmount = int.parse(widget.fee.toString()).toInt().round();
    _controller = TextEditingController();
    // _razorpay = Razorpay();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // setState(() {
    //   _controller.text = getFee().toString();
    // });
  }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   showLoaderDialog(context);
  //   print('Loader234 ');
  //   Fluttertoast.showToast(
  //       msg: "Payment Successful of ₹${totalAmount}\nPayment ID:" +
  //           response.paymentId);
  //   access_network()
  //       .updatePayment(ConstanceData.prof.id, response.signature,
  //           response.paymentId, response.orderId, totalAmount)
  //       .then((value) => {
  //             // Fluttertoast.showToast(msg: "${value['message']}"),
  //             access_network().kyc_get().then((value) => {
  //                   CheckValid(value),
  //                   setState(() {
  //                     ConstanceData.setProfile(
  //                         Profile.fromJson(value['Get_Kyc_data']));
  //                   }),
  //                 }),
  //           });
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   Fluttertoast.showToast(
  //       msg: "ERROR: " + response.code.toString() + " - " + response.message);
  //   print(response.message);
  //   Navigator.pop(context);
  // }
  //
  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName);
  //   Navigator.pop(context);
  // }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openPaymentOption(String orderId, razorpayId) async {
    // var response = AllInOneSdk.startTransaction('xAjeFD50602901490409', orderId,
    //     totalAmount.toString(), ' txnToken', 'callbackUrl', true, false);
    // response.then((value) {
    //   print(value);
    //   setState(() {
    //     // result = value.toString();
    //   });
    // }).catchError((onError) {
    //   if (onError is PlatformException) {
    //     print(onError.message);
    //     setState(() {
    //       // result = onError.message + " \n  " + onError.details.toString();
    //     });
    //   } else {
    //     print(onError.message);
    //     setState(() {
    //       // result = onError.toString();
    //     });
    //   }
    // });
    // var options = {
    //   'key': razorpayId,
    //   'amount': totalAmount * 100,
    //   'name': ConstanceData.prof.name,
    //   'order_id': orderId,
    //   'description': 'Adding money to wallet',
    //   'timeout': 60,
    //   'prefill': {
    //     'contact': ConstanceData.prof.phone,
    //     'email': ConstanceData.prof.email
    //   },
    //   'external': {
    //     'wallets': ['paytm']
    //   },
    // };
    //
    // try {
    //   _razorpay.open(options);
    // } catch (e) {
    //   debugPrint(e);
    // }
  }

  static final String tokenizationKey = 'sandbox_8hxpnkht_kzdtzv2btm4p7s5j';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: Column(
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
                              setState(() {
                                print(txt);
                              });
                            },
                            controller: _controller,
                            cursorColor: Colors.black,
                            decoration: new InputDecoration(
                              hintText: 'Enter Coupon Code',
                              hintStyle:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 16,
                                      ),
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                color:
                                    Theme.of(context).textTheme.bodyText2.color,
                              )),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black)),
                            ),
                            keyboardType: TextInputType.name,
                            style: Theme.of(context).textTheme.caption.copyWith(
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
                          child: Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade500,
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
                        padding:
                            const EdgeInsets.only(top: 8, left: 14, right: 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  '${(totalAmount + int.parse(ConstanceData.prof.balance.toString()))}',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              AppLocalizations.of('Amount to add'),
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
                            Text(
                              '${totalAmount}',
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
                // var request = BraintreeDropInRequest(
                //   tokenizationKey: tokenizationKey,
                //   collectDeviceData: true,
                //   googlePaymentRequest: BraintreeGooglePaymentRequest(
                //     totalPrice: '4.20',
                //     currencyCode: 'USD',
                //     billingAddressRequired: false,
                //   ),
                //   paypalRequest: BraintreePayPalRequest(
                //     amount: '4.20',
                //     displayName: 'Example company',
                //   ),
                //   cardEnabled: true,
                // );
                // BraintreeDropInResult result = await BraintreeDropIn.start(request);
                // if (result != null) {
                //   showNonce(result.paymentMethodNonce);
                // }
                startpayment();
              },
            ),
          ),
        ],
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
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
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

  check(value) {
    openPaymentOption(value['orderId'], value['razorpayId']);
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
    print('orderId ${orderId} ${token}');
    var response = AllInOneSdk.startTransaction(
      ConstanceData.mid,
      orderId,
      totalAmount.toString(),
      token,
      '${ConstanceData.callbackurl}?ORDER_ID=${orderId}',
      ConstanceData.isStaging,
      false,
    );
    response.then((value) {
      access_network().transactionStatus(orderId.toString()).then((value) => {
            if (value == "TXN_SUCCESS")
              {show(true, orderId, value)}
            else
              {show(false, orderId, 'Transaction Failed')}
          });
      // Navigator.pop(context);
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
            print('heresda');
            if (widget.dataTeams == null || widget.dataTeams.length <= 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTeam(
                      widget.list,
                      widget.index,
                      widget.list[widget.index].Competition.cid,
                      widget.list[widget.index].match_id,
                      widget.time.millisecondsSinceEpoch,
                      widget.name,
                      widget.size,
                      widget.fee,
                      widget.total_prize,
                      widget.winner,
                      _controller.text==null?'':_controller.text,
                    ),
                  ));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => select_team_create_contest(
                      widget.dataTeams,
                      widget.list[widget.index],
                      widget.name,
                      widget.size,
                      widget.fee,
                      widget.total_prize,
                      widget.winner,
                      _controller.text==null?'':_controller.text,
                    ),
                  ));
            }
          });
        });
      }
      Future.value(false);
    });
    return Future.delayed(Duration(seconds: 3), () {
      return Future.value(false);
    });
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
}
