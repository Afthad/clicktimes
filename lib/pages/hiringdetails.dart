import 'package:clicktimes/models/hiremodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/paymentpage.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/services/firestore_service.dart';
import 'package:clicktimes/services/paymentservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

class HiringDetails extends StatefulWidget {
  final Hire hire;

  final Usermodel customer;
  final Database database;

  const HiringDetails(
      {Key key,
      @required this.database,
      @required this.hire,
      @required this.customer})
      : super(key: key);
  @override
  _HiringDetailsState createState() => _HiringDetailsState();
}

class _HiringDetailsState extends State<HiringDetails> {
  @override
  void initState() {
    super.initState();
  paymentService.initPayment();
}
  PaymentService paymentService=PaymentService();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        title: Text(
          'Hiring Details',
          style: headerappbar,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: kPrimaryColor,
        elevation: 0.5,
      ),
      body: StreamBuilder<Hire>(
          stream: widget.database.hiringstreamselected(widget.hire.orderid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Customer Details',
                            style: hiretitlename,
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Name',
                                style: hiresubtitlename,
                              ),
                              Text(widget.customer.name)
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Location',
                                style: hiresubtitlename,
                              ),
                              Text(widget.customer.location)
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Phone',
                                style: hiresubtitlename,
                              ),
                              SelectableText(
                                widget.customer.phone,
                              )
                            ],
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Description',
                            style: hiretitlename,
                          ),
                          Divider(),
                          Container(
                            // height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Text(widget.hire.description),
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Category',
                            style: hiretitlename,
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Category',
                                style: hiresubtitlename,
                              ),
                              Text(widget.hire.category)
                            ],
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Timeline',
                            style: hiretitlename,
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Created date',
                                style: hiresubtitlename,
                              ),
                              Text(DateFormat.yMMMEd()
                                  .format(widget.hire.created.toDate()))
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Start date',
                                style: hiresubtitlename,
                              ),
                              Text(DateFormat.yMMMEd()
                                  .format(widget.hire.startdate.toDate()))
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'End date',
                                style: hiresubtitlename,
                              ),
                              Text(DateFormat.yMMMEd()
                                  .format(widget.hire.enddate.toDate()))
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(''),
                              Text('Duration: '
                                  ' ${widget.hire.enddate.toDate().difference(widget.hire.startdate.toDate()).inDays} Days'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Budget',
                            style: hiretitlename,
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Budget',
                                style: hiresubtitlename,
                              ),
                              Row(
                                children: [
                                  Text('₹'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(widget.hire.budget),
                                ],
                              ),
                            ],
                          ),
                          if (snapshot.data.paymentrequest == true &&
                              snapshot.data.reject == false &&
                              snapshot.data.complete == false) ...[
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payment Amount',
                                  style: hiresubtitlename,
                                ),
                                Row(
                                  children: [
                                    Text('₹'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(widget.hire.amount),
                                  ],
                                ),
                              ],
                            ),
                          ],
                          Divider(),
                          SizedBox(height: 10),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (snapshot.data.paymentrequest == true &&
                                    snapshot.data.reject == false &&
                                    snapshot.data.complete == false) ...[
                                  MaterialButton(
                                      onPressed: () async {
                                      
                           await Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(
                                      fullscreenDialog: true,
                                      //maintainState: true,
                                      builder: (context)=>Paymentpage (
                     
                                    )
                                    ));
                                    
                                        
                                      },
                                      color: kSuccessColorPayment,
                                      elevation: 0.0,
                                      child: Text(
                                        'Pay',
                                        style: paragraphmedium,
                                      ),
                                      focusElevation: 0,
                                      splashColor: null,
                                      hoverElevation: 0,
                                      highlightElevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      )),
                                ],
                                snapshot.data.complete == true
                                    ? Text('Work has been Completed')
                                    : Container(
                                        height: 0,
                                        width: 0,
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: kPrimaryColor,
              ));
          }),
    );
  }
}
