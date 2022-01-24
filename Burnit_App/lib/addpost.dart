//Add Post page implementation

import 'dart:convert';

import 'package:burnit_app/pagestoryview.dart';
import 'package:burnit_app/posts.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'checkconnectivity.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const AddPost(userId: '',),
    },
  ));
}

class AddPost extends StatefulWidget {
  final String userId;
  const AddPost({key, required this.userId});

  @override
  MyCustomFormState createState() {
  return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State <AddPost>{
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  File? _image;
  var image;

  DateTime now = DateTime.now();

  //Image Picker For Pick image from gallery or Camera
  void Pickimage(BuildContext context, ImageSource source) async {
    final _picker = ImagePicker();
    var _pickedImage = await _picker.getImage(source:  source, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      image = _pickedImage?.path;
    });
    Navigator.pop(context);
  }

  //Image Picker Model,For Select Images or Capture Image
  void openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 180.0,
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Pick An Image / Video',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 15.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text(
                    'Use Camera',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    Pickimage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text(
                    'Use Gallery',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    Pickimage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }
  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

  //Fonction to upload image
  uploadFileFromDio(File file, BuildContext context) async {
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "profile": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = Dio();

    try{
      var response = await dio.post('http://api.burnit.socecepme.com/api/user-information/step4/'+widget.userId.toString(),
          data: data,
          options: Options(
              method: 'POST',
              responseType: ResponseType.json // or ResponseType.JSON
          ));

      print(widget.userId.toString());
      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      _userProfile.apidata = response.data; //get JSON decoded data from response
      print("Response application: ${_userProfile.apidata}");
      if(response.statusCode == 200){
        _userProfile.resp  = Map<String, dynamic>.from(response.data);
        print( _userProfile.resp['status']);
        Fluttertoast.showToast(
            msg:  _userProfile.resp ['status']);
      }
      if(response.statusCode == 400){
        //fetch error
        _userProfile.resp = jsonDecode(_userProfile.apidata)['0']['profile'];

        //split string
        String finalResp = _userProfile.resp.reduce((value, element) {
          return value + element;
        });
        print(finalResp);
        Fluttertoast.showToast(msg: finalResp);
      }
      else {
        throw Exception('Failed to load data');
      }
    }catch(e){
      print(e);
    }
  }

  //Fonction to add a news feed
  Future <void> addNewFeedsData() async {
    print(widget.userId.toString());
    print(now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString());
    try {
      final response = await http.post( Uri.parse('http://api.burnit.socecepme.com/api/feed'), body: {
        "title": _userProfile.heading.text,
        "description": _userProfile.description.text,
        "feed_type": _userProfile.tog.text,
        "image_url": uploadFileFromDio(_image!,context),
        "time": now,
        "user_id": widget.userId.toString(),
      });

      _userProfile.apidata = response.body; //get JSON decoded data from response

      print(_userProfile.apidata); //printing the JSON recieved
      print(response.statusCode); //printing the statusCode recieved

      if(response.statusCode == 200){
        //fetch successful
        Map<String, dynamic> responseJSON = jsonDecode(_userProfile.apidata);
        print(responseJSON['message']);
        Fluttertoast.showToast(
            msg: responseJSON['message']);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => StoryPageView())
        );
      }
      if(response.statusCode == 400){
        //fetch error
        _userProfile.resp = jsonDecode(_userProfile.apidata)['error']; //get all the data from json string
        print(_userProfile.resp);
        Fluttertoast.showToast(msg: _userProfile.resp);
      }
      else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // error handling
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Scaffold(
          appBar: PreferredSize(
            child: Container(
              margin: const EdgeInsets.only(top:40.0),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 7),
              height: 45.0,
              width: 350.0,
              alignment:Alignment.centerLeft,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    width: 35.0,
                    alignment:Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                        width: 35.0,
                        alignment:Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const Posts(userId: '',)));
                          },
                          child: Container(
                            child: Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: Colors.black,),
                          ),
                        )
                    ),
                  ),
                  Container(
                    width: 20.0,
                  ),
                  Container(
                    width: 230.0,
                    alignment:Alignment.center,
                    child: const Text('Add Post',style: TextStyle(color: Colors.black, fontSize: 20,
                      fontWeight: FontWeight.bold,),),
                  ),
                  Container(
                    width: 25.0,
                  ),
                  Container(
                    width: 35.0,
                    alignment:Alignment.centerRight,
                  ),
                ],
              ),
            ),
            preferredSize: const Size.fromHeight(500.0),
          ),
          resizeToAvoidBottomInset: false, // set it to false
            body: Center(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(1),
                    width: 350.0,
                    height: 160,
                    alignment:Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: 150.0,
                      alignment:Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                            openImagePickerModal(context);
                        },
                        child: Container(
                          width: 150.0,
                          height: 90,
                          alignment:Alignment.center,
                          child: Column(children: <Widget>[
                            Icon(Icons.cloud_upload_outlined,size: 30, color: Colors.black,),
                            Text('Upload image / video'),
                            Container(
                              //padding: EdgeInsets.only(top: 200, left: 20),
                              height: 40.0,
                              width: 40.0,
                              alignment:Alignment.center,
                              // Using the file widget to show our image
                              child: image != null? Image.file(
                                File(image),
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ) : const SizedBox(),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.all(2),
                  ),
                  Container(
                    width: 350,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child:TextFormField(
                        key: Key('shop_category_filter_input_text_field'),
                        controller: _userProfile.heading,
                        autocorrect: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(),
                          labelText: 'Enter Heading here',
                          hintText: 'Heading',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid heading';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child:TextFormField(
                        key: Key('shop_category_filter_input_text_field'),
                        controller: _userProfile.description,
                        autocorrect: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(2.0, 30.0, 2.0, 30.0),
                          border: OutlineInputBorder(),
                          labelText: '    Enter Description here',
                          hintText: 'Description',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid description';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child:TextFormField(
                        key: Key('shop_category_filter_input_text_field'),
                        controller: _userProfile.tog,
                        autocorrect: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(),
                          labelText: 'Enter Tog here',
                          hintText: 'Enter',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid tog';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(1),
                    padding: EdgeInsets.all(1),
                  ),
                  Container(
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: const Text('#Fun #Exitement #Tour #Friendsforever',style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                        color: Colors.purple,
                      ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(60),
                    padding: EdgeInsets.all(60),
                  ),
                  Container(
                    height: 44.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: SizedBox(
                      height: 44.0,
                      width: 350.0,// specific value
                      child: RaisedButton(
                        elevation: 0,
                        textColor: Colors.white,
                        color: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide( color: Colors.purple,width: 1,)
                        ),
                        child: const Text('Post',style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          textBaseline: TextBaseline.alphabetic,
                        ),),
                        onPressed: () {
                          // It returns true if the form is valid, otherwise returns false
                          if (_formKey.currentState!.validate()) {
                            _submit();
                            addNewFeedsData();
                          }
                        },
                      ),
                    ),
                    ),
                  ),
                  Container(
                    height: 20.0,
                    width: 350.0,
                    alignment:Alignment.centerRight,
                    child: const CheckConnectivity(),
                  ),///th
                  //throw UnimplementedError();
                ],
              ),
            ),
        ),
    );
  }
}
