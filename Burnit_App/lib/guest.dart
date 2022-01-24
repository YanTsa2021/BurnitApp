//login as guest form implementation

import 'package:burnit_app/login.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        home: Scaffold(
          appBar: PreferredSize(
              child: Container(
                margin: const EdgeInsets.only(top:40.0),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                height: 45.0,
                width: 350.0,
                alignment:Alignment.centerLeft,
                        child: Container(
                          width: 35.0,
                          height: 35.0,
                          alignment:Alignment.centerLeft,
                          child: new RaisedButton(
                              textColor: Colors.black,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide( color: Colors.white,width: 0.5,)
                              ),
                              child: const Text('<',textAlign: TextAlign.center,style: TextStyle(
                                fontSize: 20.0,
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
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            alignment:Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/ImgBurnit.png'),
                    )),
          ),
          Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(1),
          ),
          Container(
            width: 350,
            alignment:Alignment.center,
            child: RichText(
              text: TextSpan(text: '   Welcome Guest',
                style: TextStyle(color: Colors.black, fontSize: 28,fontWeight: FontWeight.bold,),
                children: [
                  TextSpan(text: '    \nPlease login to your account\n        to continue with us', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),

                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
          ),
          Container(
              width: 350,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                child: TextFormField(
                  key: Key('shop_category_filter_input_text_field'),
                controller: _userProfile.email,
                autocorrect: true,
                decoration: InputDecoration(
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

          Container(
              width: 350,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                child: TextFormField(
                  key: Key('shop_category_filter_input_text_field'),
                obscureText: _userProfile.showPassword,
                controller: _userProfile.password,
                autocorrect: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  //suffixIcon: Icon(Icons.remove_red_eye),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(),
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
            margin: EdgeInsets.all(90),
            padding: EdgeInsets.all(80),
          ),
          Container(
            height: 44.0,
            width: 150.0,
            alignment:Alignment.center,
            child: SizedBox(
              height: 44.0,
              width: 350.0,// specific value
              child: RaisedButton(
                elevation: 0,
                textColor: Colors.white,
                color: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide( color: Colors.purple,width: 1,)
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
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          ),
          //throw UnimplementedError();
        ],
      ),
    );
  }
}