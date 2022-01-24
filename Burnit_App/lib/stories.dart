//Stories session implementation

import 'dart:io';

import 'package:burnit_app/addstory.dart';
import 'package:burnit_app/groupchat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'homepage.dart';
import 'newchat.dart';


class Stories {
  List storyList = [
  {
    "name": "Novac",
    "imageUrl": "https://randomuser.me/api/portraits/men/31.jpg",
    "isOnline": true,
    "hasStory": true,
  },
  {
    "name": "Derick",
    "imageUrl": "https://randomuser.me/api/portraits/men/81.jpg",
    "isOnline": false,
    "hasStory": false,
  },
  {
    "name": "Mevis",
    "imageUrl": "https://randomuser.me/api/portraits/women/49.jpg",
    "isOnline": true,
    "hasStory": false,
  },
  {
    "name": "Emannual",
    "imageUrl": "https://randomuser.me/api/portraits/men/35.jpg",
    "isOnline": true,
    "hasStory": true,
  },
  {
    "name": "Gracy",
    "imageUrl": "https://randomuser.me/api/portraits/women/56.jpg",
    "isOnline": false,
    "hasStory": false,
  },
  {
    "name": "Robert",
    "imageUrl": "https://randomuser.me/api/portraits/men/36.jpg",
    "isOnline": false,
    "hasStory": true,
  }
];
  List conversationList = [
    {
      "name": "Novac",
      "imageUrl": 'https://randomuser.me/api/portraits/men/31.jpg',
      "isOnline": true,
      "hasStory": true,
      //"message": "Where are you?",
      //"time": "5:00 pm"
    },
  ];

  List chatList = [
    {
      "name": "Derick",
      "imageUrl": "https://randomuser.me/api/portraits/men/81.jpg",
      "isOnline": true,
      "hasStory": true,
      "message": "It's good!!",
      "time": "7:00 am"
    },
    {
      "name": "Mevis",
      "imageUrl": "https://randomuser.me/api/portraits/women/49.jpg",
      "isOnline": true,
      "hasStory": true,
      "message": "I love You too!",
      "time": "6:50 am"
    },
    {
      "name": "Emannual",
      "imageUrl": "https://randomuser.me/api/portraits/men/35.jpg",
      "isOnline": true,
      "hasStory": true,
      "message": "Got to go!! Bye!!",
      "time": "yesterday"
    },
    {
      "name": "Gracy",
      "imageUrl": "https://randomuser.me/api/portraits/women/56.jpg",
      "isOnline": true,
      "hasStory": true,
      "message": "Sorry, I forgot!",
      "time": "2nd Feb"
    },
    {
      "name": "Robert",
      "imageUrl": "https://randomuser.me/api/portraits/men/36.jpg",
      "isOnline": true,
      "hasStory": true,
      "message": "No, I won't go!",
      "time": "28th Jan"
    },
  ];

  stories(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 0),
            child: Column(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                        width: 0.3,
                      ),
                      shape: BoxShape.circle,
                      //color: Color(0xFFe9eaec)
                     ),
                  child: Center(
                    child: IconButton(icon: const Icon(Icons.add, color: Colors.purple,), iconSize: 33,
                        onPressed: ()
                        {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => AddStory()));
                        }
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 75,
                  child: Align(
                      child: Text(
                        'Add story',
                        overflow: TextOverflow.ellipsis,
                      )),
                )
              ],
            ),
          ),
          Row(
              children: List.generate(storyList.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 50,
                        child: Stack(
                          children: <Widget>[
                            storyList[index]['hasStory']
                                ? Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.blueAccent, width: 3)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              storyList[index]['imageUrl']),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                            )
                                : Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          storyList[index]['imageUrl']),
                                      fit: BoxFit.cover)),
                            ),
                            storyList[index]['isOnline']
                                ? Positioned(
                              top: 38,
                              left: 42,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Color(0xFF66BB6A),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Color(0xFFFFFFFF), width: 3)),
                              ),
                            )
                                : Container()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 75,
                        child: Align(
                            child: Text(
                              storyList[index]['name'],
                              overflow: TextOverflow.ellipsis,
                            )),
                      )
                    ],
                  ),
                );
              }))
        ],
      ),
    );
  }
  conversations(BuildContext context) {
    return Column(
      children: List.generate(conversationList.length, (index) {
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: <Widget>[
                      conversationList[index]['hasStory'] ?
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                            Border.all(color: Colors.blueAccent, width: 3)),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        conversationList[index]['imageUrl']),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      )
                          : Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    conversationList[index]['imageUrl']),
                                fit: BoxFit.cover)),
                      ),
                      conversationList[index]['isOnline']
                          ? Positioned(
                        top: 38,
                        left: 42,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Color(0xFF66BB6A),
                              shape: BoxShape.circle,
                              border: Border.all(color: Color(0xFFFFFFFF), width: 3)),
                        ),
                      )
                          : Container()
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      conversationList[index]['name'],
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //SizedBox(
                     // width: MediaQuery.of(context).size.width - 135,
                      //child: Text(
                        //conversationList[index]['message'] +
                           // " - " +
                            //conversationList[index]['time'],
                        //style: TextStyle(
                           // fontSize: 15, color: Color(0xFF000000).withOpacity(0.7)),
                        //overflow: TextOverflow.ellipsis,
                      //),
                    //)
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  chat(BuildContext context) {
    return Column(
      children: List.generate(chatList.length, (index) {
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  child: Stack(
                    children: <Widget>[
                      chatList[index]['hasStory'] ?
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                            Border.all(color: Colors.blueAccent, width: 3)),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        chatList[index]['imageUrl']),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      )
                          : Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    chatList[index]['imageUrl']),
                                fit: BoxFit.cover)),
                      ),
                      chatList[index]['isOnline']
                          ? Positioned(
                        top: 38,
                        left: 42,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Color(0xFF66BB6A),
                              shape: BoxShape.circle,
                              border: Border.all(color: Color(0xFFFFFFFF), width: 3)),
                        ),
                      )
                          : Container()
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      chatList[index]['name'],
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 135,
                      child: Text(
                        chatList[index]['message'] +
                            " - " +
                            chatList[index]['time'],
                        style: TextStyle(
                            fontSize: 15, color: Color(0xFF000000).withOpacity(0.7)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  //New chat option for starting new chat as a personnal or group
  void chatOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 180.0,
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top:2.0),
                  height: 35.0,
                  width: 150.0,
                  alignment:Alignment.center,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        alignment:Alignment.center,
                        child: const Text('New Group',style: TextStyle(color: Colors.black54, fontSize: 16,
                          fontWeight: FontWeight.bold,),),
                      ),
                      Container(
                        width: 15.0,
                      ),
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
                                child: Icon(Icons.group_outlined,size: 18, color: Colors.black54,),
                              ),
                            )
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
                  height: 35.0,
                  width: 150.0,
                  alignment:Alignment.center,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        alignment:Alignment.center,
                        child: const Text('New Chat',style: TextStyle(color: Colors.black54, fontSize: 16,
                          fontWeight: FontWeight.bold,),),
                      ),
                      Container(
                        width: 15.0,
                      ),
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
                                    builder: (context) => NewChat()));
                              },
                              child: Container(
                                child: Icon(Icons.person,size: 18, color: Colors.black54,),
                              ),
                            )
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
                  height: 35.0,
                  width: 150.0,
                  alignment:Alignment.center,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        alignment:Alignment.center,
                        child: const Text('Exit',style: TextStyle(color: Colors.white70, fontSize: 16,
                          fontWeight: FontWeight.bold,),),
                      ),
                      Container(
                        width: 15.0,
                      ),
                      Container(
                        width: 35.0,
                        alignment:Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                            width: 35.0,
                            alignment:Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                   builder: (context) => Chat()));
                                  //exit(0);
                              },
                              child: Container(
                                child: Icon(Icons.close,size: 18, color: Colors.white70,),
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}