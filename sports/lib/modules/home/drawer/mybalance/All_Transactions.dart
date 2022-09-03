import 'package:empty_widget/empty_widget.dart';
import 'package:fantacySports/Model/Transaction.dart';
import 'package:fantacySports/modules/home/drawer/mybalance/transaction.dart';
import 'package:fantacySports/modules/home/drawer/mybalance/transaction_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../Language/appLocalizations.dart';
import '../../../../Model/Date_transaction.dart';
import '../../../../Model/updated_transaction.dart';
import '../../../../Networking/AccessNetwork.dart';
import '../../../../constance/constance.dart';

class all_transactions extends StatefulWidget {
  const all_transactions({Key key}) : super(key: key);

  @override
  State<all_transactions> createState() => _all_transactionsState();
}

class _all_transactionsState extends State<all_transactions>
    with TickerProviderStateMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  ScrollController controller;
  TabController tabController;

  int page = 1;
  String current = 'deposit';
  var list = ['deposit', 'contest', 'withdrawal', 'other'];
  int status = 1;
  var statuslist = [0, 1, 2];
  bool next = true;

  void _onRefresh() async {
    // monitor network fetch
    print('page:${page}\n'
        'type:${current}\n'
        'status:${status}\n');
    page = 1;
    access_network()
        .TransactionHistory(
            ConstanceData.prof.id.toString(), current, status, page)
        .then((value) {
      if (value.status) {
        setState(() {
          ConstanceData.setTransactions(value.data);
          next = value.next;
        });
        _refreshController.refreshCompleted();
      } else {
        _refreshController.refreshFailed();
      }
    });
    // if failed,use refreshFailed()
  }

  void _onLoading() async {
    // monitor network fetch
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    ++page;
    access_network()
        .TransactionHistory(
            ConstanceData.prof.id.toString(), current, status, page)
        .then((value) {
      if (value.status) {
        setState(() {
          ConstanceData.addTransactions(value.data);
          next = value.next;
        });
        _refreshController.loadComplete();
      } else {
        _refreshController.loadFailed();
      }
    });
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent &&
        next) {
      _refreshController.requestLoading();
      print('requesting load');
    }
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    tabController.addListener(() {
      switch (tabController.index) {
        case 1:
          current = list[1];
          status = 1;
          _refreshController.requestRefresh();
          break;
        case 2:
          current = list[2];
          status = 1;
          _refreshController.requestRefresh();
          break;
        case 3:
          current = list[3];
          status = 1;
          _refreshController.requestRefresh();
          break;
        default:
          current = list[0];
          status = 1;
          _refreshController.requestRefresh();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of('All Transactions'),
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
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionPage(),
                  ),
                );
              },
              child: Icon(
                Icons.checklist,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        // enablePullUp: true,
        // header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.grey.shade100,
                ),
                height: 40,
                width: double.infinity,
                child: TabBar(
                  controller: tabController,
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(text: "Deposits"),
                    Tab(text: "Contests"),
                    Tab(text: "Withdrawals"),
                  ],
                ),
              ),
              SizedBox(
                // height: 40,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.grey.shade200,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            status = 1;
                            _refreshController.requestRefresh();
                          });
                        },
                        child: Card(
                          color:
                              status == 1 ? Colors.grey.shade100 : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Success',
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 13,
                                      ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            status = 0;
                            _refreshController.requestRefresh();
                          });
                        },
                        child: Card(
                          color:
                              status == 0 ? Colors.grey.shade100 : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'In-progress',
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 13,
                                      ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            status = 2;
                            _refreshController.requestRefresh();
                          });
                        },
                        child: Card(
                          color:
                              status == 2 ? Colors.grey.shade100 : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Failed',
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 13,
                                      ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ListViewer(groupTransaction(ConstanceData.transactions)),
                    ListViewer(groupTransaction(ConstanceData.transactions)),
                    ListViewer(groupTransaction(ConstanceData.transactions)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ListViewer(List<date_transaction2> list) {
    print('${list.length} ');
    return Container(
      child: list.isEmpty
          ? EmptyWidget(
              image: null,
              packageImage: PackageImage.Image_1,
              title: 'No Transactions',
              subTitle: 'No transactions for this category',
              titleTextStyle: TextStyle(
                fontSize: 22,
                color: Color(0xff9da9c7),
                fontWeight: FontWeight.w500,
              ),
              subtitleTextStyle: TextStyle(
                fontSize: 14,
                color: Color(0xffabb8d6),
              ),
            )
          : ListView.builder(
              controller: controller,
              // physics: NeverScrollableScrollPhysics(),
              itemCount: list.length,
              shrinkWrap: true,
              itemBuilder: (cont, index) {
                date_transaction2 current = list[index];
                return Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.shade100,
                        child: Text(
                          "${current.transactions[0].date.toString().split('T')[0]}",
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                letterSpacing: 0.6,
                                fontSize: 16,
                              ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: current.transactions.length,
                        shrinkWrap: true,
                        itemBuilder: (cont, pos) {
                          // Transaction present = current.transactions[pos];
                          UpdatedTransaction present =
                              current.transactions[pos];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return TransactionDetails(present);
                              }));
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  // height: 40,
                                  color: Colors.white,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35),
                                          ),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: Icon(
                                          Icons.list_alt_sharp,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Text(
                                            present.reason ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            present.date
                                                .toString()
                                                .split('T')[1]
                                                .toString()
                                                .split('.')[0]
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  fontSize: 12,
                                                ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        '₹${present.amount}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .color,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      getIcon(present.payment_method),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 0.2,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
    // return Container(
    //   child: ConstanceData.transactions != null &&
    //       ConstanceData.transactions.length > 0
    //       ?  ListView.builder(
    //     // physics: NeverScrollableScrollPhysics(),
    //     itemCount:
    //     ConstanceData
    //         .transactions.length,
    //     shrinkWrap: true,
    //     itemBuilder: (con, index) {
    //       var data1 =
    //       ConstanceData.transactions[index];
    //       return Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Container(
    //             width:MediaQuery.of(context).size.width,
    //             child: Text(
    //               "${data1.transactions[index].date.toString().split('T')[0]}",
    //               style: Theme.of(context)
    //                   .textTheme
    //                   .caption
    //                   .copyWith(
    //                 color: Theme.of(context)
    //                     .textTheme
    //                     .headline6
    //                     .color,
    //                 letterSpacing: 0.6,
    //                 fontSize: 16,
    //               ),
    //               textAlign: TextAlign.left,
    //             ),
    //           ),
    //           ListView.builder(
    //             // physics: NeverScrollableScrollPhysics(),
    //             itemCount: data1
    //                 .transactions
    //                 .length,
    //             shrinkWrap: true,
    //             itemBuilder: (con, count) {
    //               var data =data1
    //                   .transactions[count];
    //               return Container(
    //                 color: Colors.white,
    //                 child: ExpansionTile(
    //                   title: Container(
    //                     // color: Colors.grey.shade100,
    //                     child: Column(
    //                       children: [
    //                         SizedBox(
    //                           height: 10,
    //                         ),
    //                         // Divider(),
    //                         Padding(
    //                           padding:
    //                           const EdgeInsets
    //                               .only(
    //                               left: 8,
    //                               right: 8),
    //                           child: Row(
    //                             mainAxisAlignment:
    //                             MainAxisAlignment
    //                                 .spaceBetween,
    //                             children: [
    //                               Text(
    //                                 "${data.amount.toString().split('')[0] == '-' ? '-' + '₹${data.amount.toString().substring(1)}' : '₹' + data.amount.toString()}",
    //                                 style: Theme.of(
    //                                     context)
    //                                     .textTheme
    //                                     .caption
    //                                     .copyWith(
    //                                   color: Theme.of(context)
    //                                       .textTheme
    //                                       .headline6
    //                                       .color,
    //                                   letterSpacing:
    //                                   0.6,
    //                                   fontSize:
    //                                   16,
    //                                 ),
    //                               ),
    //                               // Expanded(child: SizedBox()),
    //                               Text(
    //                                 AppLocalizations.of(
    //                                     '${data.description}'),
    //                                 style: Theme.of(
    //                                     context)
    //                                     .textTheme
    //                                     .caption
    //                                     .copyWith(
    //                                   color: Theme.of(context)
    //                                       .textTheme
    //                                       .bodyText2
    //                                       .color,
    //                                   letterSpacing:
    //                                   0.6,
    //                                   fontSize:
    //                                   12,
    //                                   // fontWeight:
    //                                   // FontWeight.bold,
    //                                 ),
    //                               ),
    //                               // Expanded(child: SizedBox()),
    //
    //                               // Expanded(child: SizedBox()),
    //                               // Icon(
    //                               //   Icons.error_outline,
    //                               //   color: Colors.blue,
    //                               //   size: 20,
    //                               // )
    //                             ],
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height: 10,
    //                         ),
    //                         Divider(
    //                           height: 0.3,
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   children: [
    //                     Container(
    //                       color: Colors
    //                           .grey.shade100,
    //                       child: Column(
    //                         children: [
    //                           SizedBox(
    //                             height: 10,
    //                           ),
    //                           // Divider(),
    //                           data.transaction_id !=
    //                               null &&
    //                               data.transaction_id
    //                                   .isNotEmpty
    //                               ? Padding(
    //                             padding: const EdgeInsets
    //                                 .only(
    //                                 left:
    //                                 32,
    //                                 right:
    //                                 12),
    //                             child: Row(
    //                               mainAxisAlignment:
    //                               MainAxisAlignment
    //                                   .spaceBetween,
    //                               children: [
    //                                 Container(
    //                                   child:
    //                                   Text(
    //                                     AppLocalizations.of('Transaction Id'),
    //                                     textAlign:
    //                                     TextAlign.left,
    //                                     style: Theme.of(context).textTheme.caption.copyWith(
    //                                       color: Theme.of(context).textTheme.bodyText2.color,
    //                                       letterSpacing: 0.6,
    //                                       fontSize: 12,
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 Container(
    //                                   width:
    //                                   200,
    //                                   child:
    //                                   Text(
    //                                     "${data.transaction_id}",
    //                                     textAlign:
    //                                     TextAlign.left,
    //                                     overflow:
    //                                     TextOverflow.ellipsis,
    //                                     style: Theme.of(context).textTheme.caption.copyWith(
    //                                       color: Theme.of(context).textTheme.headline6.color,
    //                                       letterSpacing: 0.6,
    //                                       fontSize: 12,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           )
    //                               : Container(),
    //                           data.transaction_id !=
    //                               null &&
    //                               data.transaction_id
    //                                   .isNotEmpty
    //                               ? SizedBox(
    //                             height: 10,
    //                           )
    //                               : Container(),
    //                           data.transaction_id !=
    //                               null &&
    //                               data.transaction_id
    //                                   .isNotEmpty
    //                               ? Divider()
    //                               : Container(),
    //                           data.order_id !=
    //                               null &&
    //                               data.order_id
    //                                   .isNotEmpty
    //                               ? Padding(
    //                             padding: const EdgeInsets
    //                                 .only(
    //                                 left:
    //                                 32,
    //                                 right:
    //                                 12),
    //                             child: Row(
    //                               mainAxisAlignment:
    //                               MainAxisAlignment
    //                                   .spaceBetween,
    //                               children: [
    //                                 Container(
    //                                   child:
    //                                   Text(
    //                                     AppLocalizations.of('Order Id'),
    //                                     textAlign:
    //                                     TextAlign.left,
    //                                     style: Theme.of(context).textTheme.caption.copyWith(
    //                                       color: Theme.of(context).textTheme.bodyText2.color,
    //                                       letterSpacing: 0.6,
    //                                       fontSize: 12,
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 Container(
    //                                   child:
    //                                   Text(
    //                                     "${data.order_id}",
    //                                     textAlign:
    //                                     TextAlign.left,
    //                                     style: Theme.of(context).textTheme.caption.copyWith(
    //                                       color: Theme.of(context).textTheme.headline6.color,
    //                                       letterSpacing: 0.6,
    //                                       fontSize: 12,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           )
    //                               : Container(),
    //                           data.order_id !=
    //                               null &&
    //                               data.order_id
    //                                   .isNotEmpty
    //                               ? SizedBox(
    //                             height: 10,
    //                           )
    //                               : Container(),
    //                           data.order_id !=
    //                               null &&
    //                               data.order_id
    //                                   .isNotEmpty
    //                               ? Divider()
    //                               : Container(),
    //                           Padding(
    //                             padding:
    //                             const EdgeInsets
    //                                 .only(
    //                                 left: 32,
    //                                 right:
    //                                 12),
    //                             child: Row(
    //                               mainAxisAlignment:
    //                               MainAxisAlignment
    //                                   .spaceBetween,
    //                               children: [
    //                                 Container(
    //                                   child: Text(
    //                                     AppLocalizations.of(
    //                                         'Date'),
    //                                     textAlign:
    //                                     TextAlign
    //                                         .left,
    //                                     style: Theme.of(
    //                                         context)
    //                                         .textTheme
    //                                         .caption
    //                                         .copyWith(
    //                                       color:
    //                                       Theme.of(context).textTheme.bodyText2.color,
    //                                       letterSpacing:
    //                                       0.6,
    //                                       fontSize:
    //                                       12,
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 Container(
    //                                   child: Text(
    //                                     "${data.date.toString().split('T')[0]}",
    //                                     textAlign:
    //                                     TextAlign
    //                                         .left,
    //                                     style: Theme.of(
    //                                         context)
    //                                         .textTheme
    //                                         .caption
    //                                         .copyWith(
    //                                       color:
    //                                       Theme.of(context).textTheme.headline6.color,
    //                                       letterSpacing:
    //                                       0.6,
    //                                       fontSize:
    //                                       12,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 10,
    //                           ),
    //                           // Divider(),
    //                           // data.order_id!=null&&data.order_id.isNotEmpty?SizedBox(
    //                           //   height: 10,
    //                           // ):Container(),
    //                           data.order_id !=
    //                               null &&
    //                               data.order_id
    //                                   .isNotEmpty
    //                               ? Divider()
    //                               : Container(),
    //                           Padding(
    //                             padding:
    //                             const EdgeInsets
    //                                 .only(
    //                                 left: 32,
    //                                 right:
    //                                 12),
    //                             child: Row(
    //                               mainAxisAlignment:
    //                               MainAxisAlignment
    //                                   .spaceBetween,
    //                               children: [
    //                                 Container(
    //                                   child: Text(
    //                                     AppLocalizations.of(
    //                                         'Team Name'),
    //                                     textAlign:
    //                                     TextAlign
    //                                         .left,
    //                                     style: Theme.of(
    //                                         context)
    //                                         .textTheme
    //                                         .caption
    //                                         .copyWith(
    //                                       color:
    //                                       Theme.of(context).textTheme.bodyText2.color,
    //                                       letterSpacing:
    //                                       0.6,
    //                                       fontSize:
    //                                       12,
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 Container(
    //                                   child: Text(
    //                                     "${data.team_name}",
    //                                     textAlign:
    //                                     TextAlign
    //                                         .left,
    //                                     overflow:
    //                                     TextOverflow
    //                                         .ellipsis,
    //                                     style: Theme.of(
    //                                         context)
    //                                         .textTheme
    //                                         .caption
    //                                         .copyWith(
    //                                       color:
    //                                       Theme.of(context).textTheme.headline6.color,
    //                                       letterSpacing:
    //                                       0.6,
    //                                       fontSize:
    //                                       12,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 10,
    //                           ),
    //                           Divider(),
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               );
    //             },
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //         ],
    //       );
    //     },
    //   )
    //       : Center(
    //     child: Text('No Prior Transactions'),
    //   ),
    // );
  }

  List<date_transaction2> groupTransaction(List<UpdatedTransaction> list) {
    print('UPDATED ${list.length}');
    List<date_transaction2> temp = [];
    for (int i = 0; i < list.length; i++) {
      List<UpdatedTransaction> current = [];
      if (i == 0) {
        print('STEP1 ${list[i].date}');
        current.add(list[i]);
        temp.add(date_transaction2(current));
      } else {
        if (list[i].date.split('T')[0] == list[i - 1].date.split('T')[0]) {
          print('STEP2 ${list[i].date}');
          current.add(list[i]);
          // temp.add(date_transaction2(current));
          temp.last.transactions.add(list[i]);
        } else {
          print('STEP3 ${list[i].date}');
          current = [];
          current.add(list[i]);
          temp.add(date_transaction2(current));
        }
      }
    }
    print('UPDATED return ${temp.length}');
    return temp;
  }

  getIcon(String payment_method) {
    switch (payment_method) {
      case 'PAYTM':
        return Image.asset(
          'assets/images/paytm.webp',
          scale: 2,
        );
      case 'GOOGLEPAY':
        return Icon(FontAwesomeIcons.googlePay);
      case 'GPAY':
        return Icon(FontAwesomeIcons.googlePay);
      case 'PHONEPE':
        return Image.asset(
          'assets/images/phonepe.webp',
          scale: 2,
        );
      default:
        return Icon(Icons.payment);
    }
  }
}
