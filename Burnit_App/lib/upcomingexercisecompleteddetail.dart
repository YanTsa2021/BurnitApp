//Upcoming exercises completed detail page implementation

import 'package:burnit_app/basicinfoprofilepicture.dart';
import 'package:burnit_app/upcomingexercisebyregular.dart';
import 'package:burnit_app/upcomingexercisescompleted.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'stories.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => UpComingExercisesCompletedDetail(),
    },
  ));
}

class UpComingExercisesCompletedDetail extends StatelessWidget {
  @override
  final String description =
      "Lorem ipsum dolar sit amet, consectetur adipiscing elit, sed do elusmod tempor incididunt ut labore etndolore magna aliqua. Ut enim ad,";
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                  child: Container(
                    margin: const EdgeInsets.only(top:2.0),
                    height: 35.0,
                    width: 350.0,
                    alignment:Alignment.center,
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
                                      builder: (context) => UpComingExercisesCompleted()));
                                },
                                child: Container(
                                  child: Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: Colors.black,),
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
                          child: const Text('Completed Exercise',style: TextStyle(color: Colors.black, fontSize: 20,
                            fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          width: 60.0,
                        ),
                      ],
                    ),
                  ),
                  preferredSize: Size.fromHeight(kToolbarHeight)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              toolbarHeight: 0.2,
            ),
            resizeToAvoidBottomInset: false, // set it to false
            body: Center(
                child: new MyCustomForm(text: description,)
            )
        )
    );
  }
}

class MyCustomForm extends StatefulWidget {
  late final String text;

  MyCustomForm({required this.text});

  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State < MyCustomForm>{
  // we get the instance of the stories class just as we would create a new instance.
  final Stories _story = Stories();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 50);
      secondHalf = widget.text.substring(50, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(3),
          ),
          Container(
            margin: const EdgeInsets.only(top:2.0),
            height: 40.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 330,
                  height: 40,
                  child: Container(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        Row(
                          children: <Widget>[
                            //_story.conversations(context),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 10.0,
                ),
                Container(
                    width: 10.0,
                    alignment:Alignment.center,
                    child: Text.rich(
                      TextSpan(text: ':', style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
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
          Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(2),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            width: 350,
            height: 200,
            alignment:Alignment.center,
            decoration: BoxDecoration(
                //color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    image: AssetImage('assets/ImgUpcomingExerciseSeven.png'),
                    )),

          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            width: 350,
            margin: const EdgeInsets.only(top:5.0),
            alignment:Alignment.centerLeft,
            child: RichText(
              text: TextSpan(text: 'Weight Lifting (150 lbs)',
                style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                children: [
                  TextSpan(text: '   12Reps * 4Sets * 10Min', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(1),
            padding: EdgeInsets.all(1),
          ),
          Container(
            width: 350,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            alignment:Alignment.centerLeft,
            child: const Text('#Caradio #Fullbody #Calarieburn',style: TextStyle(color: Colors.purple, fontSize: 16,
              fontWeight: FontWeight.bold,),),
          ),
          Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(4),
          ),
          Container(
            width: 350.0,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            alignment:Alignment.centerLeft,
            child: const Text('Details',style: TextStyle(color: Colors.black, fontSize: 20,
              fontWeight: FontWeight.bold,),),
          ),
          Container(
            width: 350.0,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            alignment:Alignment.centerLeft,
            child: new Container(
               child: secondHalf.isEmpty
               ? new Text(firstHalf)
               : new Column(
                 children: <Widget>[
                   new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf),style: TextStyle(color: Colors.black54, fontSize: 15,fontWeight: FontWeight.bold,),),
                   new InkWell(
                   child: new Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Text(
                        flag ? "Read more" : "Read less",
                        style: new TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold,),
                       ),
                     ],
                  ),
                  onTap: () {
                    setState(() {
                    flag = !flag;
                   });
                  },
                ),
             ],
            ),
           ),
          ),
          Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(4),
          ),
          Container(
            width: 350.0,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            alignment:Alignment.centerLeft,
            child: const Text('Workout Done',style: TextStyle(color: Colors.black, fontSize: 20,
              fontWeight: FontWeight.bold,),),
          ),
          Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(2),
          ),
          Container(
            margin: const EdgeInsets.only(top:0.0),
            height: 70.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  alignment:Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: AssetImage('assets/ImgCompExFour.png'),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: 10.0,
                ),
                Container(
                  width: 270.0,
                  alignment:Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(text: 'Upright Row',
                      style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text:'\n\n12Reps * 4Sets * 10Min', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(3),
          ),
          Container(
            margin: const EdgeInsets.only(top:0.0),
            height: 70.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  alignment:Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: AssetImage('assets/ImgCompExFive.png'),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: 10.0,
                ),
                Container(
                  width: 270.0,
                  alignment:Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(text: 'Lateral Stepout Squat)',
                      style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text: '\n\n12Reps * 4Sets * 10Min', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(3),
          ),
          Container(
            margin: const EdgeInsets.only(top:0.0),
            height: 70.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  alignment:Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: AssetImage('assets/ImgCompExThree.png'),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: 10.0,
                ),
                Container(
                  width: 270.0,
                  alignment:Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(text: 'Inclined Push Ups',
                      style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(text:'\n\n12Reps * 4Sets * 10Min', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //throw UnimplementedError();
        ],
      ),
    );
  }
}