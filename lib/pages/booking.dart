import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/booking.dart';

import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/addbooking.dart';
import 'package:clicktimes/pages/bookingdetails.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/widgets/bookinglist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Booking extends StatefulWidget {
  final Usermodel usermodel;

  const Booking({Key key, this.usermodel}) : super(key: key);
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: Text(
                'Bookings',
                style: chatroomtitle,
              )),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: StreamBuilder<List<Bookingmodel>>(
                    stream: database.bookingstream(),
                    builder: (context, snapshot) {
                      
                      return BookingListItemsBuilder<Bookingmodel>(
                          snapshot: snapshot,
                          hireobook: 'No Bookings',

                          itemBuilder: (context, bookingmodel,) {
                            return Dismissible(
                              key: Key('booking-${bookingmodel.created}'),
                              confirmDismiss:
                                  (DismissDirection dismissDirection) async {
                                switch (dismissDirection) {
                                
                                  case DismissDirection.endToStart:

                                  case DismissDirection.startToEnd:
                                    return await _showConfirmationDialog(
                                            context, 'delete', bookingmodel.start,database,bookingmodel) ==
                                        true;
                                  case DismissDirection.horizontal:
                                  case DismissDirection.vertical:
                                  case DismissDirection.up:
                                  case DismissDirection.down:
                                    assert(false);
                                }
                                return false;
                              },
                              background: Container(
                                  color: Colors.red,
                                  child: Center(
                                      child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ))),
                              direction: DismissDirection.endToStart,
                              child: ListTile(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookingDetails(
                          bookingmodel: bookingmodel,
                                  )
                                  ));
                                },
                                leading: CircleAvatar(
                                  backgroundColor: kPrimaryColor,
                                  child: SvgPicture.asset('images/Mall.svg',color: Colors.white,),
                                ),
                                title: bookingmodel.category != 'Camera Renting'
                                    ? Text('Booked a ${bookingmodel.category}')
                                    : Text('Booked a Camera for Rent'),
                                subtitle: Text('Starting Date  ' +
                              
                              
                                    '${DateFormat.yMEd().format(bookingmodel.startdate.toDate())} '),
                                        trailing: bookingmodel.start==false?Text('Booked'):Text('Processing'),
                              ),


                            );
                          });
                    }),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 1,
          child: Icon(
            Icons.add,
            color: kPrimaryColor,
          ),
          onPressed: () async {
            await AddBooking.show(
              context,
              database,
              widget.usermodel,
            );
          },
        ));
  }

  Future<bool> _showConfirmationDialog(
      BuildContext context, String action, bool start,Database database,Bookingmodel model) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          titleTextStyle: dialogbookandhire,
          title: start == false
              ? Text('Do you want to $action this item?')
              : Text('Sorry You can\'t Delete this Booking'),
          actions: <Widget>[
            if (start == false) ...[
              MaterialButton(
            color: Colors.white,
                elevation: 0.0,
                highlightElevation: 0.1,
                hoverElevation: 0.1,
                child: const Text('Yes',style: TextStyle(color: kPrimaryColor),),
                onPressed: () async{
                    Navigator.pop(context, true);
                  try {
                    await database.deleteBooking(model.orderid);
                   
                  } catch (e) {
                  }
                  // showDialog() returns true
                },
              ),
              MaterialButton(
            color: Colors.white,
                elevation: 0.0,
                highlightElevation: 0.1,
                hoverElevation: 0.1,
                child: const Text('No',style: TextStyle(color: kPrimaryColor),),
                onPressed: () {
                  Navigator.pop(context, false); // showDialog() returns false
                },
              ),
            ],
            if (start == true) ...[
              MaterialButton(
                color: Colors.white,
                elevation: 0.0,
                highlightElevation: 0.1,
                hoverElevation: 0.1,
                child: const Text('Ok',style: TextStyle(color: kPrimaryColor),),
                onPressed: () {
                  Navigator.pop(context, false); // showDialog() returns false
                },
              ),
            ]
          ],
        );
      },
    );
  }
}
