import 'package:empty_widget/empty_widget.dart';
import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of('Notifications'),
          style: Theme.of(context).textTheme.caption.copyWith(
                color: Colors.white,
                letterSpacing: 0.6,
                fontSize: 22,
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
      backgroundColor: Color(0xffd5d5d5),
      body: ConstanceData.notifications == null ||
              ConstanceData.notifications.length == 0
          ? Center(
              child: EmptyWidget(
                image: null,
                packageImage: PackageImage.Image_1,
                title: 'No Notification',
                subTitle: 'No  notification available yet',
                titleTextStyle: TextStyle(
                  fontSize: 22,
                  color: Color(0xff9da9c7),
                  fontWeight: FontWeight.w500,
                ),
                subtitleTextStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xffabb8d6),
                ),
              ),
            )
          : Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.only(bottom: 3),
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'You have unread notifications.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          // Icon(
                          //   Icons.dehaze_rounded,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        padding: EdgeInsets.all(0.0),
                        itemCount: ConstanceData.notifications.length,
                        itemBuilder: (cont, index) {
                          var data = ConstanceData.notifications[index];
                          return Card(
                            margin: EdgeInsets.all(1.0),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              height: 85,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    size: 30,
                                    color: Colors.grey.shade400,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              70,
                                          child: Text(
                                            '${data.message}',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          )),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '${data.data}',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
