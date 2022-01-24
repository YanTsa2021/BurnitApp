//Privacy Policy Setting page implementation

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
      '/': (context) => PrivacyPolicySetting (),
    },
  ));
}

class PrivacyPolicySetting extends StatelessWidget {
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
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          ),
          Container(
            width: 350.0,
            alignment:Alignment.centerLeft,
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
               child: const Text('Privacy Policy',style: TextStyle(color: Colors.black, fontSize: 20,
               fontWeight: FontWeight.bold,),),
            ),
          ),
          Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(2),
          ),
          Container(
            margin: const EdgeInsets.only(top:2.0),
            height: 40.0,
            width: 350.0,
            alignment:Alignment.center,
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 300.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                    child: const Text('Location Service',style: TextStyle(color: Colors.black, fontSize: 16,
                    fontWeight: FontWeight.bold,),),
                ),
                Container(
                  width: 10.0,
                ),
                Container(
                  width: 40.0,
                  height: 25,
                  alignment:Alignment.centerRight,
                  child: Container(
                    height: 25.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20.0),),
                    alignment:Alignment.centerRight,
                    child: SizedBox(
                      width: 20,
                      height: 20,// specific value
                      child: RaisedButton(
                        elevation: 0,
                        textColor: Colors.green,
                        color: Colors.white,
                        shape: CircleBorder(),
                        onPressed: () {
                          setState(() { //setState to refresh UI

                          });
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 50.0,
                ),
              ],
            ),
            ),
          ),
          Container(
            width: 350.0,
            alignment:Alignment.center,
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
               child: const Text('Location Services helps us to offer personalized '
                '\nrecommendation. Mobile GPS, Bluetooth and crowd sources '
                '\nWi-Fi hotspot and mobile phone locations to determine your approximate location.', style: TextStyle(color: Colors.black54, fontSize: 16,
              fontWeight: FontWeight.bold,),),
            ),
          ),
          Container(
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(3),
          ),
          Container(
            margin: const EdgeInsets.only(top:2.0),
            height: 40.0,
            width: 350.0,
            alignment:Alignment.center,
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 240.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  child: const Text('Connect Contacts',style: TextStyle(color: Colors.black, fontSize: 16,
                    fontWeight: FontWeight.bold,),),
                ),
                Container(
                  width: 70.0,
                ),
                Container(
                  width: 40.0,
                  height: 25,
                  alignment:Alignment.centerLeft,
                  child: Container(
                    height: 25.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.0),),
                    alignment:Alignment.centerLeft,
                    child: SizedBox(
                      width: 20,
                      height: 20,// specific value
                      child: RaisedButton(
                        elevation: 0,
                        textColor: Colors.grey,
                        color: Colors.white,
                        shape: CircleBorder(),
                        onPressed: () {
                          setState(() { //setState to refresh UI

                          });
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 50.0,
                ),
              ],
            ),
            ),
          ),
          Container(
            width: 350.0,
            alignment:Alignment.center,
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child: const Text('Lorem psum dolor sit amet, consectetur adipiscing elit, sed'
                'do eiusmod tempor incididunt ut labore et dolore.', style: TextStyle(color: Colors.black54, fontSize: 16,
              fontWeight: FontWeight.bold,),),
            ),
          ),
          Container(
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(3),
          ),
          Container(
            margin: const EdgeInsets.only(top:2.0),
            height: 40.0,
            width: 350.0,
            alignment:Alignment.center,
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 240.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(text: 'Enable Microphone',
                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text: '', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 70.0,
                ),
                Container(
                  width: 40.0,
                  height: 25,
                  alignment:Alignment.centerRight,
                  child: Container(
                    height: 25.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20.0),),
                    alignment:Alignment.centerRight,
                    child: SizedBox(
                      width: 20,
                      height: 20,// specific value
                      child: RaisedButton(
                        elevation: 0,
                        textColor: Colors.green,
                        color: Colors.white,
                        shape: CircleBorder(),
                        onPressed: () {
                          setState(() { //setState to refresh UI

                          });
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 50.0,
                ),
              ],
            ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(3),
          ),
          Container(
            margin: const EdgeInsets.only(top:2.0),
            width: 350.0,
            alignment:Alignment.center,
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child: RichText(
              text: TextSpan(text: 'Human Friendly Terms of Service',
                style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                children: [
                  TextSpan(text: '\n\nOur human-friendly Terms of Service for the Tribevibe'
                      '\nplatform prevails over the detailed one, which specifies all '
                      'rights abd obligations for both you and Tribevibe in more complex legalese.'
                      ' \n\nIn the event of a contradiction between the two documents,'
                      'the “human-friendly” Terms of Service shall prevail. That '
                      'means no nasty surprises if you read only the human-friendly versions. '
                      '\n\n\n\Last updated: 28 July, 2021', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

                  )
                ],
              ),
            ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
          ),
          //throw UnimplementedError();
        ],
      ),
    );
  }
}