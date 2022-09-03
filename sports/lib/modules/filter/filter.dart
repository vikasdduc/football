import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  final Function onTapEntry;
  final Function onTapTeams;
  final Function onTapPrize;
  final Function onTapType;
  final Function onTapClear;
  final int entry, prize;

  // Function onTapPrize;
  FilterPage({
    this.onTapEntry,
    this.onTapTeams,
    this.onTapClear,
    this.entry,
    this.prize, this.onTapPrize, this.onTapType,
  });

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.color,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).padding.top,
                color: Theme.of(context).textTheme.headline6.color,
              ),
              Container(
                color: Color(0xffF3F3F3),
                height: AppBar().preferredSize.height,
                child: appBar(),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of('Entry'),
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
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 30,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: ConstanceData.entryList.length,
                              shrinkWrap: true,
                              itemBuilder: (cont, index) {
                                return Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: GestureDetector(
                                    onTap: () => {
                                      setState(() {
                                        widget.onTapEntry(index);
                                      })
                                    },
                                    child: txtContainer(
                                      ConstanceData.entryList[index],
                                      ConstanceData.entry,
                                      index,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of('Prize Pool'),
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
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 30,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: ConstanceData.prizeList.length,
                              shrinkWrap: true,
                              itemBuilder: (cont, index) {
                                return Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: GestureDetector(
                                    onTap: ()=>{
                                      setState(() {
                                        widget.onTapPrize(index);
                                      })
                                    },
                                    child: txtContainer(
                                      ConstanceData.prizeList[index],
                                      ConstanceData.prize,
                                      index,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of('Number of Teams'),
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
                          SizedBox(
                            height: 15,
                          ),

                          Container(
                            height: 30,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: ConstanceData.teamsList.length,
                              shrinkWrap: true,
                              itemBuilder: (cont, index) {
                                return Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: GestureDetector(
                                    onTap: () => {
                                      setState(() {
                                        widget.onTapTeams(index);
                                      })
                                    },
                                    child: txtContainer(
                                      ConstanceData.teamsList[index],
                                      ConstanceData.teams,
                                      index,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // txtContainer("1,000 & above"),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of('Contest Type'),
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
                          SizedBox(
                            height: 15,
                          ),

                          Container(
                            height: 30,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: ConstanceData.teamTypes.length,
                              shrinkWrap: true,
                              itemBuilder: (cont, index) {
                                return Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: GestureDetector(
                                    onTap: () => {
                                      setState(() {
                                        widget.onTapType(index);
                                      })
                                    },
                                    child: txtContainer(
                                      ConstanceData.teamTypes[index],
                                      ConstanceData.type,
                                      index,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // txtContainer("1,000 & above"),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of('Apply'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Theme.of(context).appBarTheme.color,
                                letterSpacing: 0.6,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget txtContainer(String txt, int enbl, int index) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: enbl != null && enbl == index
            ? Theme.of(context).primaryColor
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).disabledColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
        child: Text(
          txt,
          style: Theme.of(context).textTheme.caption.copyWith(
                color: enbl != null && enbl == index
                    ? Colors.white
                    : Colors.black54,
                letterSpacing: 0.6,
                fontSize: 12,
              ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Theme.of(context).textTheme.headline6.color,
              size: 24,
            ),
          ),
          Expanded(child: SizedBox()),
          Text(
            AppLocalizations.of('Filter'),
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Theme.of(context).textTheme.headline6.color,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
          ),
          Expanded(child: SizedBox()),
          GestureDetector(
            onTap: () => {
              setState(() {
                ConstanceData.fileteredContests = ConstanceData.contests;
                ConstanceData.entry = null;
                ConstanceData.prize = null;
                ConstanceData.teams = null;
                widget.onTapClear();
              }),
            },
            // onTap: (){
            //   setState(() {
            //     ConstanceData.fileteredContests=ConstanceData.contests;
            //     ConstanceData.entry=null;
            //     ConstanceData.prize=null;
            //     ConstanceData.teams=null;
            //   });
            // },
            child: Text(
              AppLocalizations.of('CLEAR'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Theme.of(context).textTheme.headline6.color,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
