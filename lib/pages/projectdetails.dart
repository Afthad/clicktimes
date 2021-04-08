import 'package:clicktimes/models/hiremodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

class ProjectsDetails extends StatefulWidget {
  final Hire hire;

  final Usermodel customer;
  final Database database;

  const ProjectsDetails({Key key, @required this.database, @required this.hire, @required this.customer}) : super(key: key);
  @override
  _ProjectsDetailsState createState() => _ProjectsDetailsState();
}

class _ProjectsDetailsState extends State<ProjectsDetails> {

     TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kPrimaryColor
        ),

        title: Text('Project Details',style: headerappbar,),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: kPrimaryColor,
        elevation: 0.5,
      ),
          body: StreamBuilder<Hire>(
            stream: widget.database.hiringstreamselected(widget.hire.orderid),
            builder: (context, snapshot) {
              
            if(snapshot.hasData){
              return SingleChildScrollView(
                          child: Column(
                  
        children: [
                Container(
                  
                ),
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
                        SelectableText(widget.customer.phone,)
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
                 child:Text(widget.hire.description) ,
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
                        Text(DateFormat.yMMMEd().format(widget.hire.created.toDate()))
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
                        Text(DateFormat.yMMMEd().format(widget.hire.startdate.toDate()))
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
                        Text(DateFormat.yMMMEd().format(widget.hire.enddate.toDate()))
                        ],
                      ),
                      
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(''),
                         Text('Duration: '' ${ widget.hire.enddate.toDate().difference(widget.hire.startdate.toDate()).inDays } Days'),
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
                      Divider(),
                      SizedBox(height:10),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if((snapshot.data.start==false && snapshot.data.reject
                            ==false))...[
                            MaterialButton(
                                onPressed: () async{
                                          
                                      
                                    await FirebaseFirestore.instance.collection('Hiring').doc(widget.hire.orderid).update({'start':true});

                                },
                                color: kPrimaryColor,
                                elevation: 0.0,
                                child: Text(
                                  'Accept',
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
                            if(snapshot.data.start==false && snapshot.data.reject
                            ==false)...[
                                 MaterialButton(
                                onPressed: ()async {
                                
                                   await FirebaseFirestore.instance.collection('Hiring').doc(widget.hire.orderid).update({'reject':true});

                                },
                                color: danger,
                                elevation: 0.0,
                                child: Text(
                                  'Reject',
                                  style: paragraphmedium,
                                ),
                                focusElevation: 0,
                                splashColor: null,
                                hoverElevation: 0,
                                highlightElevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                )),],


                                if((snapshot.data.start==true && snapshot.data.paymentrequest==false))...[
                                     MaterialButton(
                                onPressed: () {
                               showDialog(context: context,builder: (context){
                               
                                   return Dialog(
                                       child: Container(
                                         height: 185,
                                         width: .7*MediaQuery.of(context).size.width,
                                         child: Padding(
                                           padding: const EdgeInsets.all(16.0),
                                           child: Column(
                                             children: [
                                               SizedBox(height: 10,),
                                               Text('Create Payment Request',style: dialoghead,),
                                               SizedBox(height: 20,),
                                               Container(
                                                 height: 40,
                                                 width: .5*MediaQuery.of(context).size.width,
                                                 child: TextField(
                                                   controller: controller,
                                                keyboardType: TextInputType.multiline,
                          
                          maxLength:6,
                          maxLines: 1,
                          autocorrect:true,
                          autofocus: false,
                          decoration: InputDecoration(
                           fillColor: Colors.white,
                           hintText: 'Enter the Amount in Rupees',
                           hintStyle: paragraphmedium5,
                           filled: true,
                           isDense: true,
                           
                           contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                             focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color:kPrimaryLight,
                              width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                        color:kPrimaryLight,
                          width: 2,
                          ),),
                            counterText: ''
                          ),
                                                 )),

                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                 children: [
                                                   Padding(
                                                     padding: const EdgeInsets.only(top:8.0),
                                                     child: MaterialButton(onPressed: (){
                                                       Navigator.of(context).pop();
                                                     },
                                                     
                                                     child: Text('Cancel',style: TextStyle(color: kPrimaryColor),),
                                                     ),
                                                   ),
                                                     Padding(
                                                     padding: const EdgeInsets.only(top:8.0),
                                                     child: MaterialButton(onPressed: ()async{
                                                       Navigator.of(context).pop();
                                                      

                                            
                                                       try {
                                                         await FirebaseFirestore.instance.collection('Hiring').doc(widget.hire.orderid).update({'paymentrequest':true,'amount':controller.text});
                                                              controller.text='';
                                                       } catch (e) {
                                                       }
                                                     },
                                                     
                                                     child: Text('Ok',style: TextStyle(color: kPrimaryColor),)
                                                     ),
                                                   ),
                                                 ],
                                               )
                                             ],
                                             
                                           ),
                                         ),
                                       ),


                                     );
                                 });

                                },
                                color: kSuccessColorPayment,
                                elevation: 0.0,
                                child: Text(
                                  'Create Payment Request',
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
                                  
                                if(snapshot.data.paymentrequest==true && snapshot.data.reject
                            ==false && snapshot.data.complete==false )...[
                                     MaterialButton(
                                onPressed: () async{
                                 
                                   try {
                                                         await FirebaseFirestore.instance.collection('Hiring').doc(widget.hire.orderid).update({'complete':true});
                                                            
                                                       } catch (e) {
                                                       }

                                },
                                color: kPrimaryColor,
                                elevation: 0.0,
                                child: Text(
                                  'Complete',
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
                                 snapshot.data.complete==true?Text(
                                   'Work has been Completed'
                                 ):Container(height: 0,width: 0,)

                                 
                                
                          ],
                        ),
                      )
                    ],
                  ),
                )
        ],
      ),
              );
            }
           else return Center(child: CircularProgressIndicator(backgroundColor: kPrimaryColor,));}),
    );
  }
}