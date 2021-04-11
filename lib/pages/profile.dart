

import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/editpage.dart';
import 'package:clicktimes/pages/projectpage.dart';
import 'package:clicktimes/services/auth.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/widgets/profilecontents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final Usermodel usermodel;
  final String url;

  const Profile({Key key, @required this.usermodel,this.url}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final database=Provider.of<Database>(context);
   final auth =Provider.of<AuthBase>(context);
          return StreamBuilder<Usermodel>(
            stream: database.userStream(uid: widget.usermodel.uid)              ,

            builder: (context, snapshot) {
              if(snapshot.hasData){
              return SingleChildScrollView(
                              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(icon: Icon(Icons.edit), onPressed: (){
                            Navigator.of(context).push(
                              
                            MaterialPageRoute(builder:(context)=>Editpage(usermodel:widget.usermodel,url:widget.url)));
                          })

                      ],),
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(widget.usermodel.profile),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(98, 98, 0, 0),
                          child: Icon(
                            Icons.circle,
                            size: 17,
                            color: widget.usermodel.available==true? kSuccessColorPayment:danger,
                          ),
                        ),
                      ),
                      if (widget.usermodel.role == 'Freelancer' && widget.usermodel.available==true) ...[
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Available',
                          style: paragraphmedium4,
                        )
                      ],
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data.name,
                        style: porofiletitlename,
                      ),
                      if (widget.usermodel.role == 'Freelancer') ...[
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.usermodel.about,
                          style: paragraphmedium5,
                        )
                      ],
                      SizedBox(
                        height: 12,
                      ),
                      Divider(
                        color: dividerprofile,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1,
                      ),
                      Profilecontents(
                          contentname: 'Email', content:    snapshot.data.email,),
                      Divider(
                        color: dividerprofile,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1,
                      ),
                      Profilecontents(
                          contentname: 'Phone Number',
                          content: snapshot.data.phone),
                      Divider(
                        color: dividerprofile,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1,
                      ),
                      Profilecontents(
                          contentname: 'Location',
                          content: snapshot.data.location),
                      Divider(
                        color: dividerprofile,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1,
                      ),
                      Profilecontents(
                          contentname: 'Role', content: snapshot.data.role),
                      Divider(
                        color: dividerprofile,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1,
                      ),
                      Profilecontents(
                          contentname: 'Payments', content: ''),
                      Divider(
                        color: dividerprofile,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1,
                      ),
                      GestureDetector(
                        onTap: (){

                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Projects(database: database,)));
                        },
                                          child: Profilecontents(
                            contentname: 'Projects', content: ''),
                      ),

                      if (widget.usermodel.role == 'Freelancer') ...[      
                      Divider(
                        color: dividerprofile,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1,
                      ),
                      // Profilecontents(
                      //     contentname: 'Posts', content: ''),
                      // Divider(
                      //   color: dividerprofile,
                      //   indent: 10,
                      //   endIndent: 10,
                      //   thickness: 1,
                      // ),
                      Profilecontents(
                          contentname: 'Website',
                          content: snapshot.data.website),
                    ],
                    IconButton(icon: Icon(Icons.logout), onPressed: (){
                                  auth.signOut();
                    })



                    ],

                  
                    ),
              );
            }
            else return Center(child: Text('No Data',style: nochats,));
            
            }
          );
  
  }
}
