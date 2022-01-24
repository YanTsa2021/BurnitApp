//Add Story Feed page implementation

import 'package:burnit_app/addpost.dart';
import 'package:burnit_app/pagestoryview.dart';
import 'package:burnit_app/stories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'addstory.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => AddStoryFeed (),
    },
  ));
}

class AddStoryFeed extends StatelessWidget {
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
                                    builder: (context) => AddStory()));
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
            margin: EdgeInsets.all(200),
            padding: EdgeInsets.all(145),
          ),
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(5),
            height: 44.0,
            width: 340.0,
            alignment:Alignment.center,
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(8.0),),
            child: new RaisedButton(
              elevation: 0,
              textColor: Colors.white,
              color: Colors.purple,
              child: const Text('Add Story to Feed',style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                textBaseline: TextBaseline.alphabetic,
              ),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AddPost(userId: '',)));
              },
            ),
          ),
        ],
      ),

    );
  }
}