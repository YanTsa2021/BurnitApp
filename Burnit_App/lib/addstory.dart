//Add Story page implementation

import 'package:burnit_app/addstorytofeed.dart';
import 'package:burnit_app/storyview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => AddStory(),
    },
  ));
}

class AddStory extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State < AddStory>{
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  var image;
  final _picker = ImagePicker();

  //Image or Video Picker For Pick image from gallery
  void getImageGallery() async {
    var _pickedImage = await _picker.getImage(source: ImageSource.gallery);
    var _pickedVideo = await _picker.getVideo(source: ImageSource.gallery);
    if( _pickedImage != null) {
      setState(() {
        image = _pickedImage.path;
      });
    }
    //if(_pickedVideo != null) {
      //setState(() {
       // image = _pickedVideo.path;
      //});
    //}
  }

  //Image or Video Picker For Pick image from Camera
  void getImageCamera() async {
    var _pickedImage = await _picker.getImage(source: ImageSource.camera);
    var _pickedVideo = await _picker.getVideo(source: ImageSource.camera);
    if( _pickedImage != null) {
       setState(() {
       image = _pickedImage.path;
      });
    }
    //if(_pickedVideo != null) {
       //setState(() {
        //image = _pickedVideo.path;
       //});
   // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
                child: Container(
                  margin: const EdgeInsets.only(top:2.0),
                  height: 35.0,
                  width: 350.0,
                  alignment:Alignment.center,
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
                                    builder: (context) => StoryView()));
                              },
                              child: Container(
                                child: Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: Colors.black,),
                              ),
                            )
                        ),
                      ),
                      Container(
                        width: 80.0,
                      ),
                      Container(
                        width: 230.0,
                      ),
                    ],
                  ),
                ),
                preferredSize: Size.fromHeight(kToolbarHeight)),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            toolbarHeight: 0.2,
          ),
          resizeToAvoidBottomInset: false, // set it to false
          extendBodyBehindAppBar: true,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage('assets/ImgAddStory.png'),
              ),
            ),
           child: Column(children: <Widget>[
             Container(
               margin: EdgeInsets.all(40),
               padding: EdgeInsets.all(40),
             ),
              Container(
                //padding: EdgeInsets.only(top: 200, left: 20),
                height: 350.0,
                width: 350.0,
                alignment:Alignment.center,
                // Using the file widget to show our image
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AddStoryFeed()));
                    },
                    child: image != null? Image.file(
                      File(image),
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ) : const SizedBox(),
                  )
              ),
             Container(
               margin: EdgeInsets.all(50),
               padding: EdgeInsets.all(50),
             ),
             Container(
               margin: const EdgeInsets.only(top:2.0),
               height: 50.0,
               width: 350.0,
               alignment:Alignment.centerLeft,
               child: ListView(
                 scrollDirection: Axis.horizontal,
                 shrinkWrap: true,
                 children: <Widget>[
                   Container(
                     width: 52.0,
                     alignment:Alignment.centerLeft,
                     decoration: BoxDecoration(
                       border: Border.all(
                         color: Colors.grey,
                         width: 1,
                       ),
                       color: Colors.grey,
                       borderRadius: BorderRadius.circular(8),
                     ),
                     child: Container(
                       width: 52.0,
                       alignment:Alignment.center,
                       child: GestureDetector(
                         onTap: () {
                             getImageGallery();
                         },
                         child: Container(
                           child: Icon(Icons.image_outlined,size: 30, color: Colors.white,),
                         ),
                       ),
                     ),
                   ),
                   Container(
                     width: 95,
                   ),
                   Container(
                     width: 50.0,
                     alignment:Alignment.center,
                     decoration: BoxDecoration(
                       border: Border.all(
                         color: Colors.grey,
                         width: 5,
                       ),
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(60),
                     ),
                     child: Container(
                         width: 50.0,
                         alignment:Alignment.center,
                         child: GestureDetector(
                           onTap: () {
                             getImageCamera();
                           },
                             child: Container(
                               child: Icon(Icons.flip_camera_ios_outlined,size: 40, color: Colors.white,),
                             ),
                         ),
                     ),
                   ),
                   Container(
                     width: 100.0,
                   ),
                   Container(
                     width: 52.0,
                     alignment:Alignment.centerRight,
                     decoration: BoxDecoration(
                       border: Border.all(
                         color: Colors.grey,
                         width: 1,
                       ),
                       color: Colors.grey,
                       borderRadius: BorderRadius.circular(8),
                     ),
                     child: Container(
                       width: 52.0,
                       alignment:Alignment.center,
                       child: GestureDetector(
                         onTap: () {
                           getImageCamera();
                         },
                         child: Container(
                           child: Icon(Icons.flip_camera_ios_outlined,size: 30, color: Colors.white,),

                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ]),
          ),
        )
    );
  }
}