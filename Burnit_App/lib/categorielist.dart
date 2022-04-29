//User category list page implementation

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image/image.dart';
import 'package:intl/intl.dart';

class UserCategoryList extends StatelessWidget{

  // Get the processed image from the isolate.
  var image ;

  //final String apiUrl = "https://randomuser.me/api/?results=10";
  final String apiUrl = "http://api.burnit.socecepme.com/api/category";
  final String baseUrl = "http://api.burnit.socecepme.com/public/";

  //Fonction to retrieve differents images post from the database
  Future<List<dynamic>> fetchUsersPosts() async {

    var response = await  http.get(Uri.parse(apiUrl));

    print("Response status: ${response.statusCode}");
    print("Response data: ${response.body}");

    if (response.statusCode == 200) {

      return json.decode(response.body)['data'];

    } else {
      throw Exception('Unable to fetch products from the REST API');
    }

  }

  String _name(dynamic category){
    return category['name'];
  }

  String _description(dynamic category){
    return category['description'];
  }

  String _post(Map<dynamic, dynamic> category){
    return  baseUrl + category['image_url'];
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
                          title: Text(_name(snapshot.data[index]), style: const TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,)),
                          subtitle: Text(_description(snapshot.data[index])),
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
