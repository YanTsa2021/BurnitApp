//Getters and Setters implementation

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'dart:async';//For StreamController/Stream
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'basicinfoheightweight.dart';
import 'homepage.dart';
import 'otp.dart';




class UserProfile {

  //Fields or attributes
  int iconCode = 60996;
  final name = TextEditingController();
  final email = TextEditingController();
  final code = TextEditingController();
  final phone = TextEditingController();
  final dob = TextEditingController();
  final password = TextEditingController();
  final OldPassword = TextEditingController();
  final ConfirmPassword = TextEditingController();
  final emailphonenumber = TextEditingController();
  final height = TextEditingController();
  final weight = TextEditingController();
  final desiredweight = TextEditingController();
  final specificGoal = TextEditingController();
  final measuredGoal = TextEditingController();
  final achievableGoal = TextEditingController();
  final relevantGoal = TextEditingController();
  final timesGoal = TextEditingController();
  final goal = TextEditingController();
  final country = TextEditingController();
  final zipcode = TextEditingController();
  final profile = TextEditingController();
  final heading = TextEditingController();
  final description = TextEditingController();
  final tog = TextEditingController();
  final List <String> fitnessGoals = <String> [];


  bool showPassword = true;
  bool showConfirmPassword = true;
  bool agreedToTOS = false;
  bool showHeight = true;
  bool showWeight = true;
  bool showDesiredGoal = true;
  bool showDesiredWeight = true;
  bool showCountry = true;
  bool showZipcode = true;
  bool showProfile = true;
  bool isLoggedIn = false;


  var profileData;
  var apidata; //for decoded JSON data
  var resp = null; //for response message
  var key;
  var coderesp = null; //for response message
  var superheros_length; //for data featching status
  String _otpCode = "";
  String _email = "";

  //Getters implementation
  String get otpCode => _otpCode;
  String get emailAdd => _email;

  bool submittable() {
    return agreedToTOS;
  }

  //setters implementation
  set otpCode (String value) => _otpCode = value;
  set emailAdd (String value) => _email = value;

  void setAgreedToTOS(bool newValue) {
    //setState(() {
      agreedToTOS = newValue;
    //});
  }

  //Methods or functions implementation
  getValues(){
    print(name.text);
    print(email.text);
    print(phone.text);
    print(password.text);
    print(OldPassword.text);
    print(dob.text);
    print(ConfirmPassword.text);
    print(emailphonenumber.text);
    print(height.text);
    print(weight.text);
    print(goal.text);
    print(desiredweight.text);
    print(profile.text);
    print(heading.text);
    print(description.text);
    print(tog.text);
    print(specificGoal.text);
    print(measuredGoal.text);
    print(achievableGoal.text);
    print(relevantGoal.text);
    print(timesGoal.text);
  }

  void addItemToList(){
    fitnessGoals.insert(1,specificGoal.text);
    fitnessGoals.insert(2,measuredGoal.text);
    fitnessGoals.insert(3,achievableGoal.text);
    fitnessGoals.insert(4,relevantGoal.text);
    fitnessGoals.insert(5,timesGoal.text);

  }

  displayDialog(BuildContext context, TextEditingController controller) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('What is your Fitness Goal'),
            content: TextFormField(
              controller: controller,
              textInputAction: TextInputAction.go,
              //keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Enter your goal"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Submit'),
                onPressed: () async {
                  //addItemToList();
                  Navigator.of(context).pop();
                   print(fitnessGoals);
                },
              )
            ],
          );
        });
   }
  //Fonction to add user information
  Future  sendDataRegister(BuildContext context) async {
    final response = await http.post( Uri.parse('http://api.burnit.socecepme.com/api/auth/register'), body: {
      "name": name.text,
      "email": email.text,
      "phone": phone.text,
      "dob": dob.text,
      "password": password.text,
      "password_confirmation": ConfirmPassword.text,
    });
    //developer.log(response.body);
   // Scaffold.of(context)
       // .showSnackBar(SnackBar(content: Text(response.statusCode.toString(),style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold,))));

    apidata = response.body; //get JSON decoded data from response

    print(apidata); //printing the JSON recieved
    print(response.statusCode); //printing the statusCode recieved

    if(response.statusCode == 201){
      //fetch successful
      Map<String, dynamic> responseJSON = jsonDecode(apidata);
      int id = jsonDecode( apidata)['user']['id'];
      print(id);
      print(responseJSON['message']);
      Fluttertoast.showToast(
        msg: responseJSON['message']);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => BasicInfoHeightWeight(userId: id,))
      );
    }
    if(response.statusCode == 400){
      //fetch error
      superheros_length = jsonDecode(apidata)['error']; //get all the data from json string
      print(superheros_length.length);

      for(var data in superheros_length.keys) {
        resp = jsonDecode( apidata)['error'][data];
      }

      //split string
      String finalResp = resp.reduce((value, element) {
        return value + element;
      });
      print(finalResp);
      Fluttertoast.showToast(msg: finalResp);
    }
   else {
      throw Exception('Failed to load data');
    }
  }

  //Fonction to verifier user login credentials
  Future  sendDataLogin(BuildContext context) async {
    final response = await http.post( Uri.parse('http://api.burnit.socecepme.com/api/auth/login'), body: {
      "email": email.text,
      "password": password.text,
    });

    apidata = response.body; //get JSON decoded data from response

    print(apidata); //printing the JSON recieved
    print(response.statusCode); //printing the statusCode recieved

    if(response.statusCode == 200){
      //fetch successful
      Map<String, dynamic> responseJSON = jsonDecode(apidata);
      int id = jsonDecode( apidata)['user']['id'];
      print(id);
      print(responseJSON['message']);
      Fluttertoast.showToast(
          msg: responseJSON['message']);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomePage(userId: id.toString(),))
      );
    }
    if(response.statusCode == 400){
      //fetch error
      resp = jsonDecode(apidata)['error']; //get all the data from json string
      print(resp);
      Fluttertoast.showToast(msg: resp);
    }
    else {
      throw Exception('Failed to load data');
    }
  }

  //Fonction to verifier user which has forgotten his password
  Future  sendDataForgotPassword(BuildContext context) async {
    final response = await http.post( Uri.parse('http://api.burnit.socecepme.com/api/auth/recover'), body: {
      "email": email.text,
    });

    apidata = response.body; //get JSON decoded data from response
    _email = email.text;
    print(_email.toString());
    print(apidata); //printing the JSON recieved
    print(response.statusCode); //printing the statusCode recieved

    if(response.statusCode == 200){
      //fetch successful
      resp = jsonDecode( apidata)['data']['message'];
      coderesp = jsonDecode( apidata)['data']['user']['code'];
      print(resp);
      print(coderesp.toString());
      Fluttertoast.showToast(msg: resp);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => SendOTP(mail: email.text,codeVariable:coderesp.toString(), key: key,))
      );
    }
    if(response.statusCode == 400){
      //fetch error
      superheros_length = jsonDecode(apidata)['error']; //get all the data from json string
      print(superheros_length.length);

      for(var data in superheros_length.keys) {
        resp = jsonDecode( apidata)['error'][data];
      }

      //split string
      String finalResp = resp.reduce((value, element) {
        return value + element;
      });
      print(finalResp);
      Fluttertoast.showToast(msg: finalResp);
    }
    if(response.statusCode == 401 ){
      //fetch error
        resp = jsonDecode( apidata)['error']['email'];
      print(resp);
      Fluttertoast.showToast(msg: resp);
    }
    else {
      throw Exception('Failed to load data');
    }
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  //Fonction to verifier user login credentials with google
  Future <void> handleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
      Fluttertoast.showToast(msg: "User successfully login");
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomePage(userId: '',))
      );
    } catch (error) {
      print(error);
      Fluttertoast.showToast(msg: "Invalid username or password");
    }
  }

  Future<void> handleSignOut() => _googleSignIn.disconnect();


  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    //setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
   // });
  }

  //Fonction to verifier user login credentials with facebook
  void initiateFacebookLogin(BuildContext context) async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
    await facebookLogin.logIn(['email']);
    //await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        Fluttertoast.showToast(msg: "Invalid username or password");
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");

        var token = facebookLoginResult.accessToken.token;

        var graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}'),
          headers: {HttpHeaders.contentTypeHeader: "application/json"},);

        var profile = jsonDecode(graphResponse.body);

        onLoginStatusChanged(true,profileData: profile);
        //onLoginStatusChanged(true);

        print('My profile teste=${profile.toString()}');
        Fluttertoast.showToast(msg: "User successfully login");
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const HomePage(userId: '',))
        );
        break;
    }
  }

  launchURL(String url) async {
    await launch(url);
  }
}