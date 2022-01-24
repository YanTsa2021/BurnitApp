//Basic information height and weight implementation

import 'dart:convert';

import 'package:burnit_app/userprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'basicinfofitnessgoal.dart';
import 'checkconnectivity.dart';
import 'register.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const BasicInfoHeightWeight(userId: 0),
    },
  ));
}

class BasicInfoHeightWeight extends StatefulWidget{
  final int userId;
  const BasicInfoHeightWeight({key, required this.userId});

  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}
class  MyCustomFormState extends State <BasicInfoHeightWeight>{
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

  //Fonction to add users weight and height
  void sendDataUserInformation() async {
    print(widget.userId.toString());
    final response = await http.post(Uri.parse('http://api.burnit.socecepme.com/api/user-information'), body: {
      "height":  _userProfile.height.text,
      "user_id": widget.userId.toString(),
      "weight": _userProfile.weight.text,
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
          builder: (context) => BasicInfoFitnessGoal(userId: widget.userId.toString(),))
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
                padding: EdgeInsets.symmetric(horizontal: 37, vertical: 7),
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
                                      builder: (context) => Register()));
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
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    child: RichText(
                      text: TextSpan(text: ' 01',
                        style: TextStyle(color: Colors.black, fontSize: 26,fontWeight: FontWeight.bold,),
                        children: [
                          TextSpan(text: '/04', style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,),

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
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    child: RichText(
                      text: TextSpan(text: ' Enter Height & Weight',
                        style: TextStyle(color: Colors.black, fontSize: 26,fontWeight: FontWeight.bold,),
                        children: [
                          TextSpan(text: '\n  Lorem ipsum dolar sit amet.', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),

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
                        controller: _userProfile.height,
                        autocorrect: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.fitness_center),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(),
                          hintText: 'Height (cm)',
                          labelText: 'Height (cm)',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid height';
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
                        controller: _userProfile.weight,
                        autocorrect: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.monitor_weight_outlined),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(),
                          hintText: 'Weight (lbs)',
                          labelText: 'Weight (lbs)',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid weight';
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
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
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
                            // If the form is valid, display a Snackbar.
                            _submit();
                            sendDataUserInformation();
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
                    child: CheckConnectivity(),
                  ),//
                  //throw UnimplementedError();
                ],
              ),
            )
        )
    );
  }
}