
import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RedirectPage extends StatefulWidget {
  final txt,url;

  RedirectPage(this.txt, this.url);


  @override
  _RedirectPageState createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.color,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of('${widget.txt}'),
          style: Theme.of(context).textTheme.caption.copyWith(
            color: Colors.white,
            letterSpacing: 0.6,
            fontSize: 16,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffe3e3e3),
        child: Center(
          child: WebView(
            initialUrl: widget.url,
          )
        ),
      ),
    );
  }

  Widget container(String txt1, IconData icon, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: InkWell(
            onTap: () {
              onTap();
            },
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).textTheme.headline6.color,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  txt1,
                  style: Theme.of(context).textTheme.caption.copyWith(
                    color: Theme.of(context).textTheme.headline6.color,
                    letterSpacing: 0.6,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print(widget.url);
  }
}
