
// @dart=2.9
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:burnit_app/onboardingone.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'notificationsetting.dart';

void main() {
    runApp(MaterialApp(
       initialRoute: '/',
          routes: {
            '/': (context) => LogoPage(),
          },
    ));
}

class LogoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //tap listiner on notification
    /*var id = 0;
    AwesomeNotifications().actionStream.listen((ReceivedNotification receivedNotification){
      print(receivedNotification.payload['name']);
      Navigator.of(context).pushNamed(
          '/NotificationSetting',
          arguments: {
            // your page params. I recommend you to pass the
            // entire *receivedNotification* object
            id: receivedNotification.id
          }
      );

      //output from first notification:  FlutterCampus
    });*/
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    ////Notification Listener
    AwesomeNotifications()
      .actionStream
      .listen((ReceivedNotification receivedNotification) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => NotificationSetting()),
          (Route<dynamic> route) => false,
    );
  });
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    OnboardingOne()
            )
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 450,
      //height: 450,
        width: MediaQuery.of(context).size.height,
        alignment:Alignment.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/ImgBurnit.png'),
            )
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => OnboardingOne()));
          },
        )
    );
  }
}