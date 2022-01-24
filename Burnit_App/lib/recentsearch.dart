//Recent search implementation

import 'package:burnit_app/basicinfoprofilepicture.dart';
import 'package:burnit_app/editprofile.dart';
import 'package:burnit_app/search.dart';
import 'package:burnit_app/settings.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'chat.dart';
import 'homepage.dart';
import 'newsfeed.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => RecentSearch(),
    },
  ));
}

class RecentSearch extends StatelessWidget {
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
                                      builder: (context) => Search()));
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
                          child: const Text('Search',style: TextStyle(color: Colors.black, fontSize: 20,
                            fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          width: 60.0,
                        ),
                      ],
                    ),
                  ),
                  preferredSize: Size.fromHeight(kToolbarHeight)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              toolbarHeight: 1.2,
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
  final _formKey = GlobalKey<FormState>();
  static const IconData restaurant = IconData(0xe532, fontFamily: 'MaterialIcons');
  Color _iconColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(3),
          ),
          Container(
            width: 350,
            height: 36,
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
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(2),
          ),
          Container(
            margin: const EdgeInsets.only(top:2.0),
            height: 150.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 250.0,
                  alignment:Alignment.centerLeft,
                  child: Container(
                    width: 250,
                    margin: const EdgeInsets.only(top:5.0),
                    alignment:Alignment.centerLeft,
                    child: RichText(
                        text: TextSpan(text: '  Seared Tuna with Baby spinach\n\n  Corn and Avocado salad \n\n  Guacamole\n\n  Avocado Sandwich', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,)
                        )
                    ),
                  ),
                ),
                Container(
                  width: 50.0,
                ),
                Container(
                  width: 50.0,
                  alignment:Alignment.centerRight,
                  child: new ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: <Widget>[
                    Container(
                       height: 35,
                       child: new IconButton(icon: new Icon(Icons.arrow_forward_sharp ), iconSize: 27,color:Colors.black,
                          onPressed: ()
                          {
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Search()));
                          }
                       ),
                     ),
                      Container(
                        height: 35,
                        child: new IconButton(icon: new Icon(Icons.arrow_forward_sharp ), iconSize: 27,color:Colors.black,
                            onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Search()));
                            }
                        ),
                      ),
                      Container(
                        height: 35,
                        child: new IconButton(icon: new Icon(Icons.arrow_forward_sharp ), iconSize: 27,color:Colors.black,
                            onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Search()));
                            }
                        ),
                      ),
                      Container(
                        height: 35,
                        child: new IconButton(icon: new Icon(Icons.arrow_forward_sharp ), iconSize: 27,color:Colors.black,
                            onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Search()));
                            }
                        ),
                      ),
                   ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(100),
            padding: EdgeInsets.all(80),
          ),
          Container(
            width: 350.0,
            height: 50,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 50.0,
                  child: IconButton(icon: const Icon(Icons.home), iconSize: 25,color:Colors.red,
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
                  child: new IconButton(icon: new Icon(Icons.feed), iconSize: 30,color:Colors.grey,
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
                            builder: (context) => Settings()));
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
            height: 30.0,
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
                        color: Colors.red,
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
          //throw UnimplementedError();
        ],
      ),
    );
  }
}