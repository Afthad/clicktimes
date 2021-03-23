import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/postmodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/profilefreelancer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Posttile extends StatefulWidget {
  final Post post;
  final Usermodel usermodel;

  const Posttile({Key key, @required this.post,@required this.usermodel}) : super(key: key);
  @override
  _PosttileState createState() => _PosttileState();
}

class _PosttileState extends State<Posttile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          horizontalTitleGap:10,

          leading: CircleAvatar(
            backgroundColor: kSecondary,

            //foregroundColor: Colors.grey,
            radius: 25,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 23,
              backgroundImage: NetworkImage(widget.post.posturl),
            ),
          ),
          title:GestureDetector(
            onTap: (){
             Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ProfileFreelancer(

      post: widget.post,
      usermodel: widget.usermodel,
     
    )),
  );
            },
                      child: Text(
              widget.post.username,
              style: posttitlename,
            ),
          ),
          subtitle: Text(
          'KOZHIKODE',style: posttitlesub,
          ),
          trailing: IconButton(
              icon: SvgPicture.asset('images/Messageout.svg'),
              onPressed: () {}),
        ),
     SizedBox(height: 5,),
        Center(child: Image.network(widget.post.posturl,
        
        
        frameBuilder: (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: child,
    );
  },
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
        if (loadingProgress == null)
          return Container(
            height: 250,
            child: child);
        
        return Container(
          height: 250,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: .5,
             // backgroundColor: kPrimaryColor,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                  : null,
            ),
          ),
        );
      },
    )),
        SizedBox(height: 5,),
       ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
           leading: IconButton(iconSize: 30,icon: Icon(Icons.star_border_sharp,color: kstartcolour,), onPressed: (){}),
           title: Text('150 Clicks',style: paragraphmedium2,),
           horizontalTitleGap: 1,
           trailing: Padding(
             padding: const EdgeInsets.all(8.0),
             child: MaterialButton(onPressed: (){},
             child: Text('Hire',style: hirebutton,),
             highlightColor: hirebuttoncolour,
             color: hirebuttoncolour,
             elevation: 0.0,
             highlightElevation: 0.0,
             focusElevation: 0.0,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          
             ),
           ),
         ),
       Padding(
         padding: const EdgeInsets.only(left:15.0,right: 8),
         child: Text(widget.post.caption,style: paragraphmedium4,),
       ),
       SizedBox(height: 20,)
      ],
    );
  }
}
