// import 'dart:developer';

// import 'package:clicktimes/constant.dart';
// import 'package:clicktimes/models/hiremodel.dart';
// import 'package:clicktimes/models/usermodel.dart';
// import 'package:clicktimes/services/database.dart';
// import 'package:clicktimes/widgets/datepickers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Hirepage extends StatefulWidget {
//   final Usermodel usermodel;
//   final Usermodel postuser;
//   final Database database;

//   const Hirepage(
//       {Key key,
//       @required this.usermodel,
//       @required this.postuser,
//       @required this.database})
//       : super(key: key);
//   @override
//   _HirepageState createState() => _HirepageState();

//   static Future<void> show(BuildContext context, Database database,
//       Usermodel usermodel, Usermodel postuser) async {
//     await Navigator.of(
//       context,
//       rootNavigator: true,
//     ).push(
//       MaterialPageRoute(
//         builder: (context) => Hirepage(
//           database: database,
//           postuser: postuser,
//           usermodel: usermodel,
//         ),
//       ),
//     );
//   }
// }

// class _HirepageState extends State<Hirepage> {
//   final _formKey = GlobalKey<FormState>();
//   String category;
//   String customeruid;
//   String description;
//   String subcategory;
//   Timestamp enddate;
//   Timestamp startdate;
//   String freelanceruid;
//   String location;
//   String orderid;
//   String phone;
//   Timestamp created;
//   DateTime _startDate;

//   DateTime _endDate;
//   @override
//   void initState() {
//     super.initState();
//     final start = DateTime.now();
//     _startDate = DateTime(
//       start.year,
//       start.month,
//       start.day,
//       start.hour,
//       start.minute,
//     );

//     final end = DateTime.now();
//     _endDate = DateTime(end.year, end.month, end.day, end.hour, end.minute);
//   }

//   bool _validateAndSaveForm() {
//     final form = _formKey.currentState;

//     // if(_imageFile!= null){
//     // uploadImageToFirebase();}

//     if (form.validate()) {
//       form.save();
//       return true;
//     } else
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     return false;
//   }

//   Future<void> _submit() async {
//     if (_validateAndSaveForm()) {
//       try {
//         final hire = Hire();
//         //  await database.setUser(hire);

//       } catch (e) {
//         print(e);
//       }
//     }
//   }

//   final snackBar = SnackBar(content: Text('Role not Selected'));
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0.5,
//           backgroundColor: Colors.white,
//           title: Text(
//             'Send a Hire Request',
//             style: headerappbar,
//           ),
//           iconTheme: IconThemeData(color: kPrimaryColor),
//           centerTitle: true,
//         ),
//         backgroundColor: Colors.white,
//         body: _buildContents());
//   }

//   Widget _buildContents() {
//     return SingleChildScrollView(
//           child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//       Padding(padding: const EdgeInsets.all(16.0), child: _buildForm()),
//       MaterialButton(
//         onPressed: () {
//           _submit();
//         },
//         color: kPrimaryColor,
//         elevation: 0.0,
//         child: Text(
//           'Continue',
//           style: paragraphmedium,
//         ),
//         focusElevation: 0,
//         splashColor: null,
//         hoverElevation: 0,
//         highlightElevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//       )
//         ],
//       ),
//     );
//   }

  // Widget _buildForm() {
  //   return Form(
  //     key: _formKey,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //         children: _buildFormChildren(),
  //       ),
  //   );
  // }

//   List<Widget> _buildFormChildren() {
//    List<String> categorylist = widget.postuser.about.split(",");
//     return [
//       SizedBox(
//         height: 20,
//       ),
//       Text(
//         'Add Description',
//         style: hiretitlename,
//       ),
//       Divider(),
//       SizedBox(
//         height: 5,
//       ),
//       TextFormField(
//         autofocus: false,
//         maxLength: 300,
//         maxLines: 6,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.all(10),
//             enabledBorder: InputBorder.none,
//             focusedBorder: InputBorder.none,
//             counterStyle: paragraphmedium1,
//             hintText: 'Write in 300 characters max',
//             hintStyle: paragraphmedium1,
//             fillColor: Colors.white,
//             filled: true),
//         scrollPadding: EdgeInsets.zero,
//         keyboardType: TextInputType.multiline,
//         validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
//         onSaved: (value) => description = value,
//       ),
//       Divider(),
//       SizedBox(
//         height: 25,
//       ),
//       Text(
//         'Choose Category',
//         style: hiretitlename,
//       ),
//       SizedBox(
//         height: 7,
//       ),
//       Divider(),
//     Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
         
//           children: [
//             Text(
//     'Choose Category',
//     style: formheading,
//             ),
//             DropdownButtonHideUnderline(
//     child: DropdownButton<String>(
//       dropdownColor: Colors.white,
//       value: category,
//       icon: const Icon(Icons.arrow_downward),
//       iconSize: 0,
//       elevation: 0,
//       style: const TextStyle(color: kPrimaryColor),
//       hint: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           'Select',
//           style: formheading,
//         ),
//       ),
//       onChanged: (String newValue) {
//         setState(() {
//           category = newValue;
//         });
//       },
//       items: categorylist.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(
//             value,
//             style: paragraphmediumhr,
//           ),
//         );
//       }).toList(),
//     ),
//             ),
//           ],
//         ),
//       Divider(),
//       SizedBox(
//         height: 25,
//       ),
//       Text(
//         'Choose Date',
//         style: hiretitlename,
//       ),
//       SizedBox(
//         height: 7,
//       ),
//       Divider(),
//       SizedBox(
//         height: 7,
//       ),
//       _buildStartDate(),
//       SizedBox(
//         height: 7,
//       ),
//       Divider(),
//       SizedBox(
//         height: 7,
//       ),
//       _buildEndDate(),
//       SizedBox(
//         height: 7,
//       ),
//       Divider(),
//       SizedBox(
//         height: 25,
//       ),
//       Text(
//         'Your Budget',
//         style: hiretitlename,
//       ),
//       SizedBox(
//         height: 7,
//       ),
//       Divider(),
//       SizedBox(
//         height: 7,
//       ),
//       Container(
//         height: 60,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('ddd'),
//             Row(
//               children: [
//                 Text('INR'),
//                 SizedBox(width: 5,),
//                 Container(
//                   height: 30,
//                   decoration: BoxDecoration(border: Border.all(width: 1)),
//                   width: 60,
//                   child: Center(
//                     child: TextFormField(
//                       autofocus: false,
//                       maxLength: 7,
//                       maxLines: 1,
//                       decoration: InputDecoration(
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         counter: null,
//                         isCollapsed: true,
//                         counterText: '',

//                         //counterStyle: paragraphmedium1,
//                         hintText: 'Min ₹100',
//                         hintStyle: paragraphmedium1,
//                       ),
//                       scrollPadding: EdgeInsets.zero,
//                       keyboardType: TextInputType.multiline,
//                       onSaved: (value) => description = value,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ];
//   }

//   Widget _buildStartDate() {
//     return DateTimePicker(
//       labelText: 'Start Date',
//       selectedDate: _startDate,
//       onSelectedDate: (date) => setState(() => _startDate = date),
//     );
//   }

//   Widget _buildEndDate() {
//     return DateTimePicker(
//       labelText: 'End Date',
//       selectedDate: _endDate,
//       onSelectedDate: (date) => setState(() => _endDate = date),
//     );
//   }
// }
