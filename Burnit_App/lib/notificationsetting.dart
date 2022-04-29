//Notification Setting page implementation

import 'package:burnit_app/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'dataconnectivity.dart';
import 'package:slider_button/slider_button.dart';
import 'package:app_settings/app_settings.dart';
import 'stories.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      'resource://drawable/notification_icon',
      [            // notification icon
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel', /* same name */
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          channelShowBadge: true,
          importance: NotificationImportance.High,
          enableVibration: true,
        ),

        NotificationChannel(
            channelGroupKey: 'image_test',
            channelKey: 'image',
            channelName: 'image notifications',
            channelDescription: 'Notification channel for image tests',
            defaultColor: Colors.redAccent,
            ledColor: Colors.white,
            channelShowBadge: true,
            importance: NotificationImportance.High
        )

           //add more notification type with different configuration
      ],
          // Channel groups are only visual and are not required
      channelGroups:
      [
      NotificationChannelGroup(
         channelGroupkey: 'basic_channel_group',
         channelGroupName: 'Basic group')
      ],
      debug: true
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => NotificationSetting(),
    },
  ));
}

class NotificationSetting extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State < NotificationSetting>{
  // we get the instance of the stories class just as we would create a new instance.
  final Stories _story = Stories();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  @override
  void initState() {
    main();
    super.initState();
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
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                       child: Text('Notification Setting',style: TextStyle(color: Colors.black, fontSize: 20,
                      fontWeight: FontWeight.bold,),),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child: Row(
                      children: <Widget>[
                       Container(
                          width: 260.0,
                          height: 50,
                          alignment:Alignment.centerLeft,
                          child: RichText(
                            text: const TextSpan(text: 'Push Notification',
                              style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                              children: [
                                TextSpan(text: '\nChange your notification setting', style: TextStyle(color: Colors.black54, fontSize: 17,fontWeight: FontWeight.bold,),

                                )
                              ],
                            ),
                           ),
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
                                  action: () async {
                                    bool isallowed = await AwesomeNotifications().isNotificationAllowed();
                                    if (!isallowed) {
                                      //no permission of local notification
                                      AwesomeNotifications().requestPermissionToSendNotifications();
                                    }else{
                                      //show notification
                                      AwesomeNotifications().createNotification(
                                        content: NotificationContent( //simgple notification
                                          id: 123,
                                          channelKey: 'basic_channel', /* same name */
                                          title: 'Welcome to BurnitApp',
                                          body: 'This is Push Notification from Flutter App',
                                          payload: {"name":"FlutterCampus"}
                                       )
                                     );
                                  }
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
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 260.0,
                          height: 50,
                          alignment:Alignment.centerLeft,
                          child: RichText(
                            text: const TextSpan(text: 'Do Not Disturb Mode ',
                              style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                              children: [
                                TextSpan(text: '\nChange your notification setting', style: TextStyle(color: Colors.black54, fontSize: 17,fontWeight: FontWeight.bold,),

                                )
                              ],
                            ),
                          ),
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
                                    action: () async {
                                      bool isallowed = await AwesomeNotifications().isNotificationAllowed();
                                      if (!isallowed) {
                                        //no permission of local notification
                                        AwesomeNotifications().requestPermissionToSendNotifications();
                                      }else{
                                        //show notification
                                        AwesomeNotifications().createNotification(
                                            content: NotificationContent( //with asset image
                                                id: 1234,
                                                channelKey: 'image',
                                                title: 'Do Not Disturb',
                                                body: 'This is Do Not Disturb Mode from Flutter App',
                                                bigPicture: 'asset://assets/images/elephant.jpg',
                                                notificationLayout: NotificationLayout.BigPicture,
                                                fullScreenIntent: true, //it will display over app
                                                locked: true,
                                                payload: {"id":"1234"}

                                            )
                                        );
                                      }
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
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                    ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child: Row(
                      children: <Widget>[
                        Container(
                          width: 260.0,
                          height: 50,
                          alignment:Alignment.centerLeft,
                          child: RichText(
                            text: const TextSpan(text: 'Chat Notification',
                              style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                              children: [
                                TextSpan(text: '\nChange your notification setting', style: TextStyle(color: Colors.black54, fontSize: 17,fontWeight: FontWeight.bold,),

                                )
                              ],
                            ),
                          ),
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
                                    action: () async {
                                      bool isallowed = await AwesomeNotifications().isNotificationAllowed();
                                      if (!isallowed) {
                                        //no permission of local notification
                                        AwesomeNotifications().requestPermissionToSendNotifications();
                                      }else{
                                        //show notification
                                        AwesomeNotifications().createNotification(
                                            content: NotificationContent( //with image from URL
                                                id: 12345,
                                                channelKey: 'image',
                                                title: 'Simple Chat Notification with Network Image',
                                                body: 'This is a Chat Notification from Flutter App',
                                                bigPicture: 'https://www.fluttercampus.com/img/logo_small.webp',
                                                notificationLayout: NotificationLayout.BigPicture,
                                                payload: {"id":"12345"}
                                            )
                                        );
                                      }
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
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 300.0,
                          height: 50,
                          alignment:Alignment.centerLeft,
                          child: RichText(
                            text: const TextSpan(text: 'Notification for Upcoming Exercise',
                              style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                              children: [
                                TextSpan(text: '\nChange your notification setting', style: TextStyle(color: Colors.black54, fontSize: 17,fontWeight: FontWeight.bold,),

                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child:Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 40.0,
                              height: 30,
                              alignment:Alignment.centerLeft,
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
                                      action: () async {
                                        bool isallowed = await AwesomeNotifications().isNotificationAllowed();
                                        if (!isallowed) {
                                          //no permission of local notification
                                          AwesomeNotifications().requestPermissionToSendNotifications();
                                        }else{
                                          //show notification
                                          AwesomeNotifications().createNotification(
                                              content: NotificationContent( //simgple notification
                                                  id: 123,
                                                  channelKey: 'basic_channel', /* same name */
                                                  title: 'Upcoming Exercise',
                                                  body: 'This is an Upcoming Exercise from Flutter App',
                                                  payload: {"name":"FlutterCampus"}
                                              )
                                          );
                                        }
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
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                  ),
                  Container(
                    height: 50.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 260.0,
                          height: 50,
                          alignment:Alignment.centerLeft,
                          child: RichText(
                            text: const TextSpan(text: 'Notification for Posts',
                              style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                              children: [
                                TextSpan(text: '\nChange your notification setting', style: TextStyle(color: Colors.black54, fontSize: 17,fontWeight: FontWeight.bold,),
                                )
                              ],
                            ),
                          ),
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
                                      action: () async {
                                        bool isallowed = await AwesomeNotifications().isNotificationAllowed();
                                        if (!isallowed) {
                                          //no permission of local notification
                                          AwesomeNotifications().requestPermissionToSendNotifications();
                                        }else{
                                          //show notification
                                          AwesomeNotifications().createNotification(
                                              content: NotificationContent( //simgple notification
                                                  id: 123,
                                                  channelKey: 'basic_channel', /* same name */
                                                  title: 'Posts Notification',
                                                  body: 'This is a Notification for Posts from Flutter App',
                                                  payload: {"name":"FlutterCampus"}
                                              )
                                          );
                                        }
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
                    margin: const EdgeInsets.all(100),
                    padding: const EdgeInsets.all(100),
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