//Chat page implementation

import 'package:burnit_app/basicinfoprofilepicture.dart';
import 'package:burnit_app/myprofile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'homepage.dart';
import 'newsfeed.dart';
import 'stories.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Chat(),
    },
  ));
}

class Chat extends StatelessWidget {
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
                          child: const Text('Chat',style: TextStyle(color: Colors.black, fontSize: 20,
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
                                      builder: (context) => BasicInfoProfilePicture(userId: '',)));
                                },
                                child: Container(
                                  child: Icon(Icons.notifications_none_sharp ,size: 30, color: Colors.grey,),
                                ),
                              )
                          ),
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
            body: Center(
                child: MyCustomForm()
            )
        )
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State < MyCustomForm>{
  // we get the instance of the stories class just as we would create a new instance.
  final Stories _story = Stories();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(4),
          ),
          Container(
            width: 350,
            height: 50,
            margin: const EdgeInsets.only(top:5.0),
            alignment:Alignment.centerLeft,
            child: TextField(
              maxLines: 1,
              style: TextStyle(fontSize: 17),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                prefixIcon:
                Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                contentPadding: EdgeInsets.zero,
                hintText: 'Search something here',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          ),
          Container(
            width: 350.0,
            alignment:Alignment.centerLeft,
            child: const Text('Inbox',style: TextStyle(color: Colors.black, fontSize: 20,
              fontWeight: FontWeight.bold,),),
          ),
          Container(
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(3),
          ),
          Container(
            width: 350,
            height: 300,
            child: Container(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Row(
                    children: <Widget>[
                      _story.chat(context),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(25),
            padding: EdgeInsets.all(15),
          ),
          Container(
            margin: const EdgeInsets.only(top:2.0),
            height: 44.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 250.0,
                ),
                Container(
                  width: 30.0,
                ),
                Container(
                    height: 44.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(8.0),),
                      alignment:Alignment.center,
                  child: SizedBox(
                    width: 20,
                    height: 20,// specific value
                    child: RaisedButton(
                      elevation: 0,
                      textColor: Colors.purple,
                      color: Colors.white,
                      child: const Text('+' ,textAlign: TextAlign.right,style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),),
                      onPressed: () {
                        _story.chatOptions(context);
                      },
                    ),),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
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
                  child: new IconButton(icon: new Icon(Icons.feed), iconSize: 25,color:Colors.grey,
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
                  child: new IconButton(icon: new Icon(Icons.chat), iconSize: 25,color:Colors.red,
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
                      color: Colors.black54,
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
                      color: Colors.red,
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
          //throw UnimplementedError();
        ],
      ),
    );
  }
}