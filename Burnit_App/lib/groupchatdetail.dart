//Group Chat Detail page implementation

import 'package:burnit_app/basicinfoprofilepicture.dart';
import 'package:burnit_app/myprofile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'chat.dart';
import 'groupchat.dart';
import 'homepage.dart';
import 'newchat.dart';
import 'newsfeed.dart';
import 'stories.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => GroupChatDetail(),
    },
  ));
}

class GroupChatDetail extends StatelessWidget {
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
                                      builder: (context) => GroupChat()));
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
                          width: 50.0,
                          alignment:Alignment.center,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/16.jpg"),
                            maxRadius: 20,
                          ),
                        ),
                        Container(
                          width: 10.0,
                        ),
                        Container(
                          width: 230.0,
                          child: RichText(
                            text: TextSpan(text: 'Awesome We',
                              style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                              children: [
                                TextSpan(text: '\nTap for more info', style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,),

                                )
                              ],
                            ),
                          ),
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
            child: ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10,bottom: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return Container(
                  padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messages[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(messages[index].messageContent, style: TextStyle(fontSize: 15),),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(60),
            padding: EdgeInsets.all(30),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                color: Colors.white70,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Type message here",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){},
                    child: Icon(Icons.send,color: Colors.grey,size: 20,),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
          //throw UnimplementedError();
        ],
      ),
    );
  }
}

class ChatMessage{
  String messageContent;
  String messageType;
  String time;
  ChatMessage({required this.messageContent, required this.messageType, required this.time});
}
List<ChatMessage> messages = [
  ChatMessage(messageContent: "Hello, Will", messageType: "receiver", time: '08.28PM'),
  ChatMessage(messageContent: "How have you been?", messageType: "receiver", time: '08.28PM'),
  ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender", time: '08.28PM'),
  ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver", time: '08.28PM'),
  ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender", time: '08.28PM'),
];