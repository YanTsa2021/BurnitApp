//Basic information fitness goal implementation

import 'dart:convert';

import 'package:burnit_app/basicinfoheightweight.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_wrapper.dart';
import 'basicinforesidentinfo.dart';
import 'checkconnectivity.dart';
import 'dataconnectivity.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const BasicInfoFitnessGoal(userId: '',),
    },
  ));
}

class BasicInfoFitnessGoal extends StatefulWidget{
  final String userId;
  const BasicInfoFitnessGoal({key, required this.userId});
  
  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State < BasicInfoFitnessGoal>{
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

  //Fonction to add user basic fitness goal
  void sendDataFitnessGoal() async {
    print(widget.userId.toString());
    final response = await http.put(Uri.parse('http://api.burnit.socecepme.com/api/user-information/step2'), body: {
      "user_id": widget.userId.toString(),
      "desired_weight": _userProfile.desiredweight.text,
      "goal":  _userProfile.goal.text,
      "specific_goal":  _userProfile.specificGoal.text,
      "measured_goal":  _userProfile.measuredGoal.text,
      "achievable_goal":  _userProfile.achievableGoal.text,
      "relevant_goal":  _userProfile.relevantGoal.text,
      "time_goal":  _userProfile.timesGoal.text,
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
          builder: (context) => BasicInfoResidentInfo(userId: widget.userId.toString(),))
      );
    }
    if(response.statusCode == 400){
      //fetch error
      _userProfile.superheros_length = jsonDecode(_userProfile.apidata)['0']; //get all the data from json string
      print(_userProfile.superheros_length.length);

      for(var data in _userProfile.superheros_length.keys) {
        _userProfile.resp = jsonDecode( _userProfile.apidata)['0'][data];
      }

      //split string
      String finalResp = _userProfile.resp.reduce((value, element) {
      return value + element;
       });

      print(finalResp.toString());
      Fluttertoast.showToast(msg: finalResp.toString());
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
                            int id = 0;
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => BasicInfoHeightWeight(userId: id,)));
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
          resizeToAvoidBottomInset: false, // set it to falsee
            body: Center(
               child: OrientationBuilder(
               builder: (BuildContext context, Orientation orientation) {
               return ListView(
                 shrinkWrap: true,
                 scrollDirection: Axis.vertical,
                 children: <Widget>[
                 Container(
                    width: 350,
                    alignment:Alignment.centerLeft,
                   child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 7),
                    child: RichText(
                      text: const TextSpan(text: ' 02',
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
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    //padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 1),
                    width: 350,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 7),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: const TextSpan(text: 'Your Fitness Goal',
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
                    margin: const EdgeInsets.all(6),
                    padding: const EdgeInsets.all(6),
                  ),
                  SizedBox(
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: TextFormField(
                        key: const Key('shop_category_filter_input_text_field'),
                        controller: _userProfile.desiredweight,
                        autocorrect: true,
                        decoration: const InputDecoration(
                          // prefixIcon: Padding(
                          //padding: const EdgeInsets.all(10.0),
                          //child: Image.asset(
                          // 'assets/scale.png',
                          //width: 20,
                          //height: 20,
                          //fit: BoxFit.fill,
                          //),
                          //),
                          prefixIcon: Icon(Icons.monitor_weight_outlined),
                          //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(),
                          hintText: 'Desired Weight (lbs)',
                          labelText: 'Desired Weight (lbs)',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid desired weight';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100.0,
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: TextFormField(
                        key: const Key('shop_category_filter_input_text_field'),
                        controller: _userProfile.goal,
                        autocorrect: true,
                        decoration: const InputDecoration(
                          //prefixIcon: Icon(Icons.body_weight),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 35.0),
                          border: OutlineInputBorder(),
                          hintText: '   Goal (Max 25 words)',
                          // contentPadding: EdgeInsets.symmetric(
                          // vertical: 40,
                          // ),
                          labelText: '   Goal (Max 25 words)',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your goal max 25 words';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(3),
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      children: <Widget>[
                      Flexible(
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 60.0,
                            alignment:Alignment.centerLeft,
                            decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(8.0),),
                              child: RaisedButton(
                              elevation: 0,
                              textColor: Colors.white,
                              color: Colors.blueAccent,
                              child: const Text('S',style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                textBaseline: TextBaseline.alphabetic,
                                ),
                              ),
                              onPressed: () {
                                _userProfile.displayDialog(context,_userProfile.specificGoal);
                              }
                            ),
                           ),
                          ),
                        ),
                        Flexible(
                          child:Align(
                           alignment: Alignment.centerLeft,
                           child: Container(
                             width: 190.0,
                             alignment:Alignment.centerLeft,
                            child: const Text('Specific',style: TextStyle(
                              fontSize: 18.0,
                              textBaseline: TextBaseline.alphabetic,
                             ),
                          ),
                         )
                        ),
                      ),
                        const SizedBox(
                          width: 60.0,
                        ),
                      Flexible(
                        child:Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 40.0,
                            alignment:Alignment.centerRight,
                            decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(8.0),),
                            child: RaisedButton(
                              elevation: 0,
                              textColor: Colors.black,
                              color: Colors.white70,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide( color: Colors.black54,width: 0.5,)
                              ),
                              child: const Text('+',style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              ),
                              onPressed: () {
                                _userProfile.displayDialog(context,_userProfile.specificGoal);
                              }
                            ),
                          ),
                         ),
                        ),
                      ],
                     ),
                    ),
                  ),
                  Container(
                    height: 20.0,
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      children: <Widget>[
                      Flexible(
                      child:Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 60.0,
                          alignment:Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(8.0),),
                          child: RaisedButton(
                              elevation: 0,
                              textColor: Colors.white,
                              color: Colors.yellow,
                              child: const Text('M',style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              ),
                              onPressed: () {
                                _userProfile.displayDialog(context, _userProfile.measuredGoal);
                              }
                           ),
                           ),
                          ),
                        ),
                        Flexible(
                          child:Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 190.0,
                            alignment:Alignment.centerLeft,
                            child: const Text('Measured',style: TextStyle(
                              fontSize: 18.0,
                              textBaseline: TextBaseline.alphabetic,
                            ),
                            ),
                           ),
                          ),
                        ),
                        const SizedBox(
                          width: 60.0,
                        ),
                        Flexible(
                          child:Align(
                           alignment: Alignment.centerRight,
                           child: Container(
                             width: 40.0,
                             alignment:Alignment.centerRight,
                             decoration: BoxDecoration(
                             color: Colors.white70,
                             borderRadius: BorderRadius.circular(8.0),),
                              child: RaisedButton(
                              elevation: 0,
                              textColor: Colors.black,
                              color: Colors.white70,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide( color: Colors.black54,width: 0.5,)
                              ),
                              child: const Text('+',style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              ),
                              onPressed: () {
                                _userProfile.displayDialog(context, _userProfile.measuredGoal);
                              }
                             ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    height: 20.0,
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      children: <Widget>[
                      Flexible(
                         child:Align(
                         alignment: Alignment.centerLeft,
                          child: Container(
                          width: 60.0,
                          alignment:Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(8.0),),
                          child: RaisedButton(
                              elevation: 0,
                              textColor: Colors.white,
                              color: Colors.purple,
                              child: const Text('A',style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              ),
                              onPressed: () {
                                _userProfile.displayDialog(context, _userProfile.achievableGoal);
                              }
                            ),
                           ),
                          ),
                        ),
                        Flexible(
                           child:Align(
                             alignment: Alignment.centerLeft,
                             child: Container(
                               width: 190.0,
                               alignment:Alignment.centerLeft,
                               child: const Text('Achievable',style: TextStyle(
                                 fontSize: 18.0,
                                 //fontWeight: FontWeight.bold,
                                 textBaseline: TextBaseline.alphabetic,
                               ),
                              ),
                             ),
                           ),
                        ),
                        const SizedBox(
                          width: 60.0,
                        ),
                        Flexible(
                           child:Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                            width: 40.0,
                            alignment:Alignment.centerRight,
                            decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(8.0),),
                            child: RaisedButton(
                              elevation: 0,
                              textColor: Colors.black,
                              color: Colors.white70,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide( color: Colors.black54,width: 0.5,)
                              ),
                              child: const Text('+',style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              ),
                              onPressed: () {
                                _userProfile.displayDialog(context, _userProfile.achievableGoal);
                              }
                             ),
                            ),
                           ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    height: 20.0,
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      children: <Widget>[
                       Flexible(
                          child:Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                          width: 60.0,
                          alignment:Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8.0),),
                            child: RaisedButton(
                              elevation: 0,
                              textColor: Colors.white,
                              color: Colors.green,
                              child: const Text('R',style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              ),
                              onPressed: () {
                                _userProfile.displayDialog(context, _userProfile.relevantGoal);
                              }
                            ),
                           ),
                         ),
                        ),
                        Flexible(
                          child:Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                          width: 190.0,
                          alignment:Alignment.centerLeft,
                          child: const Text('Relevant',style: TextStyle(
                            fontSize: 18.0,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                          ),
                          ),
                         ),
                        ),
                        const SizedBox(
                          width: 60.0,
                        ),
                        Flexible(
                          child:Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                          width: 40.0,
                          alignment:Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(8.0),),
                          child: RaisedButton(
                              elevation: 0,
                              textColor: Colors.black,
                              color: Colors.white70,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide( color: Colors.black54,width: 0.5,)
                              ),
                              child: const Text('+',style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              ),
                              onPressed: () {
                                _userProfile.displayDialog(context, _userProfile.relevantGoal);
                              }
                            ),
                           ),
                          ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    height: 20.0,
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      children: <Widget>[
                       Flexible(
                       child:Align(
                         alignment: Alignment.centerLeft,
                         child: Container(
                          width: 60.0,
                          alignment:Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8.0),),
                          child: RaisedButton(
                              elevation: 0,
                              textColor: Colors.white,
                              color: Colors.red,
                              child: const Text('T',style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              ),
                              onPressed: () {
                                _userProfile.displayDialog(context, _userProfile.timesGoal);
                              }
                           ),
                          ),
                         ),
                        ),
                        Flexible(
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                            width: 190.0,
                            alignment:Alignment.centerLeft,
                            child: const Text('Times',style: TextStyle(
                              fontSize: 18.0,
                              //fontWeight: FontWeight.bold,
                              textBaseline: TextBaseline.alphabetic,
                            ),
                            ),
                           ),
                          ),
                        ),
                        const SizedBox(
                          width: 60.0,
                        ),
                        Flexible(
                          child:Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                          width: 40.0,
                          alignment:Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(8.0),),
                          child: RaisedButton(
                              elevation: 0,
                              textColor: Colors.black,
                              color: Colors.white70,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide( color: Colors.black54,width: 0.5,)
                              ),
                              child: const Text('+',style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                              ),
                              onPressed: () {
                                _userProfile.displayDialog(context, _userProfile.timesGoal);
                              }
                          ),
                        ),
                          ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(25),
                    padding: const EdgeInsets.all(25),
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
                            // If the form is valid, display a Snackbar.
                            _submit();
                            sendDataFitnessGoal();
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