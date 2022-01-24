//Basic information profile picture implementation

import 'dart:convert';
import 'package:burnit_app/homepage.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as Math;
import 'package:image/image.dart' as Img;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:path_provider/path_provider.dart';
import 'basicinforesidentinfo.dart';
import 'dart:io';

import 'checkconnectivity.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const BasicInfoProfilePicture(userId: '',),
    },
  ));
}

class BasicInfoProfilePicture extends StatefulWidget {
  final String userId;
  const BasicInfoProfilePicture({key, required this.userId});
  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State <BasicInfoProfilePicture>{
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  final _formKey = GlobalKey<FormState>();
  File? _image;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

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
  void openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 180.0,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Pick An Image',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: const Text(
                    'Use Camera',
                    style: const TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    Pickimage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: const Text(
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

  //Fonction to upload image
  Upload(File imageFile, BuildContext context) async {
    //var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var stream = http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();
    var uri = Uri.parse('http://api.burnit.socecepme.com/api/user-information/step4/'+widget.userId.toString());

    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('profile', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(widget.userId.toString());
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    _userProfile.apidata = response; //get JSON decoded data from response
    print(_userProfile.apidata); //printing the JSON recieved
    print(response.statusCode); //printing the statusCode recieved

    if(response.statusCode == 200){
      //fetch successful
      _userProfile.resp = jsonDecode( _userProfile.apidata)['status'];
      print(_userProfile.resp);
      Fluttertoast.showToast(msg: _userProfile.resp);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomePage(userId: widget.userId.toString()))
      );
    }
    if(response.statusCode == 400){
      //fetch error
      _userProfile.resp = jsonDecode( _userProfile.apidata)['0']['profile'];

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
          Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomePage(userId:widget.userId.toString(),))
          );
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

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
            appBar: PreferredSize(
              child: Container(
                  margin: const EdgeInsets.only(top:40.0),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
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
                                      builder: (context) => const BasicInfoResidentInfo(userId:'')));
                                },
                                child: Container(
                                  child: const Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: Colors.black,),
                                ),
                              )
                          ),
                        ),
                        Container(
                          width: 25.0,
                        ),
                        Container(
                          width: 210.0,
                          alignment:Alignment.center,
                          child: const Text('Basic Information',style: TextStyle(color: Colors.black, fontSize: 20,
                            fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          width: 15.0,
                        ),
                        Container(
                            width: 50.0,
                            alignment:Alignment.centerRight,
                            child: Text.rich(
                              TextSpan(text: 'Skip', style: const TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => const HomePage(userId: '',))
                                    );
                                  }
                              ),
                            )
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
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(0),
                  ),
                  Container(
                    width: 350,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 0),
                    child: RichText(
                      text: const TextSpan(text: ' 04',
                        style: const TextStyle(color: Colors.black, fontSize: 26,fontWeight: FontWeight.bold,),
                        children: [
                          TextSpan(text: '/04', style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,),

                          )
                        ],
                      ),
                    ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                  ),
                  Container(
                    width: 350,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 0),
                    child: RichText(
                      text: const TextSpan(text: ' Profile Picture',
                        style: TextStyle(color: Colors.black, fontSize: 26,fontWeight: FontWeight.bold,),
                        children: [
                          TextSpan(text: '\n  Lorem ipsum dolar sit amet.', style: const TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),

                          )
                        ],
                      ),
                    ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                  ),
                  Container(
                    width: 350,
                    height: 200,
                    alignment:Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        openImagePickerModal(context);
                      },
                      child: CircleAvatar(
                        radius: 150,
                        backgroundColor: const Color(0xffe4e14),
                        child: _image != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(250),
                          child: Image.file(
                            _image!,
                            width: 195,
                            height: 195,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50)),
                          width: 150,
                          height: 150,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(90),
                    padding: const EdgeInsets.all(80),
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
                            side: const BorderSide( color: Colors.purple,width: 1,)
                        ),
                        child: const Text('Finish',style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          textBaseline: TextBaseline.alphabetic,
                        ),),
                        onPressed: () {
                          // It returns true if the form is valid, otherwise returns false
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a Snackbar.
                            _submit();
                            //Upload(_image!,context);
                            uploadFileFromDio(_image!,context);
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
                  ),//
                  //throw UnimplementedError();
                ],
              ),
            )
        )
    );
  }
}