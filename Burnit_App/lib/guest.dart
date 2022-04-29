//login as guest form implementation

import 'package:burnit_app/login.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'onboardingone.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Guest(),
    },
  ));
}

class Guest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
          Scaffold(
              appBar: PreferredSize(
                child: Container(
                  margin: const EdgeInsets.only(top:50.0),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  height: 50.0,
                  width: 350.0,
                  alignment:Alignment.centerLeft,
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    alignment:Alignment.centerLeft,
                    child: RaisedButton(
                        textColor: Colors.black,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide( color: Colors.white,width: 0.5,)
                        ),
                        child: const Text('<',textAlign: TextAlign.center,style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.normal,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        }
                    ),
                  ),
                ),
                preferredSize: const Size.fromHeight(500.0),
              ),
              resizeToAvoidBottomInset: false,// set it to false
              body: Center(
                  child: MyCustomForm()
              )
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
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final String respGuest = "guest";

  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return ListView(
          shrinkWrap: true,
          children: <Widget>[
          Container(
            width: 200,
            height: 200,
            alignment:Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/ImgBurnit.png'),
                    )),
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
              text: const TextSpan(text: 'Welcome Guest',
                style: TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold,),
                children: [
                  TextSpan(text: '\nPlease login to your account\nto continue with us', style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,),

                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
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
                  //contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: const OutlineInputBorder(),
                  hintText: 'Enter password',
                  labelText: 'Enter password',
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
            margin: const EdgeInsets.all(90),
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
                child: const Text('Login',style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  textBaseline: TextBaseline.alphabetic,
                ),),
                onPressed: () {
                  // It returns true if the form is valid, otherwise returns false
                  String pass = _userProfile.password.text ;
                  String mail = _userProfile.email.text;
                  if (_formKey.currentState!.validate()) {
                    //if(mail.toString() == respGuest.toString() && pass.toString() == respGuest.toString()){
                    if(mail.compareTo(respGuest) == 0 && pass.compareTo(respGuest) == 0 ){
                      //fetch successful
                      Fluttertoast.showToast(msg: "User successfully login");
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => OnboardingOne())
                      );
                    } else {
                      Fluttertoast.showToast(msg: "Invalid username or password");
                    }
                  }
                },
               ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
          ),
          //throw UnimplementedError();
        ],
        );
        },
      ),
    );
  }
}