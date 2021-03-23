import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/postmodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:flutter/material.dart';

class ProfileFreelancer extends StatefulWidget {
 final Usermodel usermodel;
 final Post post;

  const ProfileFreelancer({Key key, @required this.usermodel, @required this.post}) : super(key: key);
  @override
  _ProfileFreelancerState createState() => _ProfileFreelancerState();
}

class _ProfileFreelancerState extends State<ProfileFreelancer> {
  List list = ['Posts', 'About'];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return 
     Column(
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
                  // backgroundImage: NetworkImage(widget.usermodel.profile),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(68, 68, 0, 0),
                    child: Icon(
                      Icons.circle,
                      size: 17,
                      color: kSuccessColorPayment,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Muhammed Afthad',
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
                    'Vedio Editor, Photographer',
                    style: paragraphmedium2,
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: Text(
                    'Pay',
                    style: paragraphmedium,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  color: kSuccessColorPayment,
                  elevation: 1,
                  focusElevation: 1,
                  highlightElevation: 1,
                  focusColor: kSuccessColorPayment,
                  highlightColor: kSuccessColorPayment,
                ),
                SizedBox(
                  width: 8,
                ),
                MaterialButton(
                    onPressed: () {},
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
                SizedBox(
                  width: 8,
                ),
                MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'Hire',
                      style: paragraphmedium,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    color: kPrimaryColor,
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
                      _buildList(key: 'Page1'),
                       _buildList1(key: 'Page2')
                    ],
                  )),
            ),
          )
        ],
      
    );
  }

  Widget _buildList({String key, String string}) {
  return ListView.builder(
    key: PageStorageKey(key),
    itemBuilder: (_, i) => ListTile(title: Text("${string} ${i}")),
  );
  
}
  Widget _buildList1({String key, String string}) {
  return ListView.builder(
    key: PageStorageKey(key),
    itemBuilder: (_, i) => ListTile(title: Text("${string} ${i}")),
  );
  
}
}
