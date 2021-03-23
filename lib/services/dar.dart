import 'package:clicktimes/constant.dart';
import 'package:flutter/material.dart';

class ProfileFreelancer extends StatefulWidget {
  @override
  _ProfileFreelancerState createState() => _ProfileFreelancerState();
}

class _ProfileFreelancerState extends State<ProfileFreelancer> {



  List list=['Posts','About'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey,
                      // backgroundImage: NetworkImage(widget.usermodel.profile),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(74, 74, 0, 0),
                        child: Icon(
                          Icons.circle,
                          size: 15,
                          color: kSuccessColorPayment,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                  )
                ],
              ),
              Row(
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
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return
                   Text(list[index]);
                  
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
