import 'dart:ui';

import 'package:clicktimes/models/hiremodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/widgets/datepickers.dart';
import 'package:clicktimes/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../constant.dart';

class Hirepage extends StatefulWidget {
  final Usermodel usermodel;
  final Usermodel postuser;
  final Database database;

  const Hirepage(
      {Key key,
      @required this.usermodel,
      @required this.postuser,
      @required this.database})
      : super(key: key);
      
  static Future<void> show(BuildContext context, Database database,
      Usermodel usermodel, Usermodel postuser) async {
    await Navigator.of(
      context,
      rootNavigator: true,
    ).push(
      MaterialPageRoute(
        builder: (context) => Hirepage(
          database: database,
          postuser: postuser,
          usermodel: usermodel,
        ),
      ),
    );
  }

  _HirepageState createState() => _HirepageState();
}

class _HirepageState extends State<Hirepage> {
  final _formKey = GlobalKey<FormState>();
  String category ;
  String customeruid;
  String description;
  String subcategory;
  Timestamp enddate;
  Timestamp startdate;
  String freelanceruid;
  String location;
  String orderid;
  String phone;
  DateTime created =DateTime.now();
  DateTime _startDate;
  String budget;
 var uuid = Uuid().v4();
  DateTime _endDate;
  @override
  void initState() {
    super.initState();
    final start = DateTime.now();
    _startDate = DateTime(
      start.year,
      start.month,
      start.day,
      start.hour,
      start.minute,
    );

    final end = DateTime.now();
    _endDate = DateTime(end.year, end.month, end.day, end.hour, end.minute);
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    
 
    if (form.validate()) {
         if(_endDate.difference(_startDate).inDays>=0 ){
         

      form.save();
      return true;
   } else ScaffoldMessenger.of(context).showSnackBar(snackBarDate);
    
    } 
       
    return false;
 
  }

final snackBarDate = SnackBar(content: Text('Date not Selected Properly') , action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),);
final snackBarCategory = SnackBar(content: Text('Category not Selected '),  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),);
  Future<void> _submit() async {
    if (_validateAndSaveForm() && category!=null ) {

      try {
        startdate =Timestamp.fromDate(DateTime(_startDate.year,_startDate.month,_startDate.day,00,00,00));
        enddate =Timestamp.fromDate(DateTime(_endDate.year,_endDate.month,_endDate.day,23,59,59));
        final hire = Hire(created: Timestamp.fromDate(created),
        category: category,
        customeruid: widget.usermodel.uid,
        description: description,
        enddate: enddate,
        startdate: startdate,
        freelanceruid: widget.postuser.uid,
        location: widget.usermodel.location,
        orderid: uuid,
        phone: widget.usermodel.phone,
        budget: budget,
        start: false,
        
        
        
        
        );

         await widget.database.setHire(hire,uuid);
         Navigator.pop(context);

      } catch (e) {
        print(e);
      }
    } else  ScaffoldMessenger.of(context).showSnackBar(snackBarCategory);
  }

  @override
  Widget build(BuildContext context) {
    List<String> categorylist = widget.postuser.about.split(",");
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: Text(
            'Send a Hire Request',
            style: headerappbar,
          ),
          iconTheme: IconThemeData(color: kPrimaryColor),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Add Description',
                    style: hiretitlename,
                  ),
                  Divider(),
                  TextFormField(
                    autofocus: false,
                    maxLength: 300,
                    maxLines: 6,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        counterStyle: paragraphmedium1,
                        hintText: 'Write in 300 characters max',
                        hintStyle: paragraphmedium1,
                        fillColor: Colors.white,
                        filled: true),
                    scrollPadding: EdgeInsets.zero,
                    keyboardType: TextInputType.multiline,
                    validator: (value) =>
                        value.isNotEmpty ? null : 'Name can\'t be empty',
                    onSaved: (value) => description = value,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Choose Category',
                    style: hiretitlename,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category',
                        style: hiresubtitlename,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          underline: null,
                          dropdownColor: Colors.white,
                          value: category,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 0,
                          elevation: 0,
                          style: const TextStyle(color: kPrimaryColor),
                          hint: Padding(
                            padding: const EdgeInsets.only(left:50.0),
                            child: Text(
                              'Select',
                              style: hiresubtitlename,
                            ),
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              
                              category = newValue;
                            });
                          
                          },
                          items: categorylist
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,

                              child: Text(
                                value,
                                style: hiresubtitlename,
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Choose Date',
                    style: hiretitlename,
                  ),
                  Divider(),
                  SizedBox(
                    height: 7,
                  ),
                  _buildStartDate(),
                  SizedBox(
                    height: 7,
                  ),
                  Divider(),
                  SizedBox(
                    height: 7,
                  ),
                  _buildEndDate(),
                  SizedBox(
                    height: 7,
                  ),
                  
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(''),
                    _endDate.difference(_startDate).inDays>=0? Text('Duration: '' ${_endDate.difference(_startDate).inDays}'' Days'):Text('* Start date should be more',style:TextStyle(color: Colors.red) ,)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Your Budget',
                    style: hiretitlename,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Budget',
                        style: hiresubtitlename,
                      ),
                      Container(
                          height: 60,
                          child: Row(
                            children: [
                              Text('₹'),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    width: .5,
                                  ),
                                ),
                                width: 70,
                                child: Center(
                                  child: TextFormField(
                                    autofocus: false,
                                    maxLength: 7,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      counter: null,
                                      isCollapsed: true,
                                      counterText: '',
                                      contentPadding: EdgeInsets.all(3),
                                      //counterStyle: paragraphmedium1,
                                      hintText: 'Min ₹100',
                                      hintStyle: paragraphmedium1,
                                    ),
                                    scrollPadding: EdgeInsets.zero,
                                    keyboardType: TextInputType.number,
                                    onSaved: (value) => budget = value,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  Divider(),
                  Center(
                    child: MaterialButton(
                        onPressed: () {
                          _submit();
                        },
                        color: kPrimaryColor,
                        elevation: 0.0,
                        child: Text(
                          'Continue',
                          style: paragraphmedium,
                        ),
                        focusElevation: 0,
                        splashColor: null,
                        hoverElevation: 0,
                        highlightElevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildStartDate() {
    return SizedBox(
      child: DateTimePicker(
        labelText: 'Start Date',
        selectedDate: _startDate,
        onSelectedDate: (date) => setState(() => _startDate = date),
      ),
    );
  }

  Widget _buildEndDate() {
    return DateTimePicker(
      labelText: 'End Date',
      selectedDate: _endDate,
      onSelectedDate: (date) => setState(() => _endDate = date),
    );
  }
}
