import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/profilefreelancer.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/widgets/searchlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class Searchpage extends StatefulWidget {
  final Database database;
  final Usermodel usermodel;

  const Searchpage({Key key, this.database, this.usermodel}) : super(key: key);

  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
        
          children: [
            Row(
                children: [
                  Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
             onChanged: (value) => initiateSearch(value),
              maxLength: 600,
              maxLines: null,
              autocorrect:true,
              autofocus: false,
              decoration: InputDecoration(
               fillColor: Colors.white,
               hintText: 'Search Vediographers,Designers',
               filled: true,
               isDense: true,
               contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                 focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color:kPrimaryColor,
                  width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: kPrimaryColor,
              
              ),),
                counterText: ''
              ),
              
                      
                    ),
                  ),
                  IconButton(
                      iconSize: 24,
                      onPressed: ()async{
                     Navigator.pop(context);
                      },
                      icon: Icon(Icons.search,color: Colors.black,),
                     color:Colors.black,),
                     
                ],
              ),
              SizedBox(height: 20,),
           if(name!=null && name!=' ')...[
          Container(
            alignment: Alignment.topLeft,
            child: StreamBuilder<List<Usermodel>>(
                  stream: widget.database.getusersearch(name),
                  builder: (context, snapshot) {
                    return SearchItemsBuilder<Usermodel>(snapshot: snapshot, itemBuilder:(context,usermodel)=>ListTile(
                      onTap: (){
                        if(widget.usermodel.uid!=usermodel.uid){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileFreelancer(
                          database: widget.database,
                          postuser: usermodel,
                          usermodel: widget.usermodel,
                        )));}
                      },
                      title: Text(usermodel.name,style: chatroomtitle,),
                      subtitle: Text(usermodel.about,style: paragraphmediumsearch,),
                    trailing: Text(usermodel.role,style: paragraphmedium2,),
                    )
                    );
                  }
                ),
          )]
            
          ],
        ),
      ),
    );
  }
    void initiateSearch(String val) {
    setState(() {
      name = val.toLowerCase().trim();
    });
  }
}