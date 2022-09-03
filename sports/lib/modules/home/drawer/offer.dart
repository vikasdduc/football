import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:flutter/material.dart';

import '../../../Model/Cupon.dart';
import '../../../Networking/AccessNetwork.dart';

class OfferScreen extends StatefulWidget {
  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  var _controller = TextEditingController();
  List<cupon> list = List<cupon>();


  @override
  void initState() {
    super.initState();
    fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of('Offers & Coupons'),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.help,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card(
          //   child: Container(
          //     color: Colors.white,
          //     padding: EdgeInsets.all(15.0),
          //     width: MediaQuery.of(context).size.width,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           AppLocalizations.of('Have a Coupon Code?'),
          //           style: Theme.of(context).textTheme.caption.copyWith(
          //                 color: Theme.of(context).textTheme.headline6.color,
          //                 letterSpacing: 0.6,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 16,
          //               ),
          //         ),
          //         SizedBox(
          //           height: 40,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             SizedBox(
          //               height: 40,
          //               width: 150,
          //               child: Center(
          //                 child: TextField(
          //                   onChanged: (txt) {
          //                     setState(() {
          //                       print(txt);
          //                     });
          //                   },
          //                   controller: _controller,
          //                   cursorColor: Colors.black,
          //                   decoration: new InputDecoration(
          //                     hintText: 'Enter Coupon Code',
          //                     hintStyle:
          //                         Theme.of(context).textTheme.caption.copyWith(
          //                               color: Theme.of(context)
          //                                   .textTheme
          //                                   .bodyText2
          //                                   .color,
          //                               letterSpacing: 0.6,
          //                               fontSize: 16,
          //                             ),
          //                     enabledBorder: new UnderlineInputBorder(
          //                         borderSide: new BorderSide(
          //                       color:
          //                           Theme.of(context).textTheme.bodyText2.color,
          //                     )),
          //                     focusedBorder: UnderlineInputBorder(
          //                         borderSide:
          //                             new BorderSide(color: Colors.black)),
          //                   ),
          //                   keyboardType: TextInputType.name,
          //                   style: Theme.of(context).textTheme.caption.copyWith(
          //                         color: Theme.of(context)
          //                             .textTheme
          //                             .headline6
          //                             .color,
          //                         letterSpacing: 0.6,
          //                         fontWeight: FontWeight.bold,
          //                         fontSize: 16,
          //                       ),
          //                 ),
          //               ),
          //             ),
          //             Material(
          //               child: InkWell(
          //                 child: Container(
          //                   height: 40,
          //                   width: 120,
          //                   decoration: BoxDecoration(
          //                       color: Colors.grey.shade500,
          //                       borderRadius: BorderRadius.circular(5)),
          //                   child: Center(
          //                     child: Text(
          //                       'APPLY CODE',
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .caption
          //                           .copyWith(
          //                             color: Colors.grey.shade900,
          //                             letterSpacing: 0.6,
          //                             fontSize: 14,
          //                           ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // getNotAvailable()
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              AppLocalizations.of('Active'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Theme.of(context).textTheme.headline6.color,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height-500,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (cont,index){
                var data = list[index];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 5,
                    child: Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width-20,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 10, top: 10),
                            height: 25,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  AppLocalizations.of('${data.expire.toString().split('T')[0]}'),
                                  style: Theme.of(context).textTheme.caption.copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.6,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.all(15.00),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade100,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.discount,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   AppLocalizations.of('₹ ${data.value}'),
                                          //   style: Theme.of(context)
                                          //       .textTheme
                                          //       .caption
                                          //       .copyWith(
                                          //     color: Colors.black,
                                          //     fontWeight: FontWeight.bold,
                                          //     letterSpacing: 0.6,
                                          //     fontSize: 20,
                                          //   ),
                                          // ),
                                          Text(
                                            AppLocalizations.of('${data.value}% Off'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.6,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            AppLocalizations.of(
                                                '${data.title}'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                              color: Colors.grey.shade900,
                                              letterSpacing: 0.6,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    color: Colors.grey.shade200,
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of('Offer Details'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                          color: Colors.blue,
                                          letterSpacing: 0.6,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 3,
                                      bottom: 3,
                                    ),
                                    color: Colors.green.shade100,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          AppLocalizations.of(
                                              'Received on ${data.updated_at.toString().split('T')[0]}'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .copyWith(
                                            color: Colors.grey,
                                            letterSpacing: 0.6,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of('Inactive'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).textTheme.headline6.color,
                            letterSpacing: 0.6,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  getNotAvailable() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            AppLocalizations.of('You have no offers or coupons at the moment'),
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Theme.of(context).textTheme.bodyText2.color,
                  letterSpacing: 0.6,
                  fontSize: 14,
                ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 150,
          width: 100,
          child: Image.asset(
            ConstanceData.coupons,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            AppLocalizations.of(
                'Keep an eye out for promotions and offers\nfor exciting rewards!'),
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Theme.of(context).textTheme.bodyText2.color,
                  letterSpacing: 0.6,
                  fontSize: 14,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  void fetchList() {
    access_network().get_coupon().then((_){
      setState(() {
        list = _;
      });
    });
  }
}
