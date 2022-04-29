//Privacy Policy Setting page implementation

import 'package:settings_ui/settings_ui.dart';
import 'package:app_settings/app_settings.dart';
import 'package:burnit_app/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:slider_button/slider_button.dart';
import 'dataconnectivity.dart';
import 'stories.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => PrivacyPolicySetting (),
    },
  ));
}

class PrivacyPolicySetting extends StatefulWidget {

  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State < PrivacyPolicySetting>{
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
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                  ),
                  Container(
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Text('Privacy Policy',style: TextStyle(color: Colors.black, fontSize: 20,
                        fontWeight: FontWeight.bold,),),
                    ),
                  ),
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
                                 width: 300.0,
                                 height: 40,
                                 alignment:Alignment.centerLeft,
                                 child: const Text('Location Service',style: TextStyle(color: Colors.black, fontSize: 16,
                                 fontWeight: FontWeight.bold,),),
                              ),
                            ),
                          ),
                          Container(
                            width: 10.0,
                          ),
                          Flexible(
                            child:Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                               width: 40.0,
                               height: 30,
                               alignment:Alignment.centerRight,
                               child: Container(
                                 height: 30.0,
                                 width: 40.0,
                                 decoration: BoxDecoration(
                                   color: Colors.green,
                                   borderRadius: BorderRadius.circular(20.0),),
                                   alignment:Alignment.centerLeft,
                                 child: SizedBox(
                                   width: 20,
                                   height: 20,// specific value
                                   child: SliderButton(
                                     action: () {
                                       AppSettings.openLocationSettings();
                                     },
                                     icon: Text(
                                       "x",
                                       style: TextStyle(
                                         color: Colors.white,
                                         fontWeight: FontWeight.w400,
                                         fontSize: 44,
                                       ),
                                     ),
                                   ),
                                 ),
                               ),
                              ),
                             ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 350.0,
                    alignment:Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Text('Location Services helps us to offer personalized '
                          '\nrecommendation. Mobile GPS, Bluetooth and crowd sources '
                          '\nWi-Fi hotspot and mobile phone locations to determine your approximate location.', style: TextStyle(color: Colors.black54, fontSize: 16,
                        fontWeight: FontWeight.bold,),),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(3),
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Row(
                        children: <Widget>[
                        Flexible(
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 240.0,
                              height: 40,
                              alignment:Alignment.centerLeft,
                              child: const Text('Connect Contacts',style: TextStyle(color: Colors.black, fontSize: 16,
                                fontWeight: FontWeight.bold,),),
                            ),
                           ),
                          ),
                          Container(
                            width: 70.0,
                          ),
                          Flexible(
                             child:Align(
                             alignment: Alignment.centerRight,
                             child: Container(
                               width: 40.0,
                               height: 30,
                               alignment:Alignment.centerRight,
                               child: Container(
                                 height: 30.0,
                                 width: 40.0,
                                 decoration: BoxDecoration(
                                 color: Colors.green,
                                 borderRadius: BorderRadius.circular(20.0),),
                                 alignment:Alignment.centerLeft,
                                 child: SizedBox(
                                   width: 20,
                                   height: 20,// specific value
                                   child: SliderButton(
                                     action: () {
                                       AppSettings.openAppSettings();
                                     },
                                     icon: Text(
                                       "x",
                                       style: TextStyle(
                                         color: Colors.white,
                                         fontWeight: FontWeight.w400,
                                         fontSize: 44,
                                       ),
                                     ),
                                   ),
                                 ),
                               ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 350.0,
                    alignment:Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Text('Lorem psum dolor sit amet, consectetur adipiscing elit, sed'
                          'do eiusmod tempor incididunt ut labore et dolore.', style: TextStyle(color: Colors.black54, fontSize: 16,
                        fontWeight: FontWeight.bold,),),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(3),
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child:Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 300.0,
                                height: 40,
                                alignment:Alignment.centerLeft,
                                child: const Text('Enable Microphone',style: TextStyle(color: Colors.black, fontSize: 16,
                                  fontWeight: FontWeight.bold,),),
                              ),
                            ),
                          ),
                          Container(
                            width: 70.0,
                          ),
                          Flexible(
                             child:Align(
                               alignment:Alignment.centerRight,
                             child: Container(
                               width: 40.0,
                               height: 30,
                               alignment:Alignment.centerRight,
                               child: Container(
                                 height: 30.0,
                                 width: 40.0,
                                 decoration: BoxDecoration(
                                 color: Colors.green,
                                 borderRadius: BorderRadius.circular(20.0),),
                                 alignment:Alignment.centerLeft,
                                 child: SizedBox(
                                   width: 20,
                                   height: 20,// specific value
                                   child: SliderButton(
                                     action: () {
                                       AppSettings.openDeviceSettings();
                                     },
                                     icon: Text(
                                       "x",
                                       style: TextStyle(
                                         color: Colors.white,
                                         fontWeight: FontWeight.w400,
                                         fontSize: 44,
                                       ),
                                     ),
                                   ),
                                 ),
                               ),
                              ),
                             ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(3),
                  ),
                  Container(
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: const TextSpan(text: 'Human Friendly Terms of Service',
                          style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                          children: [
                            TextSpan(text: '\n\nOur human-friendly Terms of Service for the Tribevibe'
                                '\nplatform prevails over the detailed one, which specifies all '
                                'rights abd obligations for both you and Tribevibe in more complex legalese.'
                                ' \n\nIn the event of a contradiction between the two documents,'
                                'the “human-friendly” Terms of Service shall prevail. That '
                                'means no nasty surprises if you read only the human-friendly versions. '
                                '\n\n\n\Last updated: 28 July, 2021', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),

                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(55),
                    padding: const EdgeInsets.all(55),
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