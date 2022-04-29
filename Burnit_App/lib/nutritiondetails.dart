//Nutrition Detaisl page implementation

import 'package:burnit_app/addnutrition.dart';
import 'package:burnit_app/addpost.dart';
import 'package:burnit_app/categories.dart';
import 'package:burnit_app/homepage.dart';
import 'package:burnit_app/newsfeed.dart';
import 'package:burnit_app/nutrition.dart';
import 'package:burnit_app/userpostlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
      '/': (context) => const NutritionDetails(userId: '',),
    },
  ));
}

class NutritionDetails extends StatefulWidget {
  final String userId;
  const NutritionDetails({key, required this.userId});

  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State <NutritionDetails>{
  // we get the instance of the stories class just as we would create a new instance.
  final Stories _story = Stories();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  static List<String> mainDataList = [
    "",
    "Salad",
    "Vegetables",
    "Non-vegetables",
  ];

  // Copy Main List into New List.
  List<String> newDataList = List.from(mainDataList);

  @override
  initState() {
    // at the beginning, all categories are shown
    newDataList.isEmpty;
    super.initState();
  }

  onItemChanged(String value) {
    setState(() {
      newDataList = mainDataList
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
      newDataList = mainDataList
          .where((string) => string.toUpperCase().contains(value.toUpperCase()))
          .toList();
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
                        child: const Text('Nutrition',style: TextStyle(color: Colors.black, fontSize: 20,
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
                    height: 50,
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Row(
                        children: <Widget>[
                           Flexible(
                             child:Align(
                               alignment: Alignment.centerLeft,
                               child: Container(
                                  width: 250.0,
                                  alignment:Alignment.centerLeft,
                                    child: TextField(
                                      onChanged: onItemChanged,
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
                               ),
                             ),
                           ),
                          Flexible(
                            child:Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 100.0,
                                alignment:Alignment.centerRight,
                                child: TextField(
                                  onChanged: onItemChanged,
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 17),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    filled: true,
                                    prefixIcon:
                                    Icon(Icons.filter, color: Theme.of(context).iconTheme.color),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(Radius.circular(8))),
                                    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                    contentPadding: EdgeInsets.zero,
                                    hintText: 'Filter',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child:Align(
                              alignment: Alignment.center,
                              child: ListView(
                                children: newDataList.map((data) {
                                  return ListTile(
                                    title: Text(data),
                                    onTap: ()=> print(data),);
                                }).toList(),
                              ),
                            ),
                          ),
                        ]
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
                                child: const Text('Categories',style: TextStyle(color: Colors.black, fontSize: 20,
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
                                              builder: (context) => Categories(userId: widget.userId.toString(),))
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
                          height: 200,
                          alignment:Alignment.centerLeft,
                          child: Column(children: <Widget>[
                            Container(
                              width: 150.0,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(12.0),
                                  image: const DecorationImage(
                                      image: AssetImage('assets/Salad.png'),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              width: 150.0,
                              height: 30,
                              alignment:Alignment.center,
                              child: RichText(
                                text: const TextSpan(text: 'Salad',
                                  style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
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
                          height: 150,
                          alignment:Alignment.centerRight,
                          child: Column(children: <Widget>[
                            Container(
                              width: 150.0,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(12.0),
                                  image: const DecorationImage(
                                      image: AssetImage('assets/vegetables.png'),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              width: 150.0,
                              height: 30,
                              alignment:Alignment.center,
                              child: RichText(
                                text: const TextSpan(text: 'Vegetables',
                                  style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
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
                          height: 150,
                          alignment:Alignment.centerRight,
                          child: Column(children: <Widget>[
                            Container(
                              width: 150.0,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(12.0),
                                  image: const DecorationImage(
                                      image: AssetImage('assets/nonvegetables.png'),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              width: 150.0,
                              height: 30,
                              alignment:Alignment.center,
                              child: RichText(
                                text: const TextSpan(text: 'Non-Vegetables',
                                  style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
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
                                child: const Text('Food Items',style: TextStyle(color: Colors.black, fontSize: 20,
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
                                              builder: (context) => Nutritions(userId: widget.userId.toString()))
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
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(3),
                  ),
                  Container(
                    height: 150.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child:Align(
                              alignment: Alignment.centerLeft,
                              child:  Container(
                                width: 150.0,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(12.0),
                                    image: const DecorationImage(
                                        image: AssetImage('assets/avocado.png'),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                         Container(
                           width: 10.0,
                         ),
                          Container(
                            width: 190.0,
                            alignment:Alignment.center,
                            child: RichText(
                              text: TextSpan(text: 'Avocado Egg Toast',
                                style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                                children: [
                                  TextSpan(text: '\n 220 Cal', style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                                  ),
                                  TextSpan(text: '\nLorem psum dolor sit amet, consectetur adipiscing elit, sed'
                                      'do eiusmod tempor incididunt ut labore et dolore.', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),
                                  )
                                ],
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
                    height: 150.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child:Align(
                              alignment: Alignment.centerLeft,
                              child:  Container(
                                width: 150.0,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(12.0),
                                    image: const DecorationImage(
                                        image: AssetImage('assets/saladisland.png'),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          Container(
                            width: 10.0,
                          ),
                          Container(
                            width: 190.0,
                            alignment:Alignment.center,
                            child: RichText(
                              text: TextSpan(text: 'Salad with Many Island',
                                style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                                children: [
                                  TextSpan(text: '\n 150 Cal', style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                                  ),
                                  TextSpan(text: '\nLorem psum dolor sit amet, consectetur adipiscing elit, sed'
                                      'do eiusmod tempor incididunt ut labore et dolore.', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),
                                  )
                                ],
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
                    height: 150.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child:Align(
                              alignment: Alignment.centerLeft,
                              child:  Container(
                                width: 150.0,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(12.0),
                                    image: const DecorationImage(
                                        image: AssetImage('assets/greensalad.png'),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          Container(
                            width: 10.0,
                          ),
                          Container(
                            width: 190.0,
                            alignment:Alignment.center,
                            child: RichText(
                              text: TextSpan(text: 'Leafy Green Salad',
                                style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                                children: [
                                  TextSpan(text: '\n 100 Cal', style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                                  ),
                                  TextSpan(text: '\nLorem psum dolor sit amet, consectetur adipiscing elit, sed'
                                      'do eiusmod tempor incididunt ut labore et dolore.', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),
                                  )
                                ],
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