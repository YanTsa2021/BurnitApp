//Reset password form implementation

import 'dart:convert';

import 'package:burnit_app/otp.dart';
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
  var key;
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => SetNewPassWord(otpCode: '', mail: '', key: key,),
    },
  ));
}

class SetNewPassWord extends StatefulWidget {
  final String otpCode;
  final String mail;
  const SetNewPassWord({required Key key, required this.otpCode, required this.mail}): super(key: key);

  @override
  MyCustomFormState createState() {
  return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State <SetNewPassWord>{
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
      "code": widget.otpCode,
      "email":  widget.mail,
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
                                      builder: (context) => SendOTP(mail: '', key: key, codeVariable: '',)));
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
                      text: const TextSpan(text: 'Set New Password',
                        style: TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold,),
                        children: [
                          TextSpan(text: '\nEnter your new password to\ncontinue with us', style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,),

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
                        child: const Text('Confirm',style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          textBaseline: TextBaseline.alphabetic,
                        ),),
                        onPressed: () {
                          // It returns true if the form is valid, otherwise returns false
                          if (_formKey.currentState!.validate()) {
                            print('Verification OTP Code )${widget.otpCode}  Success');
                            print('${widget.mail} mail was passed');
                            _submit();
                            sendDataNewPassword();
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