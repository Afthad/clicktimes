import 'dart:io';
import 'dart:ui';

import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/widgets/choices.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class Registrationpage extends StatefulWidget {
  final String uid;

  const Registrationpage({Key key, this.uid}) : super(key: key);
  @override
  _RegistrationpageState createState() => _RegistrationpageState();
}

class _RegistrationpageState extends State<Registrationpage> {
  File _imageFile;
  final picker = ImagePicker();

  _RegistrationpageState();

  /// Cropper plugin
  Future<void> _getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxHeight: 400,
        maxWidth: 400);
    File cropped = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.png,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio4x3,
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Your Photo',
          toolbarColor: Colors.white,
          toolbarWidgetColor: kPrimaryColor,
        ));

    setState(() {
      _imageFile = cropped;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  final _formKey = GlobalKey<FormState>();
  String name;
  String uid ;
  String location;
  String profile;
  String phone;
  String role;
  String website;
  String about ='';

  String freelancerText =
      "Free lancers provide services like Photography, Video Editing, Graphic Design, Camera Renting";
  String customerText =
      "You can hire Free Lancer nearby at any time to complete your current Requirements ";
  String ctAgentText = "Earn money bt referrring your community";

  List<String> workList = [
    "Photography",
    "Vedio Editing",
    "Camera Renting",
    "Graphic Design"
  ];
  List<String> selectedworkList = [];
final snackBar=SnackBar(content: Text('Role not Selected'),

action: SnackBarAction(label: 'Undo', onPressed: (){}),

);
  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    print(widget.uid);
    // if(_imageFile!= null){
    // uploadImageToFirebase();}
    if(role != null){
    if (form.validate())  {
      form.save();
      return true;
    
    }}
    else ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return false;
  }

  Future<void> _submit(Database database) async {
    if (_validateAndSaveForm()) {
      try {
        final usermodel = Usermodel(
          
          
            about: selectedworkList!=null? selectedworkList.join(','):'null',
            profile:'dddd' ,
            phone: phone,
            role: role,
            uid: widget.uid,
            website: website,
            location: location,
            name: name);
        await database.setUser(usermodel);
       
       
      } catch (e) {
        print(e);
      }
    }
  }
Future<String> uploadImageToFirebase() async {
    String fileName = _imageFile.path;
      Reference ref =
    FirebaseStorage.instance.ref().child(fileName+DateTime.now().toString());
  await ref.putFile(_imageFile);
    return await ref.getDownloadURL();
  }
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
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
      body: _buildContents(database),
    );
  }

  Widget _buildContents(database) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircleAvatar(
            backgroundImage: _imageFile != null ? FileImage(_imageFile) : null,
            child: _imageFile == null
                ? IconButton(
                    icon: Icon(Icons.camera_alt),
                    color: Colors.white,
                    onPressed: _getImage)
                : IconButton(
                    icon: Icon(Icons.camera_alt),
                    color: Colors.white,
                    iconSize: 0,
                    onPressed: () async {
                      _clear();
                    },
                  ),
            backgroundColor: kSecondary,
            radius: 70,
          ),
        ),
        Padding(padding: const EdgeInsets.all(16.0), child: _buildForm()),
        MaterialButton(
          onPressed: () {
            _submit(database);
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        )
      ],
    ));
  }

  Widget _buildForm() {
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
      Text(
        'Your Name',
        style: formheading,
      ),
      Divider(),
      TextFormField(
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: Colors.grey, width: .5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: Colors.grey, width: .5),
            ),
            hintText: 'Name',
            hintStyle: paragraphmedium1,
            fillColor: Colors.white,
            filled: true),
        keyboardType: TextInputType.name,
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => name = value,
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'Your Phone Number',
        style: formheading,
      ),
      Divider(),
      TextFormField(autofocus: false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: Colors.grey, width: .5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: Colors.grey, width: .5),
            ),
            hintText: 'Phone Number',
            hintStyle: paragraphmedium1,
            fillColor: Colors.white,
            filled: true),
        keyboardType: TextInputType.phone,
        validator: (value) =>
            value.isNotEmpty ? null : 'Phone Number can\'t be empty',
        onSaved: (value) => phone = value,
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'Your Location',
        style: formheading,
      ),
      Divider(),
      TextFormField(autofocus: false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: Colors.grey, width: .5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: Colors.grey, width: .5),
            ),
            hintText: 'Location',
            hintStyle: paragraphmedium1,
            fillColor: Colors.white,
            filled: true),
        keyboardType: TextInputType.name,
        validator: (value) =>
            value.isNotEmpty ? null : 'Location Number can\'t be empty',
        onSaved: (value) => location = value,
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'Select Role',
        style: formheading,
      ),
      Divider(),
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: .5),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: DropdownButton<String>(
            value: role,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 0,
            elevation: 0,
            hint: Text(
              'Select Role',
              style: paragraphmedium1,
            ),
            style: const TextStyle(color: Colors.black),
            dropdownColor: Colors.white,
            underline: Container(
              height: 2,
              color: Colors.transparent,
            ),
            onChanged: (String newValue) {
              setState(() {
                role = newValue;
                website='';
                selectedworkList=[];
              });
            },
            items: <String>['Freelancer', 'Customer', 'CT Agent']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
      if (role == 'Freelancer') ...[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(freelancerText),
        )
      ],
      if (role == 'Customer') ...[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(customerText),
        )
      ],
      if (role == 'CT Agent') ...[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(ctAgentText),
        )
      ],
      if (role == 'Freelancer') ...[
        SizedBox(
          height: 10,
        ),
        Text(
          'Your Website',
          style: formheading,
        ),
        Divider(),
        TextFormField(

         autofocus: false,
          
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(color: Colors.grey, width: .5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(color: Colors.grey, width: .5),
              ),
              hintText: 'Website',
              hintStyle: paragraphmedium1,
              fillColor: Colors.white,
              filled: true),
          keyboardType: TextInputType.name,
          validator: (value) =>
              value.isNotEmpty ? null : 'Website Number can\'t be empty',
          onSaved: (value) => website = value,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Works You Do',
          style: formheading,
        ),
        Divider(),
        MultiSelectChip(
          workList,
          onSelectionChanged: (selectedList) {
            setState(() {
              selectedworkList = selectedList;
            });
          },
        ),
      ]
    ];
  }
}
