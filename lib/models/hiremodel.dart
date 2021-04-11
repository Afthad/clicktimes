import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/testing.dart';

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
final bool reject;
final bool paymentrequest;
final bool complete;
final String amount;
final bool paid;


  Hire(
      { this.category,
       this.customeruid,
       this.description,
      
       this.enddate,
       this.startdate,
       this.freelanceruid,
       this.location,
       this.orderid,
       this.phone,
      this. created,
      this.budget,
      this.start,
      this.reject,
       this.paymentrequest,
       this.complete,
       this.amount,
       this.paid,
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
 final bool reject=data['reject'];
final bool complete=data['complete'];
 final bool paymentrequest=data['paymentrequest'];
final String amount=data['amount'];
final bool paid=data['paid'];
    return Hire(
      paid: paid,
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
        start: start,
        reject:reject,
        paymentrequest:paymentrequest,
        
        complete: complete,
        amount: amount,
        
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
        'budget':budget,
        'reject':reject,
        'paymentrequest':paymentrequest,
        'complete':complete,
        'amount':amount,
        'paid':paid
    };
}



}
