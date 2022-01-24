//Settings page implementation

import 'package:burnit_app/myprofile.dart';
import 'package:burnit_app/passwordsetting.dart';
import 'package:burnit_app/privacypolicysetting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'chat.dart';
import 'contactussetting.dart';
import 'createaccountsetting.dart';
import 'helpsetting.dart';
import 'homepage.dart';
import 'invitefriendssetting.dart';
import 'newsfeed.dart';
import 'notificationsetting.dart';
import 'stories.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Settings(),
    },
  ));
}

class Settings extends StatelessWidget {
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
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(4),
          ),
          Container(
            width: 350.0,
            alignment:Alignment.centerLeft,
            child: const Text('General Setting', textAlign: TextAlign.left,style: TextStyle(color: Colors.black, fontSize: 20,
              fontWeight: FontWeight.bold,),),
          ),
          Container(
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(3),
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
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => NotificationSetting()));
                      },
                      child: const Icon(Icons.notifications_none_sharp,size: 30, color: Colors.white,),
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
                    text: TextSpan(text: 'Notification Setting',
                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text: '\nChange your notification setting', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

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
                  child: new RaisedButton(
                      elevation: 0,
                      textColor: Colors.black,
                      color: Colors.white70,
                      child: const Text('>',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => NotificationSetting()));
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
            margin: const EdgeInsets.only(top:0.0),
            height: 44.0,
            width: 350.0,
            alignment:Alignment.center,
            child: new ListView(
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
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => PasswordSetting()));
                      },
                      child: const Icon(Icons.password,size: 30, color: Colors.white,),
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
                    text: TextSpan(text: 'Change Password',
                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text: '\nChange your account password', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

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
                  child: new RaisedButton(
                      elevation: 0,
                      textColor: Colors.black,
                      color: Colors.white70,
                      child: const Text('>',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      ),
                      onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => PasswordSetting()));
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
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => PrivacyPolicySetting()));
                      },
                      child: const Icon(Icons.privacy_tip_outlined,size: 30, color: Colors.white,),
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
                    text: TextSpan(text: 'Privacy Policy',
                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text: '\nView more about privacy policy', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

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
                  child: new RaisedButton(
                      elevation: 0,
                      textColor: Colors.black,
                      color: Colors.white70,
                      child: const Text('>',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => PrivacyPolicySetting()));
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
                      color: Colors.redAccent,
                      width: 1,
                    ),
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    alignment:Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ContactUsSetting()));
                      },
                      child: const Icon(Icons.headphones_outlined,size: 30, color: Colors.white,),
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
                    text: TextSpan(text: 'Contact Us',
                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text: '\nGet connected with us', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

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
                  child: new RaisedButton(
                      elevation: 0,
                      textColor: Colors.black,
                      color: Colors.white70,
                      child: const Text('>',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ContactUsSetting()));
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
                      color: Colors.purple,
                      width: 1,
                    ),
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    alignment:Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => HelpSetting()));
                      },
                      child: const Icon(Icons.help,size: 30, color: Colors.white,),
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
                    text: TextSpan(text: 'Help',
                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text: '\nCustomer care', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

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
                  child: new RaisedButton(
                      elevation: 0,
                      textColor: Colors.black,
                      color: Colors.white70,
                      child: const Text('>',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => HelpSetting()));
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
                      color: Colors.pinkAccent,
                      width: 1,
                    ),
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    alignment:Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => AccountSetting()));
                      },
                      child: const Icon(Icons.person,size: 30, color: Colors.white,),
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
                    text: TextSpan(text: 'Create Professional Account',
                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text: '\nChange new professional account', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

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
                  child: new RaisedButton(
                      elevation: 0,
                      textColor: Colors.black,
                      color: Colors.white70,
                      child: const Text('>',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => AccountSetting()));
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
                      color: Colors.lightBlueAccent,
                      width: 1,
                    ),
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    alignment:Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => InviteFriendsSetting()));
                      },
                      child: const Icon(Icons.share,size: 30, color: Colors.white,),
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
                    text: TextSpan(text: 'Invite Friends',
                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text: '\nShare this app with your friends', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

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
                  child: new RaisedButton(
                      elevation: 0,
                      textColor: Colors.black,
                      color: Colors.white70,
                      child: const Text('>',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => InviteFriendsSetting()));
                      }
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(25),
            padding: EdgeInsets.all(25),
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
                  child: new IconButton(icon: new Icon(Icons.settings), iconSize: 25,color:Colors.red,
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
                      color: Colors.red,
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