import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Hire {
  final String category;
  final String customeruid;
  final String description;

  final Timestamp enddate;
  final Timestamp startdate;
  final String freelanceruid;
  final String location;
  final String orderid;
  final String phone;
  final Timestamp created;
  final String budget;
final bool start;


  Hire(
      {@required this.category,
      @required this.customeruid,
      @required this.description,
      
      @required this.enddate,
      @required this.startdate,
      @required this.freelanceruid,
      @required this.location,
      @required this.orderid,
      @required this.phone,
     @required this. created,
     @required this.budget,
     @required this.start
      });

  factory Hire.fromMap(Map<String, dynamic> data, String documentId) {
    final String category = data['category'];
    final String customeruid = data['customeruid'];
    final String description = data['description'];

    final Timestamp enddate = data['enddate'];
    final Timestamp startdate = data['startdate'];
    final String freelanceruid = data['freelanceruid'];
    final String location = data['location'];
    final String orderid = data['orderid'];
    final String phone = data['phone'];
 final Timestamp created=data['created'];
 final String budget =data['budget'];
 final bool start=data['start'];
    return Hire(
        category: category,
        customeruid: customeruid,
        description: description,
       
        enddate: enddate,
        startdate: startdate,
        freelanceruid: freelanceruid,
        location: location,
        orderid: orderid,
        phone: phone,
        created: created,
        budget :budget ,
        start: start
        
        );
  }


    Map<String, dynamic> toMap() {
    return {
     'category': category,
        'customeruid': customeruid,
        'description': description,
        'start':start,
        'enddate': enddate,
        'startdate': startdate,
        'freelanceruid': freelanceruid,
        'location': location,
        'orderid': orderid,
        'phone': phone,
        'created':created,
        'budget ':budget ,
    };
}

}
