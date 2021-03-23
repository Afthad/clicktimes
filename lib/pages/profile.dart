import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final Usermodel usermodel;

  const Profile({Key key,@required  this.usermodel}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final database =Provider.of<Database>(context);
    return StreamBuilder<Usermodel>(
      stream: database.userStream(uid:widget.usermodel.uid),
      builder: (context, snapshot) {
        return SingleChildScrollView(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(widget.usermodel.profile),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(98, 98, 0, 0),
                  child: Icon(Icons.circle,size: 17,color: kSuccessColorPayment,),
                ),
              ),
              SizedBox(height: 10,),
              Text(widget.usermodel.name,style: porofiletitlename,),
              SizedBox(height: 12,),
              Divider(color: dividerprofile,indent: 10,endIndent:10 ,thickness: 1,),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Email',style: prodilecontent1,),
                    Text(widget.usermodel.name,style:paragraphmedium2 ),
                  ],

                ),
              ),
                 SizedBox(height: 12,),
              Divider(color: dividerprofile,indent: 10,endIndent:10 ,thickness: 1,),
              SizedBox(height: 12,),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal:13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Email',style: prodilecontent1,),
                    Text(widget.usermodel.name,style:paragraphmedium2 ),
                  ],

                ),),  SizedBox(height: 12,),
              Divider(color: dividerprofile,indent: 10,endIndent:10 ,thickness: 1,),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Email',style: prodilecontent1,),
                    Text(widget.usermodel.name,style:paragraphmedium2 ),
                  ],

                ),),  SizedBox(height: 12,),
              Divider(color: dividerprofile,indent: 10,endIndent:10 ,thickness: 1,),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Email',style: prodilecontent1,),
                    Text(widget.usermodel.name,style:paragraphmedium2 ),
                  ],

                ),),  SizedBox(height: 12,),
              Divider(color: dividerprofile,indent: 10,endIndent:10 ,thickness: 1,),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Email',style: prodilecontent1,),
                    Text(widget.usermodel.name,style:paragraphmedium2 ),
                  ],

                ),),  SizedBox(height: 12,),
              Divider(color: dividerprofile,indent: 10,endIndent:10 ,thickness: 1,),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Email',style: prodilecontent1,),
                    Text(widget.usermodel.name,style:paragraphmedium2 ),
                  ],

                ),),  SizedBox(height: 12,),
              Divider(color: dividerprofile,indent: 10,endIndent:10 ,thickness: 1,),
              SizedBox(height: 12,),
              ]
          ),
        );
      }
    );
  }
}