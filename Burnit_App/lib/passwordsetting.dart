//Change Password Setting page implementation

import 'package:burnit_app/basicinfoprofilepicture.dart';
import 'package:burnit_app/myprofile.dart';
import 'package:burnit_app/settings.dart';
import 'package:burnit_app/userchatdetail.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'chat.dart';
import 'homepage.dart';
import 'newsfeed.dart';
import 'stories.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => PasswordSetting(),
    },
  ));
}

class PasswordSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                  child: Container(
                    margin: const EdgeInsets.only(top:2.0),
                    height: 35.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
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
                                      builder: (context) => Settings()));
                                },
                                child: Container(
                                  child: Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: Colors.black,),
                                ),
                              )
                          ),
                        ),
                        Container(
                          width: 20.0,
                        ),
                        Container(
                          width: 230.0,
                          alignment:Alignment.center,
                          child: const Text('Settings',style: TextStyle(color: Colors.black, fontSize: 20,
                            fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          width: 60.0,
                        ),
                      ],
                    ),
                  ),
                  preferredSize: Size.fromHeight(kToolbarHeight)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              toolbarHeight: 0.2,
            ),
            resizeToAvoidBottomInset: false, // set it to false
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
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          ),
          Container(
            width: 350.0,
            alignment:Alignment.centerLeft,
            child: Padding(
               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
               child: const Text('Change Password',style: TextStyle(color: Colors.black, fontSize: 20,
               fontWeight: FontWeight.bold,),),
              ),
          ),
           Container(
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(3),
          ),
          Container(
              width: 350,
              alignment:Alignment.centerLeft,
              child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              child: TextFormField(
                obscureText: _userProfile.showPassword,
                controller: _userProfile.OldPassword,
                autocorrect: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(),
                  hintText: 'Enter old password',
                  labelText: 'Enter old password',

                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid old password';
                  }
                  return null;
                },
              ),
              ),
          ),
          Container(
              width: 350,
              child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              child: TextFormField(
                obscureText: _userProfile.showPassword,
                controller: _userProfile.password,
                autocorrect: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(),
                  hintText: 'Enter new password',
                  labelText: 'Enter new password',
                  suffixIcon: IconButton(
                    icon: Icon(_userProfile.showPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _userProfile.showPassword = !_userProfile.showPassword),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid new password';
                  }
                  return null;
                },
              ),
              ),
          ),
          Container(
              width: 350,
              child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              child: TextFormField(
                obscureText: _userProfile.showPassword,
                controller: _userProfile.ConfirmPassword,
                autocorrect: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(),
                  hintText: 'Re-enter new password',
                  labelText: 'Re-enter new password',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility_off),
                    onPressed: () => setState(() => _userProfile.showConfirmPassword = !_userProfile.showConfirmPassword),
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
            margin: EdgeInsets.all(100),
            padding: EdgeInsets.all(60),
          ),
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(5),
            height: 44.0,
            width: 350.0,
            alignment:Alignment.center,
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(8.0),),
            child: new RaisedButton(
              elevation: 0,
              //padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              textColor: Colors.white,
              color: Colors.purple,
              child: const Text('Change Password',style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                textBaseline: TextBaseline.alphabetic,
              ),),
              onPressed: () {
                // It returns true if the form is valid, otherwise returns false
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Data is in processing.')));
                  //_userProfile.submittable() ? _submit : null;
                  _submit() ;
                }
              },
            ),
          ),
          //throw UnimplementedError();
        ],
      ),
    );
  }
}