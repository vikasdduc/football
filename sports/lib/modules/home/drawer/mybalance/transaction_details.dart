import 'package:flutter/material.dart';

import '../../../../Language/appLocalizations.dart';
import '../../../../Model/updated_transaction.dart';

class TransactionDetails extends StatefulWidget {
  final UpdatedTransaction present;

  TransactionDetails(this.present);

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of('Transactions Details'),
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
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 90,
              width: double.infinity,
              color: Colors.green.shade100.withOpacity(0.5),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '₹${widget.present.amount}',
                        style: TextStyle(fontSize: 22, color: Colors.green),
                      ),
                      Text(
                          '${getStatus(widget.present.status)} . ${widget.present.date.split('T')[0]}, ${widget.present.date.split('T')[1].split('.')[0]}'),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(65),
                      ),
                      color: Colors.grey.shade100,
                    ),
                    child: Icon(
                      Icons.list_alt_sharp,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'From',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.present.payment_method,
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Transaction Id',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.present.transaction_id??"NA",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  getStatus(int status) {
    switch (status) {
      case 0:
        return 'Successful';
      case 1:
        return 'Processing';
      default:
        return 'Failed';
    }
  }
}
