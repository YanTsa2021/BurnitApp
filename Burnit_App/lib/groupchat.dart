//New Chat page implementation

import 'package:burnit_app/userchatdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'chat.dart';
import 'groupchatdetail.dart';
import 'stories.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => GroupChat(),
    },
  ));
}

class GroupChat extends StatelessWidget {
  @override
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
                                      builder: (context) => Chat()));
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
                          child: const Text('Create Group',style: TextStyle(color: Colors.black, fontSize: 20,
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
                child: MyCustomForm()
            )
        )
    );
  }
}

class MyCustomForm extends StatefulWidget {
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
  bool valuefirst = false;
  bool valuesecond = false;
  bool valuethird = false;
  bool valuefour = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(4),
          ),
          Container(
            margin: const EdgeInsets.only(top:2.0),
            height: 50.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://randomuser.me/api/portraits/men/16.jpg"),
                            fit: BoxFit.cover)),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return GroupChatDetail();
                        }));
                      },
                    )
                ),
                Container(
                  width: 20.0,
                ),
                Container(
                  width: 290.0,
                  height: 50,
                  child: Container(
                    margin: const EdgeInsets.only(top:5.0),
                    alignment:Alignment.centerLeft,
                    child: TextField(
                      maxLines: 1,
                      style: TextStyle(fontSize: 17),
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
                        hintText: 'Enter Group name here',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          ),
          Container(
            width: 350.0,
            alignment:Alignment.centerLeft,
            child: const Text('Participants (3)',style: TextStyle(color: Colors.black, fontSize: 20,
              fontWeight: FontWeight.bold,),),
          ),
          Container(
            margin: const EdgeInsets.only(top:2.0),
            height: 50.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://randomuser.me/api/portraits/women/11.jpg"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: 20.0,
                ),
                Container(
                  width: 40.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://randomuser.me/api/portraits/men/12.jpg"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: 20.0,
                ),
                Container(
                  width: 40.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://randomuser.me/api/portraits/women/15.jpg"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: 190.0,
                  height: 50,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          ),
          Container(
            width: 350.0,
            alignment:Alignment.centerLeft,
            child: const Text('All Members (98)',style: TextStyle(color: Colors.black, fontSize: 20,
              fontWeight: FontWeight.bold,),),
          ),
          Container(
            margin: const EdgeInsets.only(top:2.0),
            height: 50.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://randomuser.me/api/portraits/women/11.jpg"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: 20.0,
                ),
                Container(
                  width: 100.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  child: const Text('Carla Geidt',style: TextStyle(color: Colors.black, fontSize: 16,
                    fontWeight: FontWeight.bold,),),

                ),
                Container(
                  width: 160.0,
                ),
                Container(
                  width: 40.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  child:  GFCheckbox(
                    size: GFSize.SMALL,
                    type: GFCheckboxType.circle,
                    activeBgColor: Colors.green,
                    value: this.valuefirst,
                    onChanged: (value) {
                      setState(() {
                        this.valuefirst = value;
                      });
                    },
                    inactiveIcon: null,
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
            margin: const EdgeInsets.only(top:2.0),
            height: 50.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://randomuser.me/api/portraits/men/12.jpg"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: 20.0,
                ),
                Container(
                  width: 100.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  child: const Text('Justin Donin',style: TextStyle(color: Colors.black, fontSize: 16,
                    fontWeight: FontWeight.bold,),),

                ),
                Container(
                  width: 160.0,
                ),
                Container(
                  width: 40.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  child:  GFCheckbox(
                    size: GFSize.SMALL,
                    type: GFCheckboxType.circle,
                    activeBgColor: Colors.green,
                    value: this.valuesecond,
                    onChanged: (value) {
                      setState(() {
                        this.valuesecond = value;
                      });
                    },
                    inactiveIcon: null,
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
            margin: const EdgeInsets.only(top:2.0),
            height: 50.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://randomuser.me/api/portraits/women/15.jpg"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: 20.0,
                ),
                Container(
                  width: 100.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  child: const Text('Aspen Dokidls',style: TextStyle(color: Colors.black, fontSize: 16,
                    fontWeight: FontWeight.bold,),),

                ),
                Container(
                  width: 160.0,
                ),
                Container(
                  width: 40.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  child:  GFCheckbox(
                    size: GFSize.SMALL,
                    type: GFCheckboxType.circle,
                    activeBgColor: Colors.green,
                    value: this.valuethird,
                    onChanged: (value) {
                      setState(() {
                        this.valuethird = value;
                      });
                    },
                    inactiveIcon: null,
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
            margin: const EdgeInsets.only(top:2.0),
            height: 50.0,
            width: 350.0,
            alignment:Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://randomuser.me/api/portraits/women/17.jpg"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  width: 20.0,
                ),
                Container(
                  width: 100.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  child: const Text('Nolan Workman',style: TextStyle(color: Colors.black, fontSize: 16,
                    fontWeight: FontWeight.bold,),),

                ),
                Container(
                  width: 160.0,
                ),
                Container(
                  width: 40.0,
                  height: 40,
                  alignment:Alignment.centerLeft,
                  child:  GFCheckbox(
                    size: GFSize.SMALL,
                    type: GFCheckboxType.circle,
                    activeBgColor: Colors.green,
                    value: this.valuefour,
                    onChanged: (value) {
                      setState(() {
                        this.valuefour = value;
                      });
                    },
                    inactiveIcon: null,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            padding: EdgeInsets.all(25),
          ),
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(5),
            height: 44.0,
            width: 350.0,
            alignment:Alignment.center,
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(8.0),),
            child: new RaisedButton(
              elevation: 0,
              textColor: Colors.white,
              color: Colors.purple,
              child: const Text('Create Group',style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                textBaseline: TextBaseline.alphabetic,
              ),),
              onPressed: () {
              },
            ),
          ),
          //throw UnimplementedError();
        ],
      ),
    );
  }
}