//Login form implementation

import 'package:burnit_app/onboardingthree.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'checkconnectivity.dart';
import 'guest.dart';
import 'register.dart';
import 'forgotpassword.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/guest': (context) => Guest(),
      '/register': (context) => Register(),
      '/forgotpassword': (context) => ForgotPassWord(),
    },
  ));
}

class Login extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<Login> {
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
    final screenHeight = MediaQuery.of(context).size.height;
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
                                builder: (context) => OnboardingThree()));
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
              child: ListView(
                shrinkWrap: true,
                //prototypeItem: CheckConnectivity(),
                children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
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
                        text: const TextSpan(text: '   Welcome Back',
                          style: TextStyle(color: Colors.black, fontSize: 28,fontWeight: FontWeight.bold,),
                          children: [
                            TextSpan(text: '    \nPlease login to your account\n        to continue with us', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),

                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(7),
                      padding: const EdgeInsets.all(7),
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
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                            labelText: 'E-mail',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter valid email address';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 350,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                        child: TextFormField(
                          key: const Key('shop_category_filter_input_text_field'),
                          obscureText: _userProfile.showPassword,
                          controller: _userProfile.password,
                          autocorrect: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            //suffixIcon: Icon(Icons.remove_red_eye),
                            //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: const OutlineInputBorder(),
                            hintText: 'Password',
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(_userProfile.showPassword ? Icons.visibility : Icons.visibility_off),
                              onPressed: () => setState(() => _userProfile.showPassword = !_userProfile.showPassword),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter valid password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Container(
                        width: 350,
                        alignment:Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                        child: Text.rich(
                          TextSpan(text: 'Forgot Password?', style: const TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ForgotPassWord())
                                );
                              }
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(7),
                      padding: const EdgeInsets.all(7),
                    ),
                    Container(
                      height: 44.0,
                      width: 350.0,
                      alignment:Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child: SizedBox(
                        height: 44.0,
                        width: 350.0,// specific value
                        child: RaisedButton(
                          elevation: 0,
                          textColor: Colors.white,
                          color: Colors.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide( color: Colors.purple,width: 1,)
                          ),
                          child: const Text('Login',style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            textBaseline: TextBaseline.alphabetic,
                          ),),
                          onPressed: () {
                              // It returns true if the form is valid, otherwise returns false
                              if (_formKey.currentState!.validate()) {
                                _userProfile.sendDataLogin(context);
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
                        text: TextSpan(text: 'Continue as',
                          style: const TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),
                          children:[
                            TextSpan(text: ' Guest', style: const TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Guest())
                                  );
                                }
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top:60.0),
                      height: 20,
                      width: 350.0,
                      alignment:Alignment.center,
                      child: const Text('or',
                        style: TextStyle(color: Colors.black54, fontSize: 14.0),
                      ),
                    ),
                    Container(
                      height: 44.0,
                      width: 350.0,
                      alignment:Alignment.center,
                      child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child:Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                height: 44.0,
                                width: 170.0,// specific value
                                child: RaisedButton(
                                  elevation: 0,
                                  textColor: Colors.white,
                                  color: Colors.redAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: const BorderSide(  color: Colors.redAccent,width: 1,)
                                  ),
                                  child: const Text('Google',style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    textBaseline: TextBaseline.alphabetic,
                                  ),),
                                  onPressed: () {
                                    // _userProfile.launchURL("http://www.google.com");
                                    _userProfile.handleSignIn(context);
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 44.0,
                            width: 10.0,
                          ),
                          Flexible(
                            child:Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 44.0,
                                width: 170.0,// specific value
                                child: RaisedButton(
                                    elevation: 0,
                                    textColor: Colors.white,
                                    color: Colors.indigo,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        side: const BorderSide(color: Colors.indigo,width: 1,)
                                    ),
                                    child: const Text('Facebook',style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      textBaseline: TextBaseline.alphabetic,
                                    ),),
                                    onPressed: () {
                                      //_userProfile.launchURL("http://www.facebook.com");
                                      _userProfile.initiateFacebookLogin(context);
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
                      margin: const EdgeInsets.only(top:12.0),
                      alignment:Alignment.center,
                      child: RichText(
                        text: TextSpan(text: 'Dont have an account?',
                          style: const TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),
                          children: [
                            TextSpan(text: ' Register', style: const TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Register())
                                  );
                                }
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child:Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 20.0,
                          width: 350.0,
                          alignment:Alignment.center,
                          child: const CheckConnectivity(),
                        ),
                      ),
                    ),///throw UnimplementedError();
                  ],
                ),
            ),
          //bottomNavigationBar: CheckConnectivity(),
        ),
      );
  }
}