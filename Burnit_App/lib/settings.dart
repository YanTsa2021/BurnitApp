//Settings page implementation

import 'package:burnit_app/checkconnectivity.dart';
import 'package:burnit_app/myprofile.dart';
import 'package:burnit_app/passwordsetting.dart';
import 'package:burnit_app/privacypolicysetting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'chat.dart';
import 'contactussetting.dart';
import 'createaccountsetting.dart';
import 'dataconnectivity.dart';
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
      '/': (context) => Settings(userId: '',),
    },
  ));
}

class Settings extends StatefulWidget {
  final String userId;
  const Settings({key, required this.userId});

  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State < Settings> {
  // we get the instance of the stories class just as we would create a new instance.
  final Stories _story = Stories();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ResponsiveWrapper(
           maxWidth: 1200,
           minWidth: 680,
           defaultScale: true,
           breakpoints: [
             ResponsiveBreakpoint.resize(480, name: MOBILE),
             ResponsiveBreakpoint.autoScale(800, name: TABLET),
             ResponsiveBreakpoint.resize(1000, name: DESKTOP),
             ResponsiveBreakpoint.autoScale(2460, name: '4K'),
          ],
          child:SizedBox(
            width: 1000.0,
            height: MediaQuery.of(context).size.height * 1.17,
           child: Scaffold(
            appBar: AppBar(
              title: Row(children: [
                Expanded(
                  child:Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 40.0,
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
                          width: 40.0,
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
                  ),
                ),
                Expanded(
                  child:Align(
                    alignment: Alignment.center,
                    child:Container(
                        width: 230.0,
                        alignment:Alignment.center,
                        child: const Text('Settings',style: TextStyle(color: Colors.black, fontSize: 20,
                          fontWeight: FontWeight.bold,),)
                    ),
                  ),
                ),
                Expanded(
                  child:Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 40.0,
                      alignment:Alignment.centerRight,
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
                child: OrientationBuilder(
                builder: (BuildContext context, Orientation orientation) {
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                  Container(
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                        child: Text('General Setting', textAlign: TextAlign.left,style: TextStyle(color: Colors.black, fontSize: 20,
                        fontWeight: FontWeight.bold,),),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(3),
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                   width: 50.0,
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
                              width: 255.0,
                              alignment:Alignment.center,
                              child: RichText(
                                text: TextSpan(text: 'Notification Setting',
                                style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                                children: [
                                  TextSpan(text: '\nChange your notification setting', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),
                                )
                               ],
                             ),
                            ),
                        ),
                        Expanded(
                          child:Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                            width: 40.0,
                            alignment:Alignment.centerRight,
                            child: RaisedButton(
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
                          ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child: Row(
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
                              width: 255.0,
                              alignment:Alignment.center,
                              child: RichText(
                                text: const TextSpan(text: 'Change Password',
                                style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                                children: [
                                TextSpan(text: '\nChange your account password', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),
                                )
                              ],
                              ),
                             ),
                        ),
                        Flexible(
                           child:Align(
                           alignment: Alignment.centerRight,
                           child: Container(
                             width: 40.0,
                             alignment:Alignment.centerRight,
                             child: RaisedButton(
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
                           ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child: Row(
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
                              width: 255.0,
                              alignment:Alignment.center,
                              child: RichText(
                                text: TextSpan(text: 'Privacy Policy',
                                style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                                  children: [
                                   TextSpan(text: '\nView more about privacy policy', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),
                                  )
                                ],
                               ),
                              ),
                        ),
                        Flexible(
                           child:Align(
                           alignment: Alignment.centerRight,
                            child: Container(
                              width: 40.0,
                              alignment:Alignment.centerRight,
                              child: RaisedButton(
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
                           ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child: Row(
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
                              width: 230.0,
                              alignment:Alignment.center,
                              child:Container(
                                width: 200.0,
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(text: 'Contact Us',
                                  style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                                    children: [
                                      TextSpan(text: '\nGet connected with us', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),
                                      )
                                    ],
                                 ),
                                ),
                              ),
                        ),
                        Flexible(
                           child:Align(
                           alignment: Alignment.centerRight,
                           child: Container(
                             width: 40.0,
                             alignment:Alignment.centerRight,
                             child: RaisedButton(
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
                          ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child: Row(
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
                               width: 230.0,
                               alignment:Alignment.center,
                               child:Container(
                                 width: 200.0,
                                 alignment: Alignment.centerLeft,
                                 child: RichText(
                                    text: TextSpan(text: 'Help',
                                    style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                                      children: [
                                         TextSpan(text: '\nCustomer care', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),
                                         )
                                      ],
                                    ),
                                 ),
                               ),
                        ),
                        Flexible(
                           child:Align(
                             alignment: Alignment.centerRight,
                             child: Container(
                              width: 40.0,
                              alignment:Alignment.centerRight,
                              child: RaisedButton(
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
                           ),
                        ),
                      ],
                     ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child: Row(
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
                                width: 270.0,
                                alignment:Alignment.center,
                                child: RichText(
                                  text: const TextSpan(text: 'Create Professional Account',
                                  style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                                  children: [
                                    TextSpan(text: '\nChange new professional account', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),
                                    )
                                 ],
                                 ),
                                ),
                        ),
                        Flexible(
                           child:Align(
                             alignment: Alignment.centerRight,
                             child: Container(
                               width: 40.0,
                               alignment:Alignment.centerRight,
                               child: RaisedButton(
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
                          ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child: Row(
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
                             width: 255.0,
                             height: 50.0,
                             alignment:Alignment.center,
                             child: RichText(
                               text: const TextSpan(text: 'Invite Friends',
                                style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                                 children: [
                                   TextSpan(text: '\nShare this app with your friends', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),
                                  )
                                ],
                              ),
                             ),
                        ),

                        Flexible(
                          child:Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 40.0,
                              alignment:Alignment.centerRight,
                              child: RaisedButton(
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
                          ),
                        ),
                      ],
                     ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(59),
                    padding: const EdgeInsets.all(59),
                  ),
                  Container(
                    width: 350.0,
                    height: 80,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 60.0,
                            height: 80.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 30.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.home), iconSize: 30,color:Colors.grey,
                                        onPressed: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => const HomePage(userId: '',)));
                                        }
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 20.0,
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
                                      fontSize: 15,
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
                            width: 60.0,
                            height: 80.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 30.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.feed), iconSize: 30,color:Colors.grey,
                                        onPressed: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => NewsFeed(userId:widget.userId.toString(),)));
                                          print('User Id )${widget.userId.toString()}  Success');
                                        }
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 20.0,
                                    alignment:Alignment.center,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Feed',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
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
                            width: 60.0,
                            height: 80.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 30.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.event), iconSize: 30,color:Colors.grey,
                                        onPressed: null //()
                                        //{
                                          //Navigator.push(context, MaterialPageRoute(
                                              //builder: (context) => HomePage(userId: '',)));
                                       // }
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 20.0,
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
                                      fontSize: 15,
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
                            width: 60.0,
                            height: 80.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 30.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.chat), iconSize: 30,color:Colors.grey,
                                        onPressed: null //()
                                        /*{
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => Chat()));
                                        }*/
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 20.0,
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
                                      fontSize: 15,
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
                            width: 60.0,
                            height: 80.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 30.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.settings), iconSize: 30,color:Colors.red,
                                        onPressed: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => Settings(userId:widget.userId.toString(),)));
                                        }
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 20.0,
                                    alignment:Alignment.center,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Settings',
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
                            width: 0.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 20.0,
                      width: 350.0,
                      alignment:Alignment.center,
                      child:  DataConnectivity(),
                    ),
                  ),
                  ],
                );
                }
                ),
            ),
           ),
          ),
        ),
    );
  }
}