import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryPageView extends StatefulWidget {
  @override
  _StoryPageViewState createState() => _StoryPageViewState();
}

class _StoryPageViewState extends State<StoryPageView> {
  final controller = StoryController();

  @override
  Widget build(BuildContext context) {
    final List<StoryItem> storyItems = [
      StoryItem.text(title: '''“When you talk, you are only repeating something you know.
       But if you listen, you may learn something new.” 
       – Dalai Lama''',
          backgroundColor: Colors.blueGrey),
      StoryItem.pageImage(
          url:
          "https://images.unsplash.com/photo-1553531384-cc64ac80f931?ixid=MnwxMjA3fDF8MHxzZWFyY2h8MXx8bW91bnRhaW58ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
          controller: controller),
      StoryItem.pageImage(
          url:
          "https://wp-modula.com/wp-content/uploads/2018/12/gifgif.gif",
          controller: controller,
          imageFit: BoxFit.contain),
    ];
    return Material(
      child: Stack(
        children: <Widget>[
          StoryView(
            storyItems: storyItems,
            controller: controller,
            inline: false,
            repeat: true,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: 350,
              //color: Colors.grey,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: <Widget>[
                 // GestureDetector(
                    //onTap: (){
                   // },
                   // child: Container(
                      //height: 30,
                      //width: 30,
                      //decoration: BoxDecoration(
                        //color: Colors.lightBlue,
                        //borderRadius: BorderRadius.circular(30),
                      //),
                      //child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    //),
                  //),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Send message",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){},
                    child: Icon(Icons.send,color: Colors.white,size: 20,),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    );

  }
}