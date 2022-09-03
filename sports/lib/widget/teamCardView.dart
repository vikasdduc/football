import 'package:fantacySports/constance/DataStorage.dart';
import 'package:flutter/material.dart';

class TeamCardView extends StatelessWidget {
  final String txt1;
  final String txt2;
  final String txt3;
  final String txt4;
  final String txt5;
  final String txt6;
  final String txt7;
  final Widget image1;
  final bool selected;
  const TeamCardView({
    Key key,
    this.txt1,
    this.txt2,
    this.txt3,
    this.txt4,
    this.txt5,
    this.txt6,
    this.txt7,
    this.image1,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0.25),
      elevation:1,
      child: Container(
        color: selected?Color(0xffFFF4DE):Colors.white,
        height: 85,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          // color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                          // image: DecorationImage(
                          //   image: image1,
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                        child: image1,
                      ),
                      Card(
                        child: Container(
                          color: txt7=='a'?Colors.white:Colors.black,

                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              txt1,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style:
                             Theme.of(context).textTheme.bodyText2.copyWith(
                                        color:  txt7=='a'?Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color:Colors.white,
                                        letterSpacing: 0.6,
                                        fontSize: 10,
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          txt2==null||txt2==''?'${txt2}':short_the_name(txt2),
                          overflow: TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.6,
                                fontSize: 12,
                              ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          txt3, overflow: TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.6,
                                fontSize: 12,
                                color: Colors.black45,
                              ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SizedBox(

                          child: Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color:
                                  txt4=='Announced'?Colors.green:Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                txt4, overflow: TextOverflow.clip,
                                style:
                                    Theme.of(context).textTheme.bodyText2.copyWith(
                                      color:
                                      txt4=='Announced'?Colors.green:Theme.of(context).textTheme.caption.color,
                                          letterSpacing: 0.6,
                                          fontSize: 12,
                                        ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(
                        txt5, overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              letterSpacing: 0.6,
                              fontSize: 12,
                              color: Colors.black45,
                            ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  SizedBox(
                    width: 40,
                    child: Center(
                      child: Text(
                        txt6, overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              letterSpacing: 0.6,
                              fontSize: 12,
                              color: Theme.of(context).textTheme.headline6.color,
                            ),
                      ),
                    ),
                  ),
                  // Expanded(child: SizedBox()),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:Color(0xff0ebd01),
                      ),
                    ),
                    child: Icon(
                      selected ? Icons.remove : Icons.add,
                      color: Color(0xff0ebd01),
                      size: 22,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  short_the_name(title) {
    try {
      var txt = title.toString().split(' ');
      return '${txt[0].substring(0,1)}. ${txt[1]}';
    } catch (e) {
      print(e);
      return title;
    }
  }
}
