import 'package:fantacySports/Model/Commentaries/commentary.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:flutter/material.dart';

class Commentary extends StatefulWidget {
  const Commentary({Key key}) : super(key: key);

  @override
  _CommentaryState createState() => _CommentaryState();
}

class _CommentaryState extends State<Commentary> {
  var i = 0;

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          padding: EdgeInsets.all(0.0),
          itemCount: ConstanceData.CommentariesCombo.length,
          itemBuilder: (cont, index) {
            commentaries data = ConstanceData.CommentariesCombo.reversed.toList(growable: false)[index];
            return index > ConstanceData.CommentariesA.length - 1 && i == 0
                ? getWidget(index, data)
                : getActual(index, data);
          },
        ),
      ),
    );
  }

  isBoundary(String string) {
    if (string == '4' || string == '6') {
      return true;
    } else {
      return false;
    }
  }

  getWidget(int index, commentaries data) {
    i++;
    return data.ball.toString() == 'null' || data.ball.toString() == null
        ? Column(
            children: [
              Container(
                color: Colors.white24,
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                child: Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        'End of Innings',
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              ),
              Container(
                color: Colors.white24,
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                child: Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        data.commentary.toString().trim(),
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              ),
            ],
          )
        : Column(
            children: [
              Container(
                color: Colors.white24,
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                child: Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        'End of Innings',
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    color: !isBoundary(data.run.toString())
                                        ? Colors.grey
                                        : Colors.black,
                                    border: Border.all(
                                      color: !isBoundary(data.run.toString())
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Text(
                                  data.run.toString(),
                                  style: TextStyle(
                                    color: !isBoundary(data.run.toString())
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${data.over.toString()}.${data.ball.toString()}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                            child: Text(
                          data.commentary.toString().trim(),
                          softWrap: true,
                          textAlign: TextAlign.start,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }

  getActual(int index, commentaries data) {

    return data.ball.toString() == 'null' || data.ball.toString() == null
        ? Container(
            color: Colors.white24,
            padding: EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width,
            child: Container(
                height: 40,
                child: Center(
                  child: Text(
                    data.commentary.toString().trim(),
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          )
        : Card(
            child: Container(
              padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            // padding: EdgeInsets.all(5.0),
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: !isBoundary(data.run.toString())
                                    ? Colors.grey
                                    : Colors.black,
                                border: Border.all(
                                  color: !isBoundary(data.run.toString())
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Center(
                              child: Text(
                                data.run.toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: !isBoundary(data.run.toString())
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${data.over.toString()}.${data.ball.toString()}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        data.commentary.toString().trim(),
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
