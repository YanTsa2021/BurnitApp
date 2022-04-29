//Change Password Setting page implementation

import 'dart:convert';

import 'package:burnit_app/otp.dart';
import 'package:burnit_app/settings.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_wrapper.dart';
import 'checkconnectivity.dart';
import 'dataconnectivity.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => PasswordSetting(),
    },
  ));
}

class PasswordSetting extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State <PasswordSetting>{
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  final _formKey = GlobalKey<FormState>();
  var key;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

  //Fonction to allow user to modify his password
  void sendDataNewPassword() async {
    final response = await http.post(Uri.parse('http://api.burnit.socecepme.com/api/auth/password-reset'), body: {
      "code": 'code',
      "email":  'mail',
      "password": _userProfile.password.text,
      "password_confirmation": _userProfile.ConfirmPassword.text,
    });

    _userProfile.apidata = response.body; //get JSON decoded data from response
    print(_userProfile.apidata); //printing the JSON recieved
    print(response.statusCode); //printing the statusCode recieved

    if(response.statusCode == 200){
      //fetch successful
      _userProfile.resp = jsonDecode( _userProfile.apidata)['message'];
      print(_userProfile.resp);
      Fluttertoast.showToast(msg: _userProfile.resp);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Login())
      );
    }
    if(response.statusCode == 400){
      //fetch error
      _userProfile.superheros_length = jsonDecode(_userProfile.apidata)['error']; //get all the data from json string
      print(_userProfile.superheros_length.length);

      for(var data in _userProfile.superheros_length.keys) {
        _userProfile.resp = jsonDecode( _userProfile.apidata)['error'][data];
      }

      //split string
      String finalResp = _userProfile.resp.reduce((value, element) {
        return value + element;
      });
      print(finalResp);
      Fluttertoast.showToast(msg: finalResp);
    }
    if(response.statusCode == 401 ){
      //fetch error
      _userProfile.resp = jsonDecode( _userProfile.apidata)['error']['email'];
      print(_userProfile.resp);
      Fluttertoast.showToast(msg: _userProfile.resp);
    }
    else {
      throw Exception('Failed to load data');
    }
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
                      child: Text('Change Password',style: TextStyle(color: Colors.black, fontSize: 20,
                        fontWeight: FontWeight.bold,),),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(3),
                  ),
                  SizedBox(
                    width: 350,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: TextFormField(
                        key: const Key('shop_category_filter_input_text_field'),
                        obscureText: _userProfile.showPassword,
                        controller: _userProfile.OldPassword,
                        autocorrect: true,
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                          hintText: 'Enter new password',
                          labelText: 'Enter new password',
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

                  SizedBox(
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: TextFormField(
                        key: const Key('shop_category_filter_input_text_field'),
                        obscureText: _userProfile.showPassword,
                        controller: _userProfile.ConfirmPassword,
                        autocorrect: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          //suffixIcon: Icon(Icons.remove_red_eye),
                          //contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: const OutlineInputBorder(),
                          hintText: 'Re-enter new password',
                          labelText: 'Re-enter new password',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.visibility_off),
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
                    margin: const EdgeInsets.all(110),
                    padding: const EdgeInsets.all(110),
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
                          child: const Text('Change Password',style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            textBaseline: TextBaseline.alphabetic,
                          ),),
                          onPressed: () {
                            // It returns true if the form is valid, otherwise returns false
                            if (_formKey.currentState!.validate()) {
                              _submit();
                            }
                          },
                        ),
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