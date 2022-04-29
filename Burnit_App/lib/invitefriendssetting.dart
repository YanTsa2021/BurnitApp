//Invite Friend Setting page implementation

import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:share_plus/share_plus.dart';
import 'package:burnit_app/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dataconnectivity.dart';
import 'stories.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => InviteFriendsSetting(),
    },
  ));
}

class InviteFriendsSetting extends StatefulWidget {

  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State < InviteFriendsSetting>{
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
        //width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1.19,
        //height: 1000,
        child: Scaffold(
            appBar: AppBar(
              title: Row(children: [
                Expanded(
                  child:Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 40.0,
                      height: 40.0,
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
                                  builder: (context) => Settings(userId: '',)));
                            },
                            child: const Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: Colors.black,),
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
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                        child: Text('Invite Friends',style: TextStyle(color: Colors.black, fontSize: 20,
                         fontWeight: FontWeight.bold,),),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top:0.0),
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          alignment:Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                              width: 1,
                            ),
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            alignment:Alignment.center,
                            child: GestureDetector(
                                onTap: () {
                                  Share.share('Visit whatsapp at https://web.whatsapp.com/');
                                },
                                child: const ImageIcon(
                                  AssetImage('assets/whatsapp.png'),
                                  size: 30,
                                  color: Colors.white,
                                )
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
                            text: const TextSpan(text: 'Whatsapp',
                              style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                              children: [
                                TextSpan(text: '\nSend invitation link via Whatsapp', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),
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
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top:0.0),
                    height: 44.0,
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
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
                                Share.share('Hi, check out my email https://gmail.com');
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
                            text: const TextSpan(text: 'Email',
                              style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                              children: [
                                TextSpan(text: '\nSend invitation link via E-mail', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

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
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top:0.0),
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
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
                              onTap: () async {
                                Share.share('Hi, check out my phone number 00237678188387');
                              },
                              child: const Icon(Icons.phone,size: 30, color: Colors.white,),
                            ),
                          ),
                        ),
                        Container(
                          width: 10.0,
                        ),
                        Container(
                          width: 250.0,
                          alignment:Alignment.centerLeft,
                          child: RichText(
                            text: const TextSpan(text: 'Phone number',
                              style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                              children: [
                                TextSpan(text: '\nSend invitation link via phone number', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 20.0,
                        ),
                        Container(
                          width: 20.0,
                          alignment:Alignment.centerRight,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top:0.0),
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
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
                                Share.share('Hi, check out my blog https://flutterant.com');
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
                            text: TextSpan(text: 'Others',
                              style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                              children: [
                                TextSpan(text: '\nShare app via other way', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

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
                    margin: const EdgeInsets.all(110),
                    padding: const EdgeInsets.all(110),
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