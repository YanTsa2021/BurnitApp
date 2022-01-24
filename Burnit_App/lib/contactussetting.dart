//Conctact Us Setting page implementation

import 'package:burnit_app/basicinfoprofilepicture.dart';
import 'package:burnit_app/myprofile.dart';
import 'package:burnit_app/settings.dart';
import 'package:burnit_app/userchatdetail.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'chat.dart';
import 'homepage.dart';
import 'newsfeed.dart';
import 'stories.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => ContactUsSetting(),
    },
  ));
}

class ContactUsSetting extends StatelessWidget {
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
                                      builder: (context) => Settings()));
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
                          child: const Text('Settings',style: TextStyle(color: Colors.black, fontSize: 20,
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
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          ),
          Container(
            width: 350.0,
            alignment:Alignment.centerLeft,
            child: const Text('Contact us',style: TextStyle(color: Colors.black, fontSize: 20,
              fontWeight: FontWeight.bold,),),
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          ),
          Container(
            margin: const EdgeInsets.only(top:0.0),
            height: 44.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 50.0,
                  alignment:Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 1,
                    ),
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    alignment:Alignment.center,
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: const Icon(Icons.email,size: 30, color: Colors.white,),
                    ),
                  ),
                ),
                Container(
                  width: 10.0,
                ),
                Container(
                  width: 220.0,
                  alignment:Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(text: 'E-mail',
                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text: '\ninfo@burnit', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 30.0,
                ),
                Container(
                  width: 40.0,
                  alignment:Alignment.centerRight,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          ),
          Container(
            margin: const EdgeInsets.only(top:0.0),
            height: 44.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 50.0,
                  alignment:Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orangeAccent,
                      width: 1,
                    ),
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    alignment:Alignment.center,
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: const Icon(Icons.phone,size: 30, color: Colors.white,),
                    ),
                  ),
                ),
                Container(
                  width: 10.0,
                ),
                Container(
                  width: 220.0,
                  alignment:Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(text: 'Phone',
                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text: '\n(123)456789012', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 30.0,
                ),
                Container(
                  width: 40.0,
                  alignment:Alignment.centerRight,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          ),
          Container(
            margin: const EdgeInsets.only(top:0.0),
            height: 44.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 50.0,
                  alignment:Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.greenAccent,
                      width: 1,
                    ),
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    alignment:Alignment.center,
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: const Icon(Icons.message,size: 30, color: Colors.white,),
                    ),
                  ),
                ),
                Container(
                  width: 10.0,
                ),
                Container(
                  width: 220.0,
                  alignment:Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(text: 'Message',
                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text: '\n(123)456789012', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 30.0,
                ),
                Container(
                  width: 40.0,
                  alignment:Alignment.centerRight,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(100),
            padding: EdgeInsets.all(90),
          ),
          //throw UnimplementedError();
        ],
      ),
    );
  }
}