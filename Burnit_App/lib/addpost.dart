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
import 'package:responsive_framework/responsive_wrapper.dart';
import 'checkconnectivity.dart';
import 'dataconnectivity.dart';


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
    PickedFile? pickedFile = await _picker.getImage(source:  source, imageQuality: 50, maxHeight: 500, maxWidth: 500);

    setState(() {
      _image =  File(pickedFile!.path);
    });
    Navigator.pop(context);
  }


  //Image Picker Model,For Select Images or Capture Image
  Future<void>_showChoiceDialog(BuildContext context)
  {
    return showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: const Text("Choose option",style: TextStyle(color: Colors.blue),),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              const Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  Pickimage(context, ImageSource.gallery);
                },
                title: const Text("Gallery"),
                leading: const Icon(Icons.account_box,color: Colors.blue,),
              ),

              const Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  Pickimage(context, ImageSource.camera);
                },
                title: const Text("Camera"),
                leading: const Icon(Icons.camera,color: Colors.blue,),
              ),
            ],
          ),
        ),);
    });
  }
  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

  //Fonction to add new feed
  uploadFileFromDio(File file, BuildContext context) async {
    print(widget.userId.toString());
    print(now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString());
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "image_url": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "title": _userProfile.heading.text,
      "description": _userProfile.description.text,
      "feed_type": _userProfile.tog.text,
      "user_id": widget.userId.toString(),
    });

    Dio dio = Dio();

    try{
      var response = await dio.post('http://api.burnit.socecepme.com/api/feed',
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
        Navigator.push(context, MaterialPageRoute(
          //builder: (context) => StoryPageView())
            builder: (context) => const Posts(userId: '',))
        );
      }
      if(response.statusCode == 400){
        //fetch error
        _userProfile.resp = jsonDecode(_userProfile.apidata)['0']['image_url'];

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: ResponsiveWrapper(
        maxWidth: 1200,
        minWidth: 680,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: '4K'),
        ],
        child:SizedBox(
        width: 1000.0,
        //width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1.19,
        //height: 1000,
        child: Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Expanded(
              child:Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 40.0,
                  height: 40.0,
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
                      width: 40.0,
                      height: 40.0,
                      alignment:Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const Posts(userId: '',)));
                        },
                        child: const Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: Colors.black,),
                      )
                  ),
                ),
              ),
            ),
            Expanded(
              child:Align(
                alignment: Alignment.center,
                child:Container(
                    width: 230.0,
                    alignment:Alignment.center,
                    child: const Text('Add Post',style: TextStyle(color: Colors.black, fontSize: 20,
                      fontWeight: FontWeight.bold,),)
                ),
              ),
            ),
            Expanded(
              child:Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 40.0,
                  alignment:Alignment.centerRight,
                ),
              ),
            ),
          ]),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0, // for elevation
          titleSpacing: 30.0, //
        ),
        resizeToAvoidBottomInset: false, // set it to false
        body: Center(
            child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
            return ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
              Container(
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(1),
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
                      _showChoiceDialog(context);
                    },
                    child: Container(
                      width: 150.0,
                      height: 90,
                      alignment:Alignment.center,
                      child: Column(children: <Widget>[
                        const Icon(Icons.cloud_upload_outlined,size: 30, color: Colors.black,),
                        const Text('Upload image / video'),
                        Container(
                          //padding: EdgeInsets.only(top: 200, left: 20),
                          height: 40.0,
                          width: 40.0,
                          alignment:Alignment.center,
                          // Using the file widget to show our image
                          child: _image != null? Image.file(
                            _image!,
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
                margin: const EdgeInsets.all(1),
                padding: const EdgeInsets.all(1),
              ),
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  child:TextFormField(
                    key: const Key('shop_category_filter_input_text_field'),
                    controller: _userProfile.heading,
                    autocorrect: true,
                    decoration: const InputDecoration(
                      //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  child:TextFormField(
                    key: const Key('shop_category_filter_input_text_field'),
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
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  child:TextFormField(
                    key: const Key('shop_category_filter_input_text_field'),
                    controller: _userProfile.tog,
                    autocorrect: true,
                    decoration: const InputDecoration(
                      //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                margin: const EdgeInsets.all(1),
                padding: const EdgeInsets.all(1),
              ),
              Container(
                width: 350.0,
                alignment:Alignment.centerLeft,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  child: Text('#Fun #Exitement #Tour #Friendsforever',style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    textBaseline: TextBaseline.alphabetic,
                    color: Colors.purple,
                  ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(60),
                padding: const EdgeInsets.all(60),
              ),
              Container(
                height: 50.0,
                width: 450.0,
                alignment:Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child: SizedBox(
                    height: 50.0,
                    width: 450.0,// specific value
                    child: RaisedButton(
                      elevation: 0,
                      textColor: Colors.white,
                      color: Colors.purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide( color: Colors.purple,width: 1,)
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
                          //addNewFeedsData();
                          uploadFileFromDio(_image!,context);
                        }
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 20.0,
                  width: 350.0,
                  alignment:Alignment.center,
                  child:  DataConnectivity(),
                ),
              ),
              ],
               );
              }
             ),
            ),
           ),
          ),
        ),
    );
  }
}
