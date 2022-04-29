//Login form implementation

import 'dart:io';

import 'package:burnit_app/onboardingthree.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_wrapper.dart';
import 'dataconnectivity.dart';
import 'guest.dart';
import 'register.dart';
import 'forgotpassword.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

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
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

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
                        text: const TextSpan(text: 'Welcome Back',
                          style: TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold,),
                          children: [
                            TextSpan(text: '\nPlease login to your account\nto continue with us', style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,),

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
                      width: 450,
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
                      width: 450,
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
                      height: 50.0,
                      width: 450.0,
                      alignment:Alignment.center,
                      child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child:Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                height: 50.0,
                                width: 220.0,// specific value
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
                                    //_handleSignIn();
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50.0,
                            width: 10.0,
                          ),
                          Flexible(
                            child:Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 50.0,
                                width: 220.0,// specific value
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
                        text: TextSpan(text: "D'ont have an account?",
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
                   Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 50.0,
                          width: 350.0,
                          alignment:Alignment.center,
                          //child: const CheckConnectivity(),
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