import 'package:clicktimes/services/auth.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class Homepage extends StatefulWidget {
  final AuthBase authBase;

  const Homepage({Key key, this.authBase}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String uid;
  String location;
  String profile;
  String phone;
  String role;
  String website;
  String about;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: Text(
          'Your Profile',
          style: headerappbar,
        ),
      ),
      backgroundColor: Colors.white,
      body: _buildContents(),
          );
        }
      
    Widget    _buildContents() {
return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildForm())
);
                    }
            
          Widget    _buildForm() {
            return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
              ),
            );
                  }
        
         List<Widget> _buildFormChildren() {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Your Name',
          
              fillColor: kSecondarylight,
          filled: true),
          
          validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
          onSaved: (value) => name = value,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Phone Number',
          
              fillColor: kSecondarylight,
          filled: true),
          validator: (value) => value.isNotEmpty ? null : 'Phone can\'t be empty',
     
          keyboardType: TextInputType.phone,
          onSaved: (value) =>phone ,
        ),
      ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: TextFormField(
          decoration: InputDecoration(labelText: 'About',
          
              fillColor: kSecondarylight,
          filled: true),
          validator: (value) => value.isNotEmpty ? null : 'About can\'t be empty',
     
          keyboardType: TextInputType.phone,
          onSaved: (value) =>phone ,
      ),
       ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: TextFormField(
          
          decoration: InputDecoration(labelText: 'Location',
          fillColor: kSecondarylight,
          filled: true
          
          ),
          validator: (value) => value.isNotEmpty ? null : 'Location can\'t be empty',
     
          keyboardType: TextInputType.phone,
          onSaved: (value) =>phone ,
      ),
       ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: TextFormField(
          decoration: InputDecoration(labelText: 'Website'
          ,
          
              fillColor: kSecondarylight,
          filled: true),
     
          keyboardType: TextInputType.phone,
          onSaved: (value) =>phone ,
      ),
       ),
    ];
  }
}
