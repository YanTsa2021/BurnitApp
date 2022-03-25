//Add contact list page implementation

import 'dart:convert';

import 'package:burnit_app/contactlist.dart';
import 'package:burnit_app/homepage.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
      '/': (context) => const AddContactList(userId: '',),
    },
  ));
}

class AddContactList extends StatefulWidget {
  final String userId;
  const AddContactList({key, required this.userId});
  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State <AddContactList>{
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

  //Fonction to add users contact list
  void sendDataUserContactDetails() async {
    print(widget.userId.toString());
    final response = await http.post(Uri.parse('http://api.burnit.socecepme.com/api/contact'), body: {
      "user_id":  widget.userId.toString(),
      "name": _userProfile.name.text,
      "phone": _userProfile.phone.text,
      "email": _userProfile.email.text,
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
          builder: (context) => HomePage(userId: widget.userId.toString(),))
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
            appBar: AppBar(
              title: Row(children: [
                Expanded(
                  child:Align(
                    alignment: Alignment.centerLeft,
                    child:  Container(
                      width: 35.0,
                      height: 35.0,
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
                          height: 35.0,
                          alignment:Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => BasicInfoProfilePicture(userId: '')));
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
                      width: 260.0,
                      height: 35.0,
                      alignment:Alignment.center,
                      child: const Text('Add Contact List',style: TextStyle(color: Colors.black, fontSize: 20,
                        fontWeight: FontWeight.bold,),),
                    ),
                  ),
                ),
                Expanded(
                  child:Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 5.0,
                      height: 35.0,
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
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(4),
                  ),
                  Container(
                    width: 350,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 0),
                      child: RichText(
                        text: const TextSpan(text: ' 05',
                          style: TextStyle(color: Colors.black, fontSize: 26,fontWeight: FontWeight.bold,),
                          children: [
                            TextSpan(text: '/05', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),

                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                  ),
                  Container(
                    width: 350,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 0),
                      child: RichText(
                        text: const TextSpan(text: ' Can I have your contact details?',
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
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                  ),
                  SizedBox(
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child:TextFormField(
                        key: const Key('shop_category_filter_input_text_field'),
                        controller: _userProfile.name,
                        autocorrect: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          labelText: 'Full Name',
                          hintText: 'Enter your full name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
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
                      child:TextFormField(
                        key: const Key('shop_category_filter_input_text_field'),
                        controller: _userProfile.phone,
                        autocorrect: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                          hintText: 'Enter a phone number',
                          labelText: 'Phone',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid phone number';
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
                      child:TextFormField(
                        key: const Key('shop_category_filter_input_text_field'),
                        controller: _userProfile.email,
                        autocorrect: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                          hintText: 'E-mail',
                          labelText: 'Email',
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
                    alignment:Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child: Text.rich(
                        TextSpan(text: 'contact list?', style: const TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ContactList(userId: '',))
                              );
                            }
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(100),
                    padding: const EdgeInsets.all(90),
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
                          child: const Text('Finish',style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            textBaseline: TextBaseline.alphabetic,
                          ),),
                          onPressed: () {
                            // It returns true if the form is valid, otherwise returns false
                            if (_formKey.currentState!.validate()) {
                              _submit();
                              sendDataUserContactDetails();
                            }
                          },
                        ),
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
                  ),//
                  //throw UnimplementedError();
                ],
              ),
            )
        )
    );
  }
}