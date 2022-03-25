//Onboarding version three page implementation

import 'package:burnit_app/login.dart';
import 'package:burnit_app/onboardingtwo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => OnboardingThree(),
    },
  ));
}

class OnboardingThree extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State < OnboardingThree>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: PreferredSize(
            child: Container(
              margin: const EdgeInsets.only(top:40.0),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
              height: 45.0,
              width: 350.0,
              alignment:Alignment.centerLeft,
              child: Container(
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
                            builder: (context) => OnboardingTwo()));
                      },
                      child: const Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: Colors.black,),
                    )
                ),
              ),
            ),
            preferredSize: const Size.fromHeight(500.0),
          ),
          resizeToAvoidBottomInset: false, // set it to false
          extendBodyBehindAppBar: true,
          body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/ImgOngV3.png'),
                ),
              ),
             child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(156),
                  padding: const EdgeInsets.all(80),
                ),
                Container(
                  width: 350,
                  alignment:Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child: RichText(
                    text: const TextSpan(text: '01',
                      style: TextStyle(color: Colors.black, fontSize: 24,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text: '/03', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),

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
                  child: RichText(
                    text: const TextSpan(text: 'Get Fit with us',
                      style: TextStyle(color: Colors.black, fontSize: 26,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text: '\nLorem ipsum dolar sit amet, consectetur'
                            '\nadipiscing, elit,sed do elusrrod tempar''\nincididunt ut labore et dolore', style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,),
                        )
                      ],
                    ),
                  ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
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
                                child: const Text('Finish',style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    textBaseline: TextBaseline.alphabetic,),
                                ),
                                onPressed: () {
                                   Navigator.push(context, MaterialPageRoute(
                                   builder: (context) => Login()));
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
                 ],//throw U
              ),
          ),
        ),
    );
  }//throw UnimplementedError();
}