//New Feed page implementation

import 'dart:io';

import 'package:burnit_app/basicinfoprofilepicture.dart';
import 'package:burnit_app/myprofile.dart';
import 'package:burnit_app/posts.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
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

  //Fonction to get all news feed
  Future <void> receiveNewFeedsData() async {
    print('User Id )${_userProfile.coderesp.toString()}  Success');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
            appBar: PreferredSize(
              child: Container(
                margin: const EdgeInsets.only(top:40.0),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
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
                                  builder: (context) => MyProfile()));
                            },
                            child: Container(
                              child: Icon(Icons.account_box,size: 30, color: Colors.grey,),
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
                      child: const Text('News Feed',style: TextStyle(color: Colors.black, fontSize: 20,
                        fontWeight: FontWeight.bold,),),
                    ),
                    Container(
                      width: 25.0,
                    ),
                    Container(
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
                            child: Container(
                              child: Icon(Icons.notifications_none_sharp,size: 30, color: Colors.grey,),
                            ),
                          )
                      ),
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
                    margin: EdgeInsets.all(1),
                    padding: EdgeInsets.all(1),
                  ),
                  Container(
                    width: 350,
                    height: 100,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        Row(
                          children: <Widget>[
                            _story.stories(context),
                          ],
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.all(2),
                  ),
                  Container(
                    height: 40.0,
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          alignment:Alignment.centerLeft,
                          child: const Text('Live',style: TextStyle(color: Colors.black, fontSize: 20,
                            fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          width: 50.0,
                        ),
                        Container(
                            width: 100.0,
                            alignment:Alignment.centerRight,
                            child: Text.rich(
                              TextSpan(text: 'See all', style: TextStyle(color: Colors.red, fontSize: 16,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,),
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    receiveNewFeedsData();
                                  }
                              ),
                            )
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    height: 70.0,
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 0,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: [
                              Row(
                                children: <Widget>[
                                  _story.conversations(context),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 10.0,
                        ),
                        Container(
                            width: 40.0,
                            height: 0,
                            alignment:Alignment.centerRight,
                            child: Text.rich(
                              TextSpan(text: ':', style: TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold,),
                                  recognizer: TapGestureRecognizer()..onTap = (){

                                  }
                              ),
                            )
                        ),
                      ],
                    ),
                    ),
                  ),

                  Container(
                    width: 350,
                    height: 200,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Container(
                        height: 200,
                        alignment:Alignment.centerLeft,
                        decoration: BoxDecoration(
                          //color: Colors.grey,
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit:BoxFit.fill,
                              image: AssetImage('assets/ImgNewsFeedOne.png'),)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.all(2),
                  ),
                  Container(
                    height: 40.0,
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          alignment:Alignment.centerLeft,
                          child: const Text('Post',style: TextStyle(color: Colors.black, fontSize: 20,
                            fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          width: 50.0,
                        ),
                        Container(
                            width: 100.0,
                            alignment:Alignment.centerRight,
                            child: Text.rich(
                              TextSpan(text: 'See all', style: TextStyle(color: Colors.red, fontSize: 16,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,),
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => Posts(userId:widget.userId.toString(),))
                                    );
                                      print('User Id )${widget.userId.toString()}  Success');
                                  }
                              ),
                            )
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    height: 70.0,
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 70,
                          child: Container(
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: [
                                Row(
                                  children: <Widget>[
                                    _story.conversations(context),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 10.0,
                        ),
                        Container(
                            width: 40.0,
                            height: 10,
                            alignment:Alignment.centerRight,
                            child: Text.rich(
                              TextSpan(text: ':', style: TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold,),
                                  recognizer: TapGestureRecognizer()..onTap = (){

                                  }
                              ),
                            )
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 200,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                         child: Container(
                           height: 200,
                           alignment:Alignment.centerLeft,
                           decoration: BoxDecoration(
                             //color: Colors.grey,
                               borderRadius: BorderRadius.circular(8.0),
                               shape: BoxShape.rectangle,
                               image: DecorationImage(
                                   fit:BoxFit.fill,
                                 image: AssetImage('assets/ImgNewsFeedOne.png'),)
                         ),
                     ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    padding: EdgeInsets.all(3),
                  ),
                  Container(
                    width: 350.0,
                    height: 40,
                    alignment:Alignment.center,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          child: IconButton(icon: const Icon(Icons.home), iconSize: 25,color:Colors.grey,
                              onPressed: ()
                              {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HomePage(userId: '',)));
                              }
                          ),
                        ),
                        Container(
                          width: 30.0,
                        ),
                        Container(
                          width: 50.0,
                          child: new IconButton(icon: new Icon(Icons.feed), iconSize: 25,color:Colors.red,
                              onPressed: ()
                              {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => NewsFeed(userId: '',)));
                              }
                          ),
                        ),
                        Container(
                          width: 30.0,
                        ),
                        Container(
                          width: 50.0,
                          child: new IconButton(icon: new Icon(Icons.event), iconSize: 25,color:Colors.grey,
                              onPressed: ()
                              {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HomePage(userId: '',)));
                              }
                          ),
                        ),
                        Container(
                          width: 20.0,
                        ),
                        Container(
                          width: 50.0,
                          child: new IconButton(icon: new Icon(Icons.chat), iconSize: 25,color:Colors.grey,
                              onPressed: ()
                              {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Chat()));
                              }
                          ),
                        ),
                        Container(
                          width: 20.0,
                        ),
                        Container(
                          width: 30.0,
                          child: new IconButton(icon: new Icon(Icons.settings), iconSize: 25,color:Colors.grey,
                              onPressed: ()
                              {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HomePage(userId: '',)));
                              }
                          ),
                        ),
                        Container(
                          width: 20.0,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 25.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          child: GestureDetector(
                            child: new Text(
                              'Home',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 30.0,
                        ),
                        Container(
                          width: 50.0,
                          child: const Text(
                            'Feed',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 30.0,
                        ),
                        Container(
                          width: 50.0,
                          child: const Text(
                            'Event',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 20.0,
                        ),
                        Container(
                          width: 50.0,
                          child: const Text(
                            'Chat',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 10.0,
                        ),
                        Container(
                          width: 60.0,
                          child: const Text(
                            'Settings',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 10.0,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 20.0,
                    width: 350.0,
                    alignment:Alignment.centerRight,
                    child: CheckConnectivity(),
                  ),///th
                  //throw UnimplementedError();
                ],
              ),
            )
        )
    );
  }
}