//Basic information resident information implementation

import 'dart:convert';

import 'package:burnit_app/userprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'basicinfofitnessgoal.dart';
import 'basicinfoprofilepicture.dart';
import 'checkconnectivity.dart';
import 'dataconnectivity.dart';

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
  final int iconCode = 60996;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

  //Fonction to add users basic resident information
  void sendDataUserResidentInfo() async {
    print(widget.userId.toString());
    final response = await http.put(Uri.parse('http://api.burnit.socecepme.com/api/user-information/step3'), body: {
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
                    child:  Container(
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
                          height: 40.0,
                          alignment:Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => BasicInfoFitnessGoal(userId: '')));
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
                      height: 40.0,
                      alignment:Alignment.center,
                      child: const Text('Basic Information',style: TextStyle(color: Colors.black, fontSize: 20,
                        fontWeight: FontWeight.bold,),),
                    ),
                  ),
                ),
                Expanded(
                  child:Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 5.0,
                      height: 40.0,
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
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(4),
                  ),
                  Container(
                    width: 350,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 0),
                    child: RichText(
                      text: const TextSpan(text: ' 03',
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
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                  ),
                  Container(
                    width: 350,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 0),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: const TextSpan(text: 'Where do you live?',
                        style: TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold,),
                        children: [
                          TextSpan(text: '\nLorem ipsum dolar sit amet.', style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,),

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
                      child: TextFormField(
                        key: const Key('shop_category_filter_input_text_field'),
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
                          //contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: const OutlineInputBorder(),
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

                  SizedBox(
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: TextFormField(
                        key: const Key('shop_category_filter_input_text_field'),
                        controller: _userProfile.zipcode,
                        autocorrect: true,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/zipcode.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.fill,
                            ),
                          ),
                          //prefixIcon: Icon( const IconData(iconCode, fontFamily: 'MaterialIcons')),// Will display "Up arrow" icon from the list
                          //contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: const OutlineInputBorder(),
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