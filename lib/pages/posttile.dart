import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/postmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Posttile extends StatefulWidget {
  final Post post;

  const Posttile({Key key, @required this.post}) : super(key: key);
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
          title: Text(
            widget.post.username,
            style: posttitlename,
          ),
          subtitle: Text(
          'KOZHIKODE',style: posttitlesub,
          ),
          trailing: IconButton(
              icon: SvgPicture.asset('images/Messageout.svg'),
              onPressed: () {}),
        ),
     SizedBox(height: 5,),
        Center(child: Image.network(widget.post.posturl,loadingBuilder: null)),
        SizedBox(height: 5,),
       Row(
         
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           Expanded(
                        child: ListTile(
     
               leading: IconButton(iconSize: 26,icon: Icon(Icons.star_border_sharp,color: kstartcolour,), onPressed: (){}),
               title: Text('150 Clicks',style: paragraphmedium2,),
               horizontalTitleGap: 5,
               trailing: MaterialButton(onPressed: (){},
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
         ],
       ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text(widget.post.caption),
       ),
       SizedBox(height: 10,)
      ],
    );
  }
}
