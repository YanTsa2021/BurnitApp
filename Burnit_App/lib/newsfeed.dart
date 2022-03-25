//New Feed page implementation

import 'dart:convert';
import 'dart:io';

import 'package:burnit_app/basicinfoprofilepicture.dart';
import 'package:burnit_app/myprofile.dart';
import 'package:burnit_app/playvideo.dart';
import 'package:burnit_app/posts.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'chat.dart';
import 'checkconnectivity.dart';
import 'homepage.dart';
import 'stories.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const NewsFeed(userId: '',),
    },
  ));
}

class NewsFeed extends StatefulWidget {
  final String userId;
  const NewsFeed({key, required this.userId});

  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State <NewsFeed>{
  // we get the instance of the stories class just as we would create a new instance.
  final Stories _story = Stories();
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  final String baseUrl = "http://api.burnit.socecepme.com/public/";
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  File? _image;

  void selectImagesVideos() async {
    final List<XFile>? selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState((){});
  }

  //Fonction to retrieve differents images post from the database
  Future<List<dynamic>> fetchUsersStories() async {
    final String apiUrl = "http://api.burnit.socecepme.com/api/getstory/"+widget.userId.toString();
    var response = await  http.get(Uri.parse(apiUrl));

    print(widget.userId.toString());
    print("Response status: ${response.statusCode}");
    print("Response data: ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];

    } else {
      throw Exception('Unable to fetch products from the REST API');
    }

  }

  String _name(dynamic story){
    return story['user']['name'];

  }

  String _storyImage(Map<dynamic, dynamic> story){
    String image = '';
    for (int i =0; i < story.length; i++){
    //for (int i =0; i < 4; i++){
      image = story['image'][0]['story_image_url'];
      print("Story Length: ${story.length}");
      print("Image**********************");
      print("Image: ${image}");
    }
    return  baseUrl + image;
  }

  //Fonction to pick and display images or videos
  displayImageVideos() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
                width: 350,
                height: 200,
                alignment:Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    selectImagesVideos();
                  },
                  child: CircleAvatar(
                    radius: 150,
                    backgroundColor: const Color(0xffe4e14),
                    child: imageFileList != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(250),
                        child: SizedBox(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: imageFileList!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.file(
                                      File((imageFileList![index].path)),
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      height: MediaQuery.of(context).size.height * 0.17,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: buildCancelIcon(Colors.white, () {
                                        setState(() {
                                           imageFileList!.removeAt(index);
                                        });
                                      }, Icons.cancel))
                                ]),);
                          }),),
                       )
                        : Container(
                         decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(150)),
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
            actions: <Widget>[
              FlatButton(
                child: const Text('Submit'),
                onPressed: () async {
                  uploadFileFromDio(imageFileList!,context);
                  //Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  //Fonction to add new story
  uploadFileFromDio(List <XFile> filepath , BuildContext context) async {
    print(widget.userId.toString());

    var files = [];

    for(var file in filepath) {
      files.add(await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last));
    }

    FormData data = FormData.fromMap({
       "image_url[]": files,
       "user_id": widget.userId.toString(),
    });

    Dio dio = Dio();

    try{
      var response = await dio.post('http://api.burnit.socecepme.com/api/story',
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
            builder: (context) => NewsFeed(userId:widget.userId.toString()))
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

  //Function to add a story to a database
  stories(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Column(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 0.3,
                    ),
                    shape: BoxShape.circle,
                    //color: Color(0xFFe9eaec)
                  ),
                  child: Center(
                    child: IconButton(icon: const Icon(Icons.add, color: Colors.purple,), iconSize: 33,
                        onPressed: ()
                        {
                          displayImageVideos();
                        }
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  width: 75,
                  child: Align(
                      child: Text(
                        'Add story',
                        overflow: TextOverflow.ellipsis,
                      )),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              FutureBuilder<List<dynamic>>(
                future: fetchUsersStories(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData && snapshot.data.length >= 1){
                    print((snapshot.data[0]));
                    return SizedBox(
                        height: 80,
                        width: 80,
                        child: ListView.builder(
                        //padding: const EdgeInsets.all(10),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(right: 0),
                        itemCount: snapshot.data.length,
                            //itemCount: snapshot.data[0].length,
                            //cnicCheck : snapshot.data[1],
                        itemBuilder: (BuildContext context, int index){
                          return
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.purple, width: 3)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      _storyImage(snapshot.data[index])),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                SizedBox(
                                  width: 75,
                                  child: Align(
                                      child: Text(
                                        _name(snapshot.data[index]),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                )
                              ],
                            );
                        }),);
                  }else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
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
                                  builder: (context) => MyProfile()));
                            },
                            child: const Icon(Icons.account_box,size: 30, color: Colors.grey,),
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
                        child: const Text('News Feed',style: TextStyle(color: Colors.black, fontSize: 20,
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
                                  builder: (context) => const BasicInfoProfilePicture(userId: '',)));
                            },
                            child: const Icon(Icons.notifications_none_sharp,size: 30, color: Colors.grey,),
                          )
                      ),
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
                    margin: const EdgeInsets.all(1),
                    padding: const EdgeInsets.all(1),
                  ),
                  Container(
                    width: 350,
                    height: 100,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        Row(
                          children: <Widget>[
                            stories(context),
                          ],
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(2),
                  ),
                  Container(
                    height: 40.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    child: Row(
                      children: <Widget>[
                         Flexible(
                            child:Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 200.0,
                                alignment:Alignment.centerLeft,
                                child: const Text('Live',style: TextStyle(color: Colors.black, fontSize: 20,
                                 fontWeight: FontWeight.bold,),),
                              ),
                            ),
                         ),
                        const SizedBox(
                          width: 50.0,
                        ),
                        Flexible(
                           child:Align(
                             alignment: Alignment.centerRight,
                             child: Container(
                               width: 100.0,
                               alignment:Alignment.centerRight,
                               child: Text.rich(
                                 TextSpan(text: 'See all', style: const TextStyle(color: Colors.red, fontSize: 16,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,),
                                    recognizer: TapGestureRecognizer()..onTap = (){
                                      //receiveNewFeedsData();
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => const PlayVideo()));
                                    }
                                 ),
                               ),
                             ),
                           ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    height: 70.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 300,
                              height: 70,
                              alignment: Alignment.centerLeft,
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      _story.liveUsers(context),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Flexible(
                           child:Align(
                             alignment: Alignment.centerRight,
                             child: Container(
                               width: 40.0,
                               height: 70,
                               alignment:Alignment.centerRight,
                               child: Text.rich(
                                  TextSpan(text: ':', style: const TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold,),
                                     recognizer: TapGestureRecognizer()..onTap = (){
                                    }
                                  ),
                               ),
                             ),
                           ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 200,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Container(
                        height: 200,
                        alignment:Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                              fit:BoxFit.fill,
                              image: AssetImage('assets/ImgNewsFeedOne.png'),)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(2),
                  ),
                  Container(
                    height: 40.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      children: <Widget>[
                         Flexible(
                            child:Align(
                            alignment: Alignment.centerLeft,
                              child: Container(
                                 width: 200.0,
                                 alignment:Alignment.centerLeft,
                                 child: const Text('Post',style: TextStyle(color: Colors.black, fontSize: 20,
                                 fontWeight: FontWeight.bold,),),
                              ),
                            ),
                         ),
                        const SizedBox(
                          width: 50.0,
                        ),
                        Flexible(
                           child:Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 100.0,
                                alignment:Alignment.centerRight,
                                child: Text.rich(
                                  TextSpan(text: 'See all', style: const TextStyle(color: Colors.red, fontSize: 16,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,),
                                     recognizer: TapGestureRecognizer()..onTap = (){
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => Posts(userId:widget.userId.toString(),))
                                      );
                                       print('User Id )${widget.userId.toString()}  Success');
                                     }
                                  ),
                                ),
                              ),
                            ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    height: 70.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                               width: 300,
                               height: 70,
                               alignment: Alignment.centerLeft,
                               child: ListView(
                                 scrollDirection: Axis.vertical,
                                 shrinkWrap: true,
                                 children: [
                                   Row(
                                     children: <Widget>[
                                       _story.usersPosts(context),
                                     ],
                                   ),
                                 ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Flexible(
                           child:Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                 width: 40.0,
                                 height: 70,
                                 alignment:Alignment.centerRight,
                                 child: Text.rich(
                                    TextSpan(text: ':', style: const TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold,),
                                        recognizer: TapGestureRecognizer()..onTap = (){
                                       }
                                    ),
                                 ),
                             ),
                           ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 200,
                    alignment:Alignment.center,
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                         child: Container(
                           height: 200,
                           alignment:Alignment.centerLeft,
                           decoration: BoxDecoration(
                             //color: Colors.grey,
                               borderRadius: BorderRadius.circular(8.0),
                               shape: BoxShape.rectangle,
                               image: const DecorationImage(
                                   fit:BoxFit.fill,
                                 image: AssetImage('assets/ImgNewsFeedOne.png'),)
                         ),
                     ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(3),
                  ),
                  Container(
                    width: 350.0,
                    height: 70,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: <Widget>[
                          SizedBox(
                            width: 50.0,
                            height: 70.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 25.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.home), iconSize: 25,color:Colors.grey,
                                        onPressed: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>  HomePage(userId: widget.userId.toString(),)));
                                        }
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 15.0,
                                    alignment:Alignment.center,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Home',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 30.0,
                          ),
                          SizedBox(
                            width: 50.0,
                            height: 70.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 25.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.feed), iconSize: 25,color:Colors.red,
                                        onPressed: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => NewsFeed(userId: widget.userId.toString(),)));
                                        }
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 15.0,
                                    alignment:Alignment.center,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Feed',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 30.0,
                          ),
                          SizedBox(
                            width: 50.0,
                            height: 70.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 25.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.event), iconSize: 25,color:Colors.grey,
                                        onPressed: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => HomePage(userId: '',)));
                                        }
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 15.0,
                                    alignment:Alignment.center,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Event',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 20.0,
                          ),
                          SizedBox(
                            width: 50.0,
                            height: 70.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 25.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.chat), iconSize: 25,color:Colors.grey,
                                        onPressed: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => Chat()));
                                        }
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 15.0,
                                    alignment:Alignment.center,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Chat',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 20.0,
                          ),
                          SizedBox(
                            width: 60.0,
                            height: 70.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 25.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.settings), iconSize: 25,color:Colors.grey,
                                        onPressed: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => Chat()));
                                        }
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 15.0,
                                    alignment:Alignment.center,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Settings',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child:Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 20.0,
                        width: 350.0,
                        alignment:Alignment.center,
                        child: const CheckConnectivity(),
                      ),
                    ),
                  ),
                  //throw UnimplementedError();
                ],
              ),
            )
        )
    );
  }

  buildCancelIcon(Color white, Null Function() param1, IconData cancel) {}
}