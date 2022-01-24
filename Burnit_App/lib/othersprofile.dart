//Others profile implementation

import 'package:burnit_app/homepage.dart';
import 'package:burnit_app/myprofile.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'basicinfoprofilepicture.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) =>  OthersProfile(),
    },
  ));
}

class OthersProfile extends StatelessWidget {
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
                          child: const Text('Profile',style: TextStyle(color: Colors.black, fontSize: 20,
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
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.


  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

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
            width: 350,
            height: 150,
            alignment:Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/ImgBurnit.png'),
                    fit: BoxFit.cover)),

          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          ),
          Container(
            width: 350,
            margin: const EdgeInsets.only(top:10.0),
            alignment:Alignment.center,
            child: RichText(
              text: TextSpan(text: 'Jordyn Geidt (27)',
                style: TextStyle(color: Colors.black, fontSize: 26,fontWeight: FontWeight.bold,),
                children: [
                  TextSpan(text: '\n          +15481234789', style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,),

                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          ),
          Container(
            margin: const EdgeInsets.only(top:2.0),
            height: 60.0,
            width: 290.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 80.0,
                  alignment:Alignment.centerLeft,
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(top:5.0),
                    alignment:Alignment.center,
                    child: RichText(
                      text: TextSpan(text: '845',
                        style: TextStyle(color: Colors.black, fontSize: 24,fontWeight: FontWeight.bold,),
                        children: [
                          TextSpan(text: '\nPost', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 25.0,
                  child: VerticalDivider(
                    thickness: 2,
                    color: Color(0x11111111),
                  ),
                ),
                Container(
                  width: 80.0,
                  alignment:Alignment.center,
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(top:5.0),
                    alignment:Alignment.center,
                    child: RichText(
                      text: TextSpan(text: '25.8K',
                        style: TextStyle(color: Colors.black, fontSize: 24,fontWeight: FontWeight.bold,),
                        children: [
                          TextSpan(text: '\nFollowers', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),

                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 25.0,
                  child: VerticalDivider(
                    thickness: 2,
                    color: Color(0x11111111),
                  ),
                ),
                Container(
                  width: 80.0,
                  alignment:Alignment.centerRight,
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(top:5.0),
                    alignment:Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(text: '85',
                        style: TextStyle(color: Colors.black, fontSize: 24,fontWeight: FontWeight.bold,),
                        children: [
                          TextSpan(text: '\nFollowing', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),

                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(4),
          ),
          Container(
            margin: const EdgeInsets.only(top:0.0),
            height: 44.0,
            width: 350.0,
            alignment:Alignment.center,
            child: new ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 150.0,
                  alignment:Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8.0),),
                  child: new RaisedButton(
                      elevation: 0,
                      textColor: Colors.white,
                      color: Colors.purple,
                      child: const Text('Following',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      ),
                      onPressed: () {

                      }
                  ),
                ),
                Container(
                  width: 50.0,
                ),
                Container(
                  width: 150.0,
                  alignment:Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 1,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),

                  ),
                  child: new RaisedButton(
                      elevation: 0,
                      textColor: Colors.black,
                      color: Colors.white,
                      child: const Text('Message',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      ),
                      onPressed: () {

                      }
                  ),
                ),
              ],

            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
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
                  width: 150.0,
                  alignment:Alignment.centerLeft,
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.only(top:5.0),
                    alignment:Alignment.centerLeft,
                    child: RichText(
                        text: TextSpan(text: 'Birthday\n\nAddress\n\nHeight\n\nWeight', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,)
                        )
                    ),
                  ),
                ),
                Container(
                  width: 50.0,
                ),
                Container(
                  width: 150.0,
                  alignment:Alignment.centerRight,
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.only(top:5.0),
                    alignment:Alignment.centerRight,
                    child: RichText(
                        text: TextSpan(text: '21 Feb, 1995\n\nTexas, USA\n\n140cm\n\n185lbs', style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,)
                        )
                    ),
                  ),
                ),
              ],
            ),
          ), //throw UnimplementedError();
        ],
      ),
    );
  }
}