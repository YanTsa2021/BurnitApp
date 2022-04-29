//Home page implementation

import 'package:burnit_app/addnutrition.dart';
import 'package:burnit_app/basicinfoprofilepicture.dart';
import 'package:burnit_app/chat.dart';
import 'package:burnit_app/newsfeed.dart';
import 'package:burnit_app/nutritiondetails.dart';
import 'package:burnit_app/settings.dart';
import 'package:burnit_app/upcomingexercisebycoach.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'checkconnectivity.dart';
import 'dataconnectivity.dart';

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
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  final _formKey = GlobalKey<FormState>();
  static const IconData restaurant = IconData(0xe532, fontFamily: 'MaterialIcons');

  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  // initialise a string st
  final List<Map<String, dynamic>> _allCategories = [
    {"id": 1, "name": "Salad"},
    {"id": 2, "name": "Vegetables"},
    {"id": 3, "name": "Non-vegetables"},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundCategories = [];
  @override
  initState() {
    // at the beginning, all categories are shown
    //_foundCategories.isEmpty;
    // _foundCategories = _allCategories;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allCategories;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      results = _allCategories
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toUpperCase() method to make it case-insensitive
      results = _allCategories
          .where((user) =>
          user["name"].toUpperCase().contains(enteredKeyword.toUpperCase()))
           .toList();

    }

    // Refresh the UI
    setState(() {
      _foundCategories = results;
    });
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
                                  builder: (context) => const BasicInfoProfilePicture(userId: '',)));
                            },
                            child: const Icon(Icons.account_box,size: 30, color: Colors.grey,),
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
                        child: const Text('Home',style: TextStyle(color: Colors.black, fontSize: 20,
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
                                  builder: (context) => const BasicInfoProfilePicture(userId: '',)));
                            },
                            child: const Icon(Icons.shop,size: 30, color: Colors.grey,),
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
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(3),
                  ),
                  Container(
                    width: 350,
                    height: 130,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            onChanged: (value) => _runFilter(value),
                            maxLines: 1,
                            style: const TextStyle(fontSize: 17),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              filled: true,
                              prefixIcon:
                              Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(Radius.circular(8))),
                              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Search something here',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: _foundCategories.isNotEmpty
                                ? ListView.builder(
                                 itemCount: _foundCategories.length,
                                 itemBuilder: (context, index) {
                                  return ListTile(
                                      leading: Text(
                                        _foundCategories[index]["id"].toString(),
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      title: Text(_foundCategories[index]['name']),
                                  );
                                }
                              )
                                : const Text(
                               'No results found',
                               style: TextStyle(fontSize: 24),
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
                    width: 350,
                    height: 36,
                    alignment:Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Text('Upcoming Exercise',style: TextStyle(color: Colors.black, fontSize: 20,
                        fontWeight: FontWeight.bold,),),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 200,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: GestureDetector(
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
                        onTap: () {
                          _userProfile.fetchUsersVideos(context);
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(3),
                  ),
                  Container(
                    height: 40.0,
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
                                width: 200.0,
                                alignment:Alignment.centerLeft,
                                child: const Text('Nutrition',style: TextStyle(color: Colors.black, fontSize: 20,
                                  fontWeight: FontWeight.bold,),),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 50.0,
                          ),
                          Flexible(
                            child:Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  width: 100.0,
                                  alignment:Alignment.centerRight,
                                  child: Text.rich(
                                    TextSpan(text: 'See all', style: const TextStyle(color: Colors.red, fontSize: 16,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,),
                                        recognizer: TapGestureRecognizer()..onTap = (){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => NutritionDetails(userId: widget.userId.toString(),))
                                          );
                                        }
                                    ),
                                  )
                              ),
                            ),
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
                                  image: const DecorationImage(
                                      image: AssetImage('assets/ImgFoodEggBlanket.png'),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              width: 150.0,
                              height: 50,
                              alignment:Alignment.centerLeft,
                              child: RichText(
                                text: const TextSpan(text: 'Eggy Noodls',
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
                                  image: const DecorationImage(
                                      image: AssetImage('assets/ImgFoodEggNoodles.png'),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              width: 150.0,
                              height: 50,
                              alignment:Alignment.centerRight,
                              child: RichText(
                                text: const TextSpan(text: 'Egg in Blanket',
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
                                  image: const DecorationImage(
                                      image: AssetImage('assets/ImgFoodEggNoodles.png'),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              width: 150.0,
                              height: 50,
                              alignment:Alignment.centerRight,
                              child: RichText(
                                text: const TextSpan(text: 'Avocado',
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
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(3),
                  ),
                  Container(
                    height: 40.0,
                    width: 350.0,
                    alignment:Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Text('News Feed',style: TextStyle(color: Colors.black, fontSize: 20,
                        fontWeight: FontWeight.bold,),),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(23),
                    padding: const EdgeInsets.all(23),
                  ),
                  Container(
                    width: 350.0,
                    height: 80,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 60.0,
                            height: 80.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 30.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.home), iconSize: 30,color:Colors.red,
                                        onPressed: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => const HomePage(userId: '',)));
                                        }
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 20.0,
                                    alignment:Alignment.center,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Home',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 30.0,
                          ),
                          SizedBox(
                            width: 60.0,
                            height: 80.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 30.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.feed), iconSize: 30,color:Colors.grey,
                                        onPressed: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => NewsFeed(userId:widget.userId.toString(),)));
                                          print('User Id )${widget.userId.toString()}  Success');
                                        }
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 20.0,
                                    alignment:Alignment.center,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Feed',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 30.0,
                          ),
                          SizedBox(
                            width: 60.0,
                            height: 80.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 30.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.event), iconSize: 30,color:Colors.grey,
                                        onPressed:null //()
                                        /*{
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => HomePage(userId: '',)));
                                        }*/
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 20.0,
                                    alignment:Alignment.center,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Event',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 30.0,
                          ),
                          SizedBox(
                            width: 60.0,
                            height: 80.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 30.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.chat), iconSize: 30,color:Colors.grey,
                                        onPressed:null //()
                                        /*{
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => Chat()));
                                        }*/
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 20.0,
                                    alignment:Alignment.center,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Chat',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 30.0,
                          ),
                          SizedBox(
                            width: 60.0,
                            height: 80.0,
                            child: Stack(
                              children:  <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child:Container(
                                    height: 30.0,
                                    alignment:Alignment.center,
                                    child: IconButton(icon: const Icon(Icons.settings), iconSize: 30,color:Colors.grey,
                                        onPressed: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => Settings(userId:widget.userId.toString(),)));
                                        }
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:Container(
                                    height: 20.0,
                                    alignment:Alignment.center,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Settings',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 0.0,
                          ),
                        ],
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