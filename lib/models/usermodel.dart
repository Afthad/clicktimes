import 'package:flutter/material.dart';

class Usermodel{


final String name;
final String uid;
final String location;
final String profile;
final String phone;
final String role;
final String website;
final String about;
final bool available;
final String email;
final dynamic searchindex;

  Usermodel( {@required this.searchindex,@required this.email, this.available, @required this.about, @required this.name, @required this.uid,@required this.location,@required this.profile,@required this.phone, @required this.role,@required this.website});

 factory Usermodel.fromMap(Map<String, dynamic> data, String documentId){
   

 final String name = data['name'];
final String uid = data['uid'];
final String location = data['location'];
final String profile = data['profile'];
final String phone = data['phone'];
final String role = data['role'];
final String website = data['website'];
final String about = data['about'];
final bool available =data['available'];
final String email=data['email'];
final dynamic searchindex=data['searchindex'];
return Usermodel(about: about, name: name, uid: uid, location: location, profile: profile, phone: phone, role: role, website: website,available:available,email: email,searchindex: searchindex);

 }
  Map<String, dynamic> toMap(){
    return{
      'uid':uid,
      'name':name,
      'location':location,
      'phone':phone,
      'role' :role,
      'website':website,
      'about':about,
      'profile':profile,
      'available':available,
      'email':email,
      'searchindex':searchindex

    };
}

}