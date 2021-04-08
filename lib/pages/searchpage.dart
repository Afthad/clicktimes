import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class Searchpage extends StatefulWidget {
  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                         controller: controller,
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

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Users').where('searchindex',arrayContains: controller.text).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                return Container(
                  child: Text('mm'),
                );
               
                }
                else return Container();
              }
            )
          ],
        ),
      ),
    );
  }
}