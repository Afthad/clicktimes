
import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class BookingDetails extends StatefulWidget {
 final Bookingmodel bookingmodel;

  const BookingDetails({Key key, @required this.bookingmodel}) : super(key: key);
  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
      
        children: [
          Text('Booking Details',style: hiretitlename,),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child:  Container(
                width: 7*MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text('Booked : ',style: hiresubtitlename,),
                             SizedBox(width:10),
                            Text(widget.bookingmodel.category,style: hiresubtitlename,),
                          ],
                        ),
                      ),
                      Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(widget.bookingmodel.category),
                          Text(widget.bookingmodel.description),
                        ],
                      ),
                      Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(widget.bookingmodel.category),
                          Text(DateFormat.yMEd().format(widget.bookingmodel.startdate.toDate())),
                        ],
                      )
                      ,
                      Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(widget.bookingmodel.category),
                          Text(DateFormat.yMEd().format(widget.bookingmodel.enddate.toDate())),
                        ],
                      )

                    ],
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}