//StoryView page implementation

import 'package:burnit_app/pagestoryview.dart';
import 'package:burnit_app/stories.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import "package:story_view/story_view.dart";

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => StoryView (),
    },
  ));
}

class StoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home: Scaffold(
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
              child: MyCustomForm()
          ),
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
  // we get the instance of the stories class just as we would create a new instance.
  final Stories _story = Stories();
  // we get the instance of the StoryPageView class just as we would create a new instance.
  final StoryPageView _view = StoryPageView();
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
            margin: const EdgeInsets.only(top:2.0),
            height: 80.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 330,
                  height: 80,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1581803118522-7b72a50f7e9f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bWFufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                    ),
                    title: Text(
                      "Logan Veawer",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white ),
                    ),
                    subtitle: Text("Today, 20:16 PM",style: TextStyle(color:Colors.white.withOpacity(0.5)),),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoryPageView())),
                  ),
                ),
                Container(
                  width: 10.0,
                ),
                Container(
                    width: 10.0,
                    alignment:Alignment.center,
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
          Container(
            margin: EdgeInsets.all(180),
            padding: EdgeInsets.all(60),
          ),
        ],
      ),

    );
  }
}