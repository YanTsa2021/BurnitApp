//Onboarding version two page implementation

import 'package:burnit_app/onboardingone.dart';
import 'package:burnit_app/onboardingthree.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => OnboardingTwo(),
    },
  ));
}

class OnboardingTwo extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State <OnboardingTwo>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ResponsiveWrapper(
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: '4K'),
          ],
        child: SizedBox(
          width: 1000.0,
          //height: MediaQuery.of(context).size.height * 1.17,
          height: 1000.0,
        child: Scaffold(
          appBar: AppBar(
            title: Row(children: [
              Expanded(
                child:Align(
                  alignment: Alignment.centerLeft,
                  child:  Container(
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
                        height: 40.0,
                        alignment:Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => OnboardingOne()));
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
                    width: 235.0,
                    height: 40.0,
                    alignment:Alignment.center,
                  ),
                ),
              ),
              Expanded(
                child:Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      width: 45.0,
                      height: 40.0,
                      alignment:Alignment.centerRight,
                      //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      child: Text.rich(
                        TextSpan(text: 'Skip', style: const TextStyle(color: Colors.black54, fontSize: 15, decoration: TextDecoration.underline,),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => OnboardingThree())
                              );
                            }
                        ),
                      )
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
          extendBodyBehindAppBar: true,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage('assets/ImgOngV2.png'),
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(5),
                ),
                Container(
                  width: 350,
                  alignment:Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: RichText(
                      text: const TextSpan(text: '01 ',
                        style: TextStyle(color: Colors.black, fontSize: 26,fontWeight: FontWeight.bold,),
                        children: [
                          TextSpan(text: '/03', style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,),

                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                ),
                Container(
                  width: 350,
                  alignment:Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Align (
                      alignment:Alignment.centerLeft,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: const TextSpan(text: 'CHALLENGE''\nYOUR''\nBUDDY',
                          style: TextStyle(color: Colors.black, fontSize: 40,fontWeight: FontWeight.bold,),
                          children: [
                            TextSpan(text: '\nlets make America Fit''\nagain with your''\nfriends',
                              style: TextStyle(color: Colors.black54, fontSize: 22,fontWeight: FontWeight.bold,),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(110),
                  padding: const EdgeInsets.all(140),
                ),//throw UnimplementedError();
                Container(
                  height: 60.0,
                  width: 350.0,
                  alignment:Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 115.0,
                              height: 60.0,
                              alignment:Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(8.0),),
                              child: RaisedButton(
                                  elevation: 0,
                                  textColor: Colors.white,
                                  color: Colors.purple,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: const BorderSide( color: Colors.purple,width: 0.5,)
                                  ),
                                  child: const Text('Next',style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    textBaseline: TextBaseline.alphabetic,),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => OnboardingThree()));
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
                ), //throw UnimplementedError();
              ],
            ),
          ),
        ),
         ),
        ),
      );
   }
}