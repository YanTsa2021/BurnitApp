//Add Video page implementation

import 'dart:convert';
import 'package:burnit_app/upcomingexercisebycoach.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'checkconnectivity.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const AddVideo(userId: '',),
    },
  ));
}

class AddVideo extends StatefulWidget {
  final String userId;
  const AddVideo({key, required this.userId});

  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State <AddVideo>{
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _controller;
  bool isCaptured=false;


  //Image Picker For Pick video from gallery or Camera
  void Pickvideo(BuildContext context, ImageSource source) async {
    _image= await _picker.pickVideo(source: source, );
    setState(() {
      isCaptured=true;
    });
    _playVideo(_image);
    print("Video Path ${_image!.path}");
    Navigator.pop(context);
  }

  Widget _previewVideo() {
    if (_controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(_controller),
    );
  }

  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      print("Loading Video");
      await _disposeVideoController();
      late VideoPlayerController controller;
      /*if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
      } else {*/
      controller = VideoPlayerController.file(File(file.path));
      //}
      _controller = controller;
      // In web, most browsers won't honor a programmatic call to .play
      // if the video has a sound track (and is not muted).
      // Mute the video so it auto-plays in web!
      // This is not needed if the call to .play is the result of user
      // interaction (clicking on a "play" button, for example).

      //await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      await controller.pause();

      setState(() {});
    }
    else
    {
      print("Loading Video error");
    }
  }
  Future<void> _disposeVideoController() async {
    /*  if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;*/
    if (_controller != null) {
      await _controller!.dispose();
    }
    _controller = null;
  }

  //Image Picker Model,For Select Video, or Capture Video
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
                  Pickvideo(context, ImageSource.gallery);
                },
                title: const Text("Gallery"),
                leading: const Icon(Icons.account_box,color: Colors.blue,),
              ),

              const Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  Pickvideo(context, ImageSource.camera);
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
  uploadFileFromDio(XFile? file, BuildContext context) async {
    print(widget.userId.toString());
    String? fileName = file?.path.split('/').last;

    FormData data = FormData.fromMap({
      "title": _userProfile.heading.text,
      "description": _userProfile.description.text,
      "reps": _userProfile.reps.text,
      "sets": _userProfile.sets.text,
      "time": _userProfile.time.text,
      //"belong_to": User’,’Coach’),
      "belong_to": "User",
      "user_id": widget.userId.toString(),
      "coach_id": 1,
      "file_url": await MultipartFile.fromFile(
        file!.path,
        filename: fileName,
      ),
    });

    Dio dio = Dio();

    try{
      var response = await dio.post('http://api.burnit.socecepme.com/api/exercise',
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
            builder: (context) => UpComingExerciseByCoach(userId: widget.userId.toString(),))
        );
      }
      if(response.statusCode == 400){
        //fetch error
        _userProfile.resp = jsonDecode(_userProfile.apidata)['0']['file_url'];

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
        appBar: AppBar(
          title: Row(children: [
            Expanded(
              child:Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 35.0,
                  height: 35.0,
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
                      height: 35.0,
                      alignment:Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => UpComingExerciseByCoach(userId:widget.userId.toString(),)));
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
                    child: const Text('Add Video',style: TextStyle(color: Colors.black, fontSize: 20,
                      fontWeight: FontWeight.bold,),)
                ),
              ),
            ),
            Expanded(
              child:Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 35.0,
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
          child: ListView(
            shrinkWrap: true,
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
                        const Text('Upload Video'),
                        Container(
                          height: 40.0,
                          width: 40.0,
                          alignment:Alignment.center,
                          // Using the file widget to show our video
                          child: _image != null? Image.file(
                            File((_image!.path)),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ) : const SizedBox(),
                          //child: _previewVideo(),
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
                    controller: _userProfile.reps,
                    autocorrect: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(),
                      labelText: 'Enter Reps here',
                      hintText: 'Enter',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid rep';
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
                    controller: _userProfile.sets,
                    autocorrect: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(),
                      labelText: 'Enter Sets here',
                      hintText: 'Enter',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid set';
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
                    controller: _userProfile.time,
                    autocorrect: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(),
                      labelText: 'Enter Time here',
                      hintText: 'Enter',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid time';
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
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(30),
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
                      child: const Text('Post',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),),
                      onPressed: () {
                        // It returns true if the form is valid, otherwise returns false
                        if (_formKey.currentState!.validate()) {
                          _submit();
                          uploadFileFromDio(_image!,context);
                          //uploadFileFromDio(_previewVideo(),context);
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
                  child: const CheckConnectivity(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller!.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(

          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
      );
    } else {
      return Container();
    }
  }
}
