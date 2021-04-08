import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Bookingmodel {
  final String category;
  final String customeruid;
  final String description;

  final Timestamp enddate;
  final Timestamp startdate;

  final String location;
  final String orderid;
  final String phone;
  final Timestamp created;
  final String budget;
  final bool start;

  Bookingmodel(
      { this.category,
       this.customeruid,
       this.description,
      
       this.enddate,
       this.startdate,
     
       this.location,
       this.orderid,
       this.phone,
      this. created,
      this.budget,
       this.start,
      });

  factory Bookingmodel.fromMap(Map<String, dynamic> data, String documentId) {
    final String category = data['category'];
    final String customeruid = data['customeruid'];
    final String description = data['description'];

    final Timestamp enddate = data['enddate'];
    final Timestamp startdate = data['startdate'];
     final bool start=data['start'];
    final String location = data['location'];
    final String orderid = data['orderid'];
    final String phone = data['phone'];
 final Timestamp created=data['created'];
 final String budget =data['budget'];
    return Bookingmodel(
        category: category,
        customeruid: customeruid,
        description: description,
       start: start,
        enddate: enddate,
        startdate: startdate,
      
        location: location,
        orderid: orderid,
        phone: phone,
        created: created,
        budget :budget 
        
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
        'location': location,
        'orderid': orderid,
        'phone': phone,
        'created':created,
        'budget':budget ,
    };
}
    Map<String, dynamic> paymenToMap() {
    return {
     'category': category,
        'customeruid': customeruid,
        'description': description,
        'start':start,
        'enddate': enddate,
        'startdate': startdate,
        'location': location,
        'orderid': orderid,
        'phone': phone,
        'created':created,
        'budget':budget ,
    };
}
}
