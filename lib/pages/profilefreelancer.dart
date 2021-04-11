import 'dart:ui';

import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/postmodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/Hirepag.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/services/messageservice.dart';
import 'package:clicktimes/widgets/postgridlist.dart';
import 'package:clicktimes/widgets/profilecontents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProfileFreelancer extends StatefulWidget {
  final Usermodel usermodel;
 // final Post post;
  final Usermodel postuser;
  final Database database;

  const ProfileFreelancer(
      {Key key,
      @required this.database,
      @required this.usermodel,
     // @required this.post,
      @required this.postuser})
      : super(key: key);
  @override
  _ProfileFreelancerState createState() => _ProfileFreelancerState();
}

class _ProfileFreelancerState extends State<ProfileFreelancer> {
  MessageService _service =MessageService();
  List list = ['Posts', 'About'];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 10, right: 10),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(widget.postuser.profile),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(69, 69, 0, 0),
                  child: Icon(
                    Icons.circle,
                    size: 17,
                    color: widget.postuser.available==true? kSuccessColorPayment:danger,
                  ),
                ),
              ),
            ),
            Expanded(
                          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.postuser.name,
                    style: porofiletitlename,
                  ),
                  Text(
                    'FREELANCER',
                    style: paragraphmedium1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
               Text(
                            widget.postuser.about,
                          overflow: TextOverflow.fade,
                          softWrap: true,
                            style: TextStyle(fontSize: .03*MediaQuery.of(context).size.width,color: Colors.grey,fontWeight: FontWeight.w400),
                          )
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
              SizedBox(
                width: 10,
              ),
              MaterialButton(
                  onPressed: () {
               _service.createRoomMessage(context, widget.database, widget.usermodel, widget.postuser);
                  },
                  child: Text(
                    'Message',
                    style: paragraphmedium,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  color: kSecondary,
                  elevation: 1,
                  focusElevation: 1,
                  highlightElevation: 1,
                  focusColor: kSecondary,
                  highlightColor: kSecondary),
            
              MaterialButton(
                  onPressed: () {
                    Hirepage.show(context, widget.database, widget.usermodel, widget.postuser);
                  },
                  child: Text(
                    'Hire',
                    style: paragraphmedium,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  color: kSuccessColorPayment,
                  elevation: 1,
                  focusElevation: 1,
                  highlightElevation: 1,
                  focusColor: kPrimaryColor,
                  highlightColor: kPrimaryColor),
            ],
          ),
        ),
        Expanded(
          child: DefaultTabController(
            initialIndex: 1,
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  toolbarHeight: 50,
                  bottom: TabBar(
                    unselectedLabelColor: kPrimaryColor,
                    indicatorWeight: 2,
                    labelColor: kPrimaryColor,
                    tabs: [
                      Tab(
                        text: 'Post',
                      ),
                      Tab(
                        text: 'About',
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:3.0),
                      child: _buildList(
                          key: 'Page1',
                          database: widget.database,
                          uid: widget.postuser.uid),
                    ),
                    _buildList2(
                        key: 'Page2',
                        database: widget.database,
                        postuser: widget.postuser),
                  ],
                )),
          ),
        )
      ],
    );
  }

  Widget _buildList({String key, @required Database database, @required String uid}) {
    return StreamBuilder<List<Post>>(
        stream: database.selectedpostStream(userid: uid),
        builder: (context, snapshot) {
          return GridListItemsBuilder<Post>(
              snapshot: snapshot,
              itemBuilder: (context, post) => Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 70,
                  width: .3* MediaQuery.of(context).size.width,
                      child: Image.network(post.posturl,fit: BoxFit.cover,),
                    ),
              ));
        });
  }

Widget _buildList2({String key, @required Database database, @required Usermodel postuser}){
  return SingleChildScrollView(
      child: Column(
        children: [
            SizedBox(
                      height: 12,
                    ),
                    
                    Profilecontents(
                        contentname: 'Email', content: widget.usermodel.name),
                    Divider(
                      color: dividerprofile,
                      indent: 10,
                      endIndent: 10,
                      thickness: 1,
                    ),
                    Profilecontents(
                        contentname: 'Phone Number',
                        content: widget.usermodel.phone),
                    Divider(
                      color: dividerprofile,
                      indent: 10,
                      endIndent: 10,
                      thickness: 1,
                    ),
                    Profilecontents(
                        contentname: 'Location',
                        content: widget.usermodel.location),
                    Divider(
                      color: dividerprofile,
                      indent: 10,
                      endIndent: 10,
                      thickness: 1,
                    ),
                    Profilecontents(
                        contentname: 'Role', content: widget.usermodel.role),
                    Divider(
                      color: dividerprofile,
                      indent: 10,
                      endIndent: 10,
                      thickness: 1,
                    ),
                  
                    Profilecontents(
                        contentname: 'Website',
                        content: widget.usermodel.website),
        ]
    ),
  );
     
}

}
