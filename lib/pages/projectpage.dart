import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/hiremodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/projectdetails.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/widgets/bookinglist.dart';
import 'package:clicktimes/widgets/shimmerchatroom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Projects extends StatefulWidget {
  final Database database;

  const Projects({Key key, @required this.database}) : super(key: key);
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Projects',style: chatroomtitle,),
              Expanded(
                child: LayoutBuilder(
      builder: (context,BoxConstraints constraints){ 
        return 
                                   StreamBuilder<List<Hire>>(
                      stream:widget.database.hiringstreamFreelance(),
                      builder: (context, snapshot) {
                        
                        return BookingListItemsBuilder<Hire>(
                            snapshot: snapshot,
                               hireobook: 'No Projects',
                            itemBuilder: (context, hiringmodel,) {
                              return StreamBuilder<Usermodel>(
                                stream:widget. database.userStream(uid: hiringmodel.customeruid),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData){
                                  return ListTile(
                                    onTap: ()async {
                                    await Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(
                                      fullscreenDialog: true,
                                      //maintainState: true,
                                      builder: (context)=>ProjectsDetails(
                            hire: hiringmodel,

                            customer: snapshot.data,
                            database:widget.database,
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
}