import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class CashFreeWebview extends StatefulWidget {
  final paymentLink;


  CashFreeWebview(this.paymentLink);

  @override
  State<CashFreeWebview> createState() => _CashFreeWebviewState();
}

class _CashFreeWebviewState extends State<CashFreeWebview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  WebView(
        initialUrl: widget.paymentLink,
      )
    );
  }
}
