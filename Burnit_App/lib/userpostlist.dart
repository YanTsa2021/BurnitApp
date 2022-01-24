
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

   String _name(dynamic user){
     return user['user']['name'];

   }

  //String _location(dynamic user){
    //return user['location']['country'];
  //}

  String _time(dynamic user){
    DateTime time = DateTime.parse(user['user']['created_at']);
    return convertToAgo(time);
  }

  //String _age(Map<dynamic, dynamic> user){
   // return ": Age" + user['dob']['age'].toString();
  //}

  String _dot(Map<dynamic, dynamic> user){
     return ":" ;
  }

  String _post(Map<dynamic, dynamic> user){
    //return  user['user']['image_url'];
    //return  user['image']['feed_image_url'].toString();
    //return  user['feed_image_url'].toString();
    return  user['image_url'].toString();
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
               // padding: const EdgeInsets.all(20),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  return
                    Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                                radius: 30,
                                //backgroundImage: NetworkImage(snapshot.data[index]['picture']['large'])),
                                //backgroundImage: NetworkImage(snapshot.data[index]['image_url'])
                            ),
                            title: Text(_name(snapshot.data[index])),
                            //subtitle: Text(_location(snapshot.data[index])),
                            subtitle: Text(_time(snapshot.data[index])),
                            trailing: Text(_dot(snapshot.data[index])),
                         //: AssetImage(_post(snapshot.data[index])),
                          ),
                          Container (
                            width: 350,
                            height: 200,
                            alignment:Alignment.centerLeft,
                            decoration: BoxDecoration(
                              //color: Colors.grey,
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                                image:  DecorationImage(
                                  fit:BoxFit.fill,
                                  //image: AssetImage(_post(snapshot.data[index])),
                                  image: NetworkImage('https://picsum.photos/250?image=9'),
                                )
                            ),),


                        ],
                      ),
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
