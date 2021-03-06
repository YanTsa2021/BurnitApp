//Onboarding version one page implementation

import 'package:burnit_app/logo.dart';
import 'package:burnit_app/onboardingtwo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => OnboardingOne (),
    },
  ));
}

class OnboardingOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          Scaffold(
            resizeToAvoidBottomInset: false, // set it to false
            body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/ImgOngV1.png'),
                  ),
                ),
                child: MyCustomForm()
            ),
          ),
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))
      ),
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 40.0,
            width: 350.0,
            alignment:Alignment.center,
          ),//
          Container(
            margin: const EdgeInsets.all(150),
            padding: const EdgeInsets.all(100),
          ),
          Container(
            width: 350,
            alignment:Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: RichText(
                text: const TextSpan(text: '01 ',
                  style: TextStyle(color: Colors.black, fontSize: 26,fontWeight: FontWeight.bold,),
                  children: [
                    TextSpan(text: '/ 03', style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,),

                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 40.0,
            width: 350.0,
            alignment:Alignment.center,
          ),//
          Container(
            width: 350,
            alignment:Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Align (
                alignment:Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(text: 'Get Fit with us\n',
                    style: TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold,),
                    children: [
                      TextSpan(text: '\nLorem ipsum dolar sit amet, consectetur'
                          '\n adipiscing, elit,sed do elusrrod tempar''\n         incididunt ut labore et dolore',
                        style: TextStyle(color: Colors.black54, fontSize: 22,fontWeight: FontWeight.bold,),
                      )
                    ],
                  ), //textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(
            height: 100.0,
            width: 350.0,
            alignment:Alignment.center,
          ),//throw UnimplementedError();
          Container(
            height: 60.0,
            width: 350.0,
            alignment:Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Align (
                alignment:Alignment.centerRight,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 100.0,
                        alignment:Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(text: 'Skip', style: const TextStyle(color: Colors.black54, fontSize: 15, decoration: TextDecoration.underline,),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => LogoPage())
                                );
                              }
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 110.0,
                  ),
                  Flexible(
                    child:Align(
                      alignment: Alignment.centerRight,
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
                              textBaseline: TextBaseline.alphabetic,
                            ),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => OnboardingTwo()));
                            }
                        ),
                      ),
                    ),
                  ),
                ],
              ),
             ),
            ),
          ),
        ],
      ),
    );
  }
}