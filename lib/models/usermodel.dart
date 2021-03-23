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

  Usermodel({ @required this.about, @required this.name, @required this.uid,@required this.location,@required this.profile,@required this.phone, @required this.role,@required this.website});

 factory Usermodel.fromMap(Map<String, dynamic> data, String documentId){
   if(data==null){
     return null;
   }

 final String name = data['name'];
final String uid = data['uid'];
final String location = data['location'];
final String profile = data['profile'];
final String phone = data['phone'];
final String role = data['role'];
final String website = data['website'];
final String about = data['about'];
return Usermodel(about: about, name: name, uid: uid, location: location, profile: profile, phone: phone, role: role, website: website);

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
      'profile':profile

    };
}

}