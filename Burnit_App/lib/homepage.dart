//Home page implementation

import 'package:burnit_app/basicinfoprofilepicture.dart';
import 'package:burnit_app/chat.dart';
import 'package:burnit_app/newsfeed.dart';
import 'package:burnit_app/settings.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'checkconnectivity.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(userId: '',),
    },
  ));
}

class HomePage extends StatefulWidget {
  final String userId;
  const HomePage({key, required this.userId});

  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State < HomePage>{
  final _formKey = GlobalKey<FormState>();
  static const IconData restaurant = IconData(0xe532, fontFamily: 'MaterialIcons');
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: PreferredSize(
              child: Container(
                margin: const EdgeInsets.only(top:40.0),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
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
                                      builder: (context) => const BasicInfoProfilePicture(userId: '',)));
                                },
                                child: Container(
                                  child: Icon(Icons.account_box,size: 30, color: Colors.grey,),
                                ),
                              )
                          ),
                        ),
                        Container(
                          width: 20.0,
                        ),
                        Container(
                          width: 230.0,
                          alignment:Alignment.center,
                          child: const Text('Home',style: TextStyle(color: Colors.black, fontSize: 20,
                            fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          width: 25.0,
                        ),
                        Container(
                          width: 35.0,
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
                              width: 35.0,
                              alignment:Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => const BasicInfoProfilePicture(userId: '',)));
                                },
                                child: Container(
                                  child: const Icon(Icons.shop,size: 30, color: Colors.grey,),
                                ),
                              )
                          ),
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
                    margin: EdgeInsets.all(3),
                    padding: EdgeInsets.all(3),
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    child: TextField(
                      maxLines: 1,
                      style: const TextStyle(fontSize: 17),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon:
                        Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Search something here',
                      ),
                    ),
                   ),
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    padding: EdgeInsets.all(3),
                  ),
                  Container(
                    width: 350,
                    height: 36,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    child: const Text('Upcoming Exercise',style: TextStyle(color: Colors.black, fontSize: 20,
                      fontWeight: FontWeight.bold,),),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 200,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    child: Carousel(
                      images: [
                        AssetImage('assets/ImgUpcomingExercise.png'),
                        AssetImage('assets/ImgUpcomingExerciseTwo.png'),
                        AssetImage('assets/ImgUpcomingExerciseThree.png'),
                        AssetImage('assets/ImgUpcomingExerciseFour.png'),
                        AssetImage('assets/ImgUpcomingExerciseFive.png'),
                        AssetImage('assets/ImgUpcomingExerciseSix.png'),
                      ],
                      dotColor: Colors.grey,
                      boxFit:BoxFit.cover,
                      borderRadius:true,
                    ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    padding: EdgeInsets.all(3),
                  ),
                  Container(
                    height: 40.0,
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          alignment:Alignment.centerLeft,
                          child: const Text('Nutrition',style: TextStyle(color: Colors.black, fontSize: 20,
                            fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          width: 50.0,
                        ),
                        Container(
                            width: 100.0,
                            alignment:Alignment.centerRight,
                            child: Text.rich(
                              TextSpan(text: 'See all', style: TextStyle(color: Colors.red, fontSize: 16,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,),
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => BasicInfoProfilePicture(userId: '',))
                                    );
                                  }
                              ),
                            )
                        ),
                      ],
                    ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 200,
                    alignment:Alignment.center,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          width: 150.0,
                          height: 100,
                          alignment:Alignment.centerLeft,
                          child: Column(children: <Widget>[
                            Container(
                              width: 150.0,
                              height: 100,
                             decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                  image: AssetImage('assets/ImgFoodEggBlanket.png'),
                                  fit: BoxFit.cover)),
                            ),
                            Container(
                              width: 150.0,
                              height: 50,
                              alignment:Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(text: 'Eggy Noodls',
                                  style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                                  children: [
                                    TextSpan(text: '\nLorem ipsum dolar sit amet consectetur.', style: TextStyle(color: Colors.black54, fontSize: 12,fontWeight: FontWeight.bold,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          width: 5.0,
                        ),
                        Container(
                          width: 150.0,
                          height: 100,
                          alignment:Alignment.centerRight,
                          child: Column(children: <Widget>[
                          Container(
                           width: 150.0,
                           height: 100,
                           decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                  image: AssetImage('assets/ImgFoodEggNoodles.png'),
                                  fit: BoxFit.cover)),
                          ),
                            Container(
                              width: 150.0,
                              height: 50,
                              alignment:Alignment.centerRight,
                              child: RichText(
                                text: TextSpan(text: 'Avocado',
                                  style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                                  children: [
                                    TextSpan(text: '\nLorem ipsum dolar sit amet consectetur.', style: TextStyle(color: Colors.black54, fontSize: 12,fontWeight: FontWeight.bold,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          width: 5.0,
                        ),
                        Container(
                          width: 150.0,
                          height: 100,
                          alignment:Alignment.centerRight,
                          child: Column(children: <Widget>[
                          Container(
                          width: 150.0,
                          height: 100,
                              decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                  image: AssetImage('assets/ImgFoodEggNoodles.png'),
                                  fit: BoxFit.cover)),
                          ),
                            Container(
                              width: 150.0,
                              height: 50,
                              alignment:Alignment.centerRight,
                              child: RichText(
                                text: TextSpan(text: 'Avocado',
                                  style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                                  children: [
                                    TextSpan(text: '\nLorem ipsum dolar sit amet consectetur.', style: TextStyle(color: Colors.black54, fontSize: 12,fontWeight: FontWeight.bold,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    padding: EdgeInsets.all(3),
                  ),
                  Container(
                    height: 40.0,
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    child: const Text('News Feed',style: TextStyle(color: Colors.black, fontSize: 20,
                      fontWeight: FontWeight.bold,),),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(23),
                    padding: EdgeInsets.all(23),
                  ),
                  Container(
                    width: 350.0,
                    height: 50,
                    alignment:Alignment.center,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          child: IconButton(icon: const Icon(Icons.home), iconSize: 25,color:Colors.red,
                              onPressed: ()
                              {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => const HomePage(userId: '',)));
                              }
                          ),
                        ),
                        Container(
                          width: 30.0,
                        ),
                        Container(
                          width: 50.0,
                          child: new IconButton(icon: Icon(Icons.feed), iconSize: 25,color:Colors.grey,
                              onPressed: ()
                              {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => NewsFeed(userId:widget.userId.toString(),)));
                                print('User Id )${widget.toString()}  Success');
                              }
                          ),
                        ),
                        Container(
                          width: 30.0,
                        ),
                        Container(
                          width: 50.0,
                          child: new IconButton(icon: new Icon(Icons.event), iconSize: 25,color:Colors.grey,
                              onPressed: ()
                              {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HomePage(userId: '',)));
                              }
                          ),
                        ),
                        Container(
                          width: 20.0,
                        ),
                        Container(
                          width: 50.0,
                          child: new IconButton(icon: new Icon(Icons.chat), iconSize: 25,color:Colors.grey,
                              onPressed: ()
                              {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Chat()));
                              }
                          ),
                        ),
                        Container(
                          width: 20.0,
                        ),
                        Container(
                          width: 30.0,
                          child: new IconButton(icon: new Icon(Icons.settings), iconSize: 25,color:Colors.grey,
                              onPressed: ()
                              {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Settings()));
                              }
                          ),
                        ),
                        Container(
                          width: 20.0,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          child: GestureDetector(
                            child: new Text(
                              'Home',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 30.0,
                        ),
                        Container(
                          width: 50.0,
                          child: const Text(
                            'Feed',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 30.0,
                        ),
                        Container(
                          width: 50.0,
                          child: const Text(
                            'Event',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 20.0,
                        ),
                        Container(
                          width: 50.0,
                          child: const Text(
                            'Chat',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 10.0,
                        ),
                        Container(
                          width: 60.0,
                          child: const Text(
                            'Settings',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 10.0,
                        ),
                      ],
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