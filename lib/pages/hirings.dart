import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/booking.dart';
import 'package:clicktimes/models/hiremodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/widgets/bookinglist.dart';
import 'package:clicktimes/widgets/shimmerchatroom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:clicktimes/pages/searchpage.dart';
import 'hiringdetails.dart';

class Hirings extends StatefulWidget {
  @override
  _HiringsState createState() => _HiringsState();
}

class _HiringsState extends State<Hirings> {

  @override
  Widget build(BuildContext context) {
  final database =Provider.of<Database>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hirings',style: chatroomtitle,),
              IconButton(
                iconSize: 24,
                onPressed: ()async{
                  await Navigator.of(context).push(MaterialPageRoute(
                                      fullscreenDialog: true,
                                      //maintainState: true,
                                      builder: (context)=>Searchpage (
                            
                                    )
                                    ));
                },
                icon: Icon(Icons.search,color: Colors.black,),
               color:Colors.black,),
               
            
            ],
          ),

            Expanded(
                child: LayoutBuilder(
      builder: (context,BoxConstraints constraints){ 
        return 
                                   StreamBuilder<List<Hire>>(
                      stream: database.hiringstream(),
                      builder: (context, snapshot) {
                        
                        return BookingListItemsBuilder<Hire>(
                            snapshot: snapshot,
                               hireobook: 'No Hirings',
                            itemBuilder: (context, hiringmodel,) {
                              return StreamBuilder<Usermodel>(
                                stream: database.userStream(uid: hiringmodel.freelanceruid),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData){
                                  return Dismissible(
                                    key: Key('hiring-${hiringmodel.created}'),
                                    confirmDismiss:
                                        (DismissDirection dismissDirection) async {
                                      switch (dismissDirection) {
                                      
                                        case DismissDirection.endToStart:

                                        case DismissDirection.startToEnd:
                                          return await _showConfirmationDialog(
                                                  context, 'delete', hiringmodel.start,database,hiringmodel) ==
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
                                      onTap: ()async{
                           await Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(
                                      fullscreenDialog: true,
                                      //maintainState: true,
                                      builder: (context)=>HiringDetails (
                            hire: hiringmodel,

                            customer: snapshot.data,
                            database:database,
                                    )
                                    ));
                                    },
                                      
                                      leading: CircleAvatar(
                                        backgroundColor: kPrimaryColor,
                                        child: SvgPicture.asset('images/Mall.svg',color: Colors.white,),
                                      ),
                                      title:Text(snapshot.data.name),

                                      subtitle: Text('Starting Date  ' +
                                    
                                    
                                          '${DateFormat.yMEd().format(hiringmodel.startdate.toDate())} '),
                                              trailing: hiringmodel.start==false?Text('Booked'):Text('Processing'),
                                    ),


                                  );
                                }
                                else return Container(
                                    height: constraints.maxHeight,
                                    child: ShimmerChatroom(itemcount: 1,),
                                );
                                }
                              );
                            });
                      });}
                )
              )
        ],
      ),
    );
  }
   Future<bool> _showConfirmationDialog(
      BuildContext context, String action, bool start,Database database,Hire hire) {
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
                  await database.deleteHiring(hire.orderid);
                   
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