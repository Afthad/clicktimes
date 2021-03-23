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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: kSecondary,

              //foregroundColor: Colors.grey,
              radius: 27,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 25,
                backgroundImage: NetworkImage(widget.post.posturl),
              ),
            ),
            title: Column(
              children: [Text(widget.post.username),
              Text('location')
              ],
            ),
            trailing: IconButton(icon: SvgPicture.asset('images/Messageout.svg'), onPressed: (){}),
          )
        ],
      ),
    );
  }
}
