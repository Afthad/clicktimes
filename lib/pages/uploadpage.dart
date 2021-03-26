import 'dart:io';

import 'package:clicktimes/models/postmodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../constant.dart';

class Uploadpage extends StatefulWidget {
  final Usermodel usermodel;

  const Uploadpage({Key key, this.usermodel}) : super(key: key);

  @override
  _UploadpageState createState() => _UploadpageState();
}

class _UploadpageState extends State<Uploadpage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  TextEditingController controller = TextEditingController();
  FirebaseStorage storage =FirebaseStorage.instance;
  String postid = Uuid().v4();
  File _imageFile;
bool uploading=false;
Map<String,dynamic>likes={};

  final picker = ImagePicker();
  Future<void> _getImage() async {
    try {
      final pickedFile = await picker.getImage(
          source: ImageSource.gallery,
          imageQuality: 85,
          maxHeight: 700,
          maxWidth: 400);
      File cropped = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          cropStyle: CropStyle.rectangle,
          maxHeight: 700,
          maxWidth: 400,
          compressFormat: ImageCompressFormat.png,
          aspectRatioPresets: [
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9,
          ],
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop the Picture',
            toolbarColor: Colors.white,
            toolbarWidgetColor: kPrimaryColor,
          ));

      setState(() {
        _imageFile = cropped;
      });
    } catch (e) {
      print("dddddddddddddddddddddddddddddddddddddd" + e);
    }
  }

  _submit(Database database) async {
  
uploading=true;
  Reference ref = FirebaseStorage.instance.ref().child(postid);
    
    final uploadTask =await ref.putFile(_imageFile);

     String url= await uploadTask.ref.getDownloadURL();

      
    if (controller.text != null && url != null) {
      try {
        final post = Post(
            caption: controller.text,
            posturl: url,
            postId: postid,
            uid: widget.usermodel.uid,
            username: widget.usermodel.name,
            likes: likes,
            
            );
        await database.addpost(post,postid);
        uploading=false;
        _clear();
       
      } catch (e) {}
    }
    else ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
final snackBar = SnackBar(content: Text('Something not correct') , action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),);
  void _clear() {
    setState(() => _imageFile = null);
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    final database = Provider.of<Database>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 14),
            child: Text(
              'Upload',
              style: chatroomtitle,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          if (_imageFile == null) ...[
            
            SizedBox(
              height: 60,
            ),
            Container(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: kPrimaryLight,
                child: GestureDetector(
                    onTap: _getImage,
                    child: SvgPicture.asset(
                      'images/Upload.svg',
                      color: kPrimaryColor,
                    )),
                radius: 70,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              'Upload',
              style: paragraphmedium2,
            ))
          ],
          if (_imageFile != null) ...[
            Image(image: FileImage(_imageFile)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if(uploading!=true)...[
                IconButton(
                    icon: Icon(Icons.refresh_rounded),
                    onPressed: () {
                      _clear();
                    }),
              ],],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Caption :',
                    style: upload,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      maxLength: 160,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      autocorrect: true,
                      autofocus: false,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Type Some Caption.',
                          filled: true,
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          counterText: ''),
                    ),
                  ),
                ],
              ),
            ),
        if(uploading==false)...[
            Center(
              child: MaterialButton(
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
              ),
            ),
        ],
        if(uploading==true)...[
          CircularProgressIndicator()
        ]
          ]
        ],
      ),
    );
  }
}
