//User post list page implementation

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image/image.dart';
import 'package:intl/intl.dart';

class UserPostList extends StatelessWidget{

  // Get the processed image from the isolate.
  var image ;

  //final String apiUrl = "https://randomuser.me/api/?results=10";
  final String apiUrl = "http://api.burnit.socecepme.com/api/feed";
  final String baseUrl = "http://api.burnit.socecepme.com/public/";

  //Fonction to retrieve differents images post from the database
  Future<List<dynamic>> fetchUsersPosts() async {

    var response = await  http.get(Uri.parse(apiUrl));

    print("Response status: ${response.statusCode}");
    print("Response data: ${response.body}");

    if (response.statusCode == 200) {

      //return json.decode(response.body)['results'];
      return json.decode(response.body)['data'];

    } else {
      throw Exception('Unable to fetch products from the REST API');
    }

  }
  //Fonction to convert date to time ago
  String convertToAgo(DateTime input){
    Duration diff = DateTime.now().difference(input);

    if(diff.inDays >= 1){
      return '${diff.inDays} day(s) ago';
    } else if(diff.inHours >= 1){
      return '${diff.inHours} hour(s) ago';
    } else if(diff.inMinutes >= 1){
      return '${diff.inMinutes} minute(s) ago';
    } else if (diff.inSeconds >= 1){
      return '${diff.inSeconds} second(s) ago';
    } else {
      return 'just now';
    }
  }

 // String _name(dynamic user){
    //return user['name']['title'] + " " + user['name']['first'] + " " +  user['name']['last'];

 // }

   String _name(dynamic post){
     return post['user']['name'];

   }

  String _time(dynamic post){
    DateTime time = DateTime.parse(post['created_at']);
    return convertToAgo(time);
  }

  //String _age(Map<dynamic, dynamic> user){
   // return ": Age" + user['dob']['age'].toString();
  //}

  String _dot(Map<dynamic, dynamic> post){
     return ":" ;
  }

  String _post(Map<dynamic, dynamic> post){
    return  baseUrl + post['image_url'];
  }

  String _profileImage(Map<dynamic, dynamic> post){
    return  baseUrl + post['user']['profile']['profile_image_url'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: fetchUsersPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            //print(_dot(snapshot.data[0]));
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  return
                       Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(_profileImage(snapshot.data[index])),
                                //backgroundImage:  NetworkImage('https://picsum.photos/250?image=9'),
                            ),
                            title: Text(_name(snapshot.data[index]), style: const TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,)),
                            subtitle: Text(_time(snapshot.data[index])),
                            trailing: Text(_dot(snapshot.data[index]), style: const TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold,)),
                          ),
                          Container (
                            width: 430,
                            height: 200,
                            alignment:Alignment.center,
                              child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                child: Container(
                                  width: 430,
                                  height: 200,
                                  alignment:Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  shape: BoxShape.rectangle,
                                    image:  DecorationImage(
                                      fit:BoxFit.fill,
                                      image: NetworkImage(_post(snapshot.data[index])),
                                    ),
                                  ),
                              ),
                            ),
                          ),
                        ],
                      );
                });
          }else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

}
