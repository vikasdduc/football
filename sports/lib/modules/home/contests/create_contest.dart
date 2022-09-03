import 'package:fantacySports/modules/home/contests/prize_break_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../../../Language/appLocalizations.dart';
import '../../../constance/constance.dart';

class CreateContest extends StatefulWidget {
  final list, index, time,dataTeams;

  CreateContest(this.list, this.index, this.time,this.dataTeams);

  @override
  State<CreateContest> createState() => _CreateContestState();
}

class _CreateContestState extends State<CreateContest> {
  var _controller1 = TextEditingController();
  var _controller2 = TextEditingController();
  var _controller3 = TextEditingController();

  var txt = "_";

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.zero,
        color: Colors.grey.shade300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
              color: Theme.of(context).primaryColor,
            ),
            //Red space
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
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 270,
                            child: Text(
                              AppLocalizations.of('Create Contest'),
                              overflow: TextOverflow.ellipsis,
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
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
            Card(
              elevation: 1,
              child: Container(

                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 7,
                          right: 7,
                          bottom: 2,
                          top: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                txt = getAmount();
                              });
                            },
                            controller: _controller1,
                            decoration: new InputDecoration(
                              hintText: 'Contest Name',
                              hintStyle:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Colors.grey.shade600,
                                        letterSpacing: 0.6,
                                        fontSize: 20,
                                      ),
                            ),
                            // keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.black,
                                  letterSpacing: 0.6,
                                  fontSize: 18,
                                ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 7,
                          right: 7,
                          bottom: 2,
                          top: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                txt = getAmount();
                              });
                            },
                            controller: _controller2,
                            decoration: new InputDecoration(
                              hintText: 'Contest Size',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                color: Colors.grey.shade600,
                                letterSpacing: 0.6,
                                fontSize: 20,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(
                              color: Colors.black,
                              letterSpacing: 0.6,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 7,
                          right: 7,
                          bottom: 2,
                          top: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                txt = getAmount();
                              });
                            },
                            controller: _controller3,
                            decoration: new InputDecoration(
                              hintText: 'Entry',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                color: Colors.grey.shade600,
                                letterSpacing: 0.6,
                                fontSize: 20,
                              ),
                              errorText: _controller3.text.isEmpty
                                  ? null
                                  : int.parse(_controller3.text
                                  .toString()) <=
                                  5
                                  ? 'Minimum value should be 5'
                                  : null,
                              errorStyle: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                color: Colors.red,
                                fontSize: 10,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(
                              color: Colors.black,
                              letterSpacing: 0.6,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 50,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         height: 50,
                    //         width: MediaQuery.of(context).size.width,
                    //         padding: EdgeInsets.only(
                    //           left: 7,
                    //           right: 7,
                    //           bottom: 2,
                    //           top: 2,
                    //         ),
                    //         decoration: BoxDecoration(
                    //           color: Colors.grey.shade200,
                    //           borderRadius: BorderRadius.all(
                    //             Radius.circular(5),
                    //           ),
                    //         ),
                    //         child: Center(
                    //           child: TextField(
                    //             onChanged: (text) {
                    //               setState(() {
                    //                 txt = getAmount();
                    //               });
                    //             },
                    //             controller: _controller2,
                    //             decoration: new InputDecoration(
                    //               hintText: 'Contest Size',
                    //               hintStyle: Theme.of(context)
                    //                   .textTheme
                    //                   .caption
                    //                   .copyWith(
                    //                     color: Colors.grey.shade600,
                    //                     letterSpacing: 0.6,
                    //                     fontSize: 20,
                    //                   ),
                    //             ),
                    //             keyboardType: TextInputType.number,
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .caption
                    //                 .copyWith(
                    //                   color: Colors.black,
                    //                   letterSpacing: 0.6,
                    //                   fontSize: 18,
                    //                 ),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 15,
                    //       ),
                    //       Container(
                    //         height: 50,
                    //         padding: EdgeInsets.only(
                    //           left: 7,
                    //           right: 7,
                    //           bottom: 2,
                    //           top: 2,
                    //         ),
                    //         decoration: BoxDecoration(
                    //           color: Colors.grey.shade200,
                    //           borderRadius: BorderRadius.all(
                    //             Radius.circular(5),
                    //           ),
                    //         ),
                    //         child: Center(
                    //           child: TextField(
                    //             onChanged: (text) {
                    //               setState(() {
                    //                 txt = getAmount();
                    //               });
                    //             },
                    //             controller: _controller3,
                    //             decoration: new InputDecoration(
                    //               hintText: 'Entry',
                    //               hintStyle: Theme.of(context)
                    //                   .textTheme
                    //                   .caption
                    //                   .copyWith(
                    //                     color: Colors.grey.shade600,
                    //                     letterSpacing: 0.6,
                    //                     fontSize: 20,
                    //                   ),
                    //               errorText: _controller3.text.isEmpty
                    //                   ? null
                    //                   : int.parse(_controller3.text
                    //                               .toString()) <=
                    //                           5
                    //                       ? 'Minimum value should be 5'
                    //                       : null,
                    //               errorStyle: Theme.of(context)
                    //                   .textTheme
                    //                   .caption
                    //                   .copyWith(
                    //                     color: Colors.red,
                    //                     fontSize: 10,
                    //                   ),
                    //             ),
                    //             keyboardType: TextInputType.number,
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .caption
                    //                 .copyWith(
                    //                   color: Colors.black,
                    //                   letterSpacing: 0.6,
                    //                   fontSize: 18,
                    //                 ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 1,
              child: Container(
                height: 70,
                padding: EdgeInsets.only(
                  top: 12,
                  bottom: 12,
                  right: 12,
                  left: 12,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo-red.webp',
                      scale: 25.0,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prize Pool',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Text(
                          '${txt}',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Card(
              elevation: 0,
              child: Container(
                height: 70,
                padding: EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                  right: 10,
                  left: 10,
                ),
                child: Material(
                  child: InkWell(
                    splashColor: Colors.grey.shade800,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrizeBreakDown(
                            _controller1.text.toString(),
                            _controller2.text.toString(),
                            _controller3.text.toString(),
                            txt,
                            widget.list,
                            widget.index,
                            widget.time,
                              widget.dataTeams,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 40,
                      color: Colors.green,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'CHOOSE PRIZE BREAKUP',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getAmount() {
    print('heZD');
    if (_controller1.text.isNotEmpty &&
        _controller2.text.isNotEmpty &&
        _controller3.text.isNotEmpty) {
      var val = int.parse(_controller2.text.toString()) *
          int.parse(_controller3.text.toString());
      return (val - val / 100 * 5).toInt().toString();
    } else {
      return '';
    }
  }
}
