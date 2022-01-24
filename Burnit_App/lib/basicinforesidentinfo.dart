//Basic information resident information implementation

import 'dart:convert';

import 'package:burnit_app/basicinfofitnessgoal.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'basicinfoprofilepicture.dart';
import 'checkconnectivity.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const BasicInfoResidentInfo(userId: '',),
    },
  ));
}

class BasicInfoResidentInfo extends StatefulWidget {
  final String userId;
  const BasicInfoResidentInfo({key, required this.userId});
  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State < BasicInfoResidentInfo>{
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

  //Fonction to add users basic resident information
  void sendDataUserResidentInfo() async {
    print(widget.userId.toString());
    final response = await http.put(Uri.parse('http://api.burnit.socecepme.com/api/user-information/step3/'+widget.userId.toString()), body: {
      "user_id":  widget.userId.toString(),
      "country": _userProfile.country.text,
      "zipcode": _userProfile.zipcode.text,
    });

    _userProfile.apidata = response.body; //get JSON decoded data from response
    print(_userProfile.apidata); //printing the JSON recieved
    print(response.statusCode); //printing the statusCode recieved

    if(response.statusCode == 200){
      //fetch successful
      _userProfile.resp = jsonDecode( _userProfile.apidata)['status'];
      print(_userProfile.resp);
      Fluttertoast.showToast(msg: _userProfile.resp);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => BasicInfoProfilePicture(userId: widget.userId.toString(),))
      );
    }
    if(response.statusCode == 400){
      //fetch error
      _userProfile.resp = jsonDecode( _userProfile.apidata)['0']['user_id'];

      //split string
      String finalResp = _userProfile.resp.reduce((value, element) {
        return value + element;
      });
      print(finalResp);
      Fluttertoast.showToast(msg: finalResp);
    }
    else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
            appBar: PreferredSize(
              child: Container(
                  margin: const EdgeInsets.only(top:40.0),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  height: 45.0,
                  width: 350.0,
                  alignment:Alignment.centerLeft,
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
                                      builder: (context) => BasicInfoFitnessGoal(userId: '')));
                                },
                                child: Container(
                                  child: Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: Colors.black,),
                                ),
                              )
                          ),
                        ),
                        Container(
                          width: 25.0,
                        ),
                        Container(
                          width: 230.0,
                          alignment:Alignment.center,
                          child: const Text('Basic Information',style: TextStyle(color: Colors.black, fontSize: 20,
                            fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          width: 50.0,
                        ),
                      ],
                    ),
                  ),
              preferredSize: const Size.fromHeight(500.0),
            ),
            resizeToAvoidBottomInset: false, // set it to false
            body: Center(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(4),
                  ),
                  Container(
                    width: 350,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26, vertical: 0),
                    child: RichText(
                      text: TextSpan(text: ' 03',
                        style: TextStyle(color: Colors.black, fontSize: 26,fontWeight: FontWeight.bold,),
                        children: [
                          TextSpan(text: '/04', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),

                          )
                        ],
                      ),
                    ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                  ),
                  Container(
                    width: 350,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26, vertical: 0),
                    child: RichText(
                      text: TextSpan(text: ' Where do you live?',
                        style: TextStyle(color: Colors.black, fontSize: 26,fontWeight: FontWeight.bold,),
                        children: [
                          TextSpan(text: '\n  Lorem ipsum dolar sit amet.', style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,),

                          )
                        ],
                      ),
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
                        controller: _userProfile.country,
                        autocorrect: true,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/usaflag.jpg',
                              width: 20,
                              height: 20,
                              fit: BoxFit.fill,
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(),
                          hintText: 'Country',
                          labelText: 'Country',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid country';
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
                        controller: _userProfile.zipcode,
                        autocorrect: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(IconData(_userProfile.iconCode, fontFamily: 'MaterialIcons')),// Will display "Up arrow" icon from the list
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(),
                          hintText: 'Zip code',
                          labelText: 'Zip code',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid zip code';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(100),
                    padding: EdgeInsets.all(90),
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
                            side: BorderSide( color: Colors.purple,width: 1,)
                        ),
                        child: const Text('Next',style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          textBaseline: TextBaseline.alphabetic,
                        ),),
                        onPressed: () {
                          // It returns true if the form is valid, otherwise returns false
                          if (_formKey.currentState!.validate()) {
                            _submit();
                            sendDataUserResidentInfo();
                          }
                        },
                      ),
                    ),
                    ),
                  ),
                  Container(
                    height: 20.0,
                    width: 350.0,
                    alignment:Alignment.centerRight,
                    child: const CheckConnectivity(),
                  ),//
                  //throw UnimplementedError();
                ],
              ),
            )
        )
    );
  }
}