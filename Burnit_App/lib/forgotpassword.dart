//Forgot password form implementation

import 'package:burnit_app/userprofile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:burnit_app/login.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'checkconnectivity.dart';
import 'dataconnectivity.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => ForgotPassWord(),
      '/login': (context) => Login(),
    },
  ));
}

class ForgotPassWord extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class MyCustomFormState extends State <ForgotPassWord>{
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
            appBar: PreferredSize(
              child: Container(
                margin: const EdgeInsets.only(top:50.0),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                height: 50.0,
                width: 350.0,
                alignment:Alignment.centerLeft,
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
                              builder: (context) => Login()));
                        },
                        child: const Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: Colors.black,),
                      )
                  ),
                ),
              ),
              preferredSize: const Size.fromHeight(500.0),
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
                    width: 200,
                    height: 200,
                    alignment:Alignment.center,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/ImgBurnit.png'),)),
                  ),
                  Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(1),
                  ),
                  Container(
                    width: 350,
                    alignment:Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(text: 'Forgot Password',
                        style: TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold,),
                        children: [
                          TextSpan(text: '\nEnter your e-mail or phone number to\nsend a reset password link', style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,),

                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                  ),
                  SizedBox(
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: TextFormField(
                        key: const Key('shop_category_filter_input_text_field'),
                        controller: _userProfile.email,
                        autocorrect: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(),
                          hintText: 'E-mail/phone number',
                          labelText: 'E-mail/phone number',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid email or phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(110),
                    padding: const EdgeInsets.all(90),
                  ),
                  Container(
                    height: 50.0,
                    width: 450.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: SizedBox(
                      height: 50.0,
                      width: 450.0,// specific value
                      child: RaisedButton(
                        elevation: 0,
                        textColor: Colors.white,
                        color: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide( color: Colors.purple,width: 1,)
                        ),
                        child: const Text('Send code',style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          textBaseline: TextBaseline.alphabetic,
                        ),),
                        onPressed: () {
                          // It returns true if the form is valid, otherwise returns false
                          if (_formKey.currentState!.validate()) {
                            _userProfile.sendDataForgotPassword(context);
                          }
                        },
                      ),
                    ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(2),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 1),
                    alignment:Alignment.center,
                    child: RichText(
                      text: TextSpan(text: 'Already have an account?',
                        style: const TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold,),
                        children: <InlineSpan>[
                          TextSpan(text: ' login', style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Login())
                                );
                              }
                          )
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