//Upcoming exercise by regular page implementation

import 'package:burnit_app/addvideo.dart';
import 'package:burnit_app/homepage.dart';
import 'package:burnit_app/upcomingexercisebycoach.dart';
import 'package:burnit_app/usergetvideobyregular.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'checkconnectivity.dart';
import 'dataconnectivity.dart';
import 'stories.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const UpComingExerciseByRegular(userId: '',),
    },
  ));
}

class UpComingExerciseByRegular extends StatefulWidget {
  final String userId;
  const UpComingExerciseByRegular({key, required this.userId});

  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State <UpComingExerciseByRegular>{
  // we get the instance of the stories class just as we would create a new instance.
  final Stories _story = Stories();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

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
                          height: 40.0,
                          alignment:Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => HomePage(userId: widget.userId.toString(),)));
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
                        child: const Text('Exercise',style: TextStyle(color: Colors.black, fontSize: 20,
                          fontWeight: FontWeight.bold,),)
                    ),
                  ),
                ),
                Expanded(
                  child:Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      alignment:Alignment.centerRight,
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
                                  builder: (context) => AddVideo(userId: widget.userId.toString(),)));
                            },
                            child: const Icon(Icons.add,size: 20, color: Colors.black,),
                          )
                      ),
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
                            height: 50.0,
                            width: 350.0,
                            alignment:Alignment.center,
                            child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                              child: Row(
                              children: <Widget>[
                                Flexible(
                                   child:Align(
                                   alignment: Alignment.centerLeft,
                                     child: Container(
                                    width: 172.0,
                                    alignment:Alignment.center,
                                    decoration: BoxDecoration(
                                    color: Colors.white38,
                                    borderRadius: BorderRadius.circular(8.0),),
                                    child: RaisedButton(
                                      elevation: 0,
                                      textColor: Colors.grey,
                                      color: Colors.white38,
                                      child: const Text('By Coach',style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        textBaseline: TextBaseline.alphabetic,
                                      ),
                                      ),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => UpComingExerciseByCoach(userId:widget.userId.toString(),)));
                                        }
                                       ),
                                     ),
                                   ),
                                ),
                                Container(
                                  width: 6.0,
                                ),
                                Flexible(
                                  child:Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                  width: 172.0,
                                  alignment:Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(8.0),),
                                     child: RaisedButton(
                                      elevation: 0,
                                      textColor: Colors.white,
                                      color: Colors.purple,
                                      child: const Text('All Exercise',style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        textBaseline: TextBaseline.alphabetic,
                                      ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => UpComingExerciseByRegular(userId:widget.userId.toString(),)));
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
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(2),
                  ),
                  Container(
                    height: 800.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      child: UserGetVideoByRegular(),
                    ),
                  ),
                 Container(
                   margin: const EdgeInsets.all(5),
                   padding: const EdgeInsets.all(5),
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