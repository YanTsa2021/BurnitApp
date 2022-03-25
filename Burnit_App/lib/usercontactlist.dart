//User contact list page implementation

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserContactList extends StatelessWidget{

  // Get the processed image from the isolate.

  final String apiUrl = "http://api.burnit.socecepme.com/api/contact";
  final String baseUrl = "http://api.burnit.socecepme.com/public/";

  //Fonction to retrieve different user contact from the database
  Future<List<dynamic>> fetchUsersContacts() async {

    var response = await  http.get(Uri.parse(apiUrl));

    print("Response status: ${response.statusCode}");
    print("Response data: ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }

  }

  String _name(dynamic contact){
    return contact['name'];
  }

  String _phone(dynamic contact){
    return contact['phone'];
  }

  String _email(dynamic contact){
    return contact['email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: fetchUsersContacts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                padding: const EdgeInsets.all(6),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  return
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(_name(snapshot.data[index]), style: const TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,)),
                          subtitle: Text(_email(snapshot.data[index])),
                          trailing: Text(_phone(snapshot.data[index]), style: const TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,)),
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
