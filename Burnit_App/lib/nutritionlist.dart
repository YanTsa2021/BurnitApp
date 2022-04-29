//User nutrition list page implementation

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image/image.dart';
import 'package:intl/intl.dart';

class UserNutritionList extends StatelessWidget{

  final String apiUrl = "http://api.burnit.socecepme.com/api/product";
  final String baseUrl = "http://api.burnit.socecepme.com/public/";
  var superheros_length;

  //Fonction to retrieve differents images post from the database
  Future<List<dynamic>> fetchUsersProducts() async {

    var response = await  http.get(Uri.parse(apiUrl));

    print("Response status: ${response.statusCode}");
    print("Response data: ${response.body}");

    if (response.statusCode == 200) {
      superheros_length = json.decode(response.body)['data']; //get all the data from json string
      print("List Length: ${superheros_length.length}");
      return json.decode(response.body)['data'];

    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  String _name (Map<dynamic, dynamic> product){
    String name = '';
    //for (int i = 0; i < superheros_length.length; i++) {
    for (int i = 0; i < product.length; i++) {
        name = product['product'][0]['name'];
    }
    return name;
  }

  String _post(Map<dynamic, dynamic> product){
    String image = '';
    //for (int i = 0; i < superheros_length.length; i++) {
    for (int i = 0; i < product.length; i++) {
        image = product['product'][0]['image_url'];
    }
    return  baseUrl + image;
  }

  String _description(Map<dynamic, dynamic> product){
    String des = '';
    //for (int i = 0; i < superheros_length.length; i++) {
    for (int i = 0; i < product.length; i++) {
        des = product['product'][0]['description'];
    }
    return des;
  }

  String _dimensionUnit (Map<dynamic, dynamic> product){
    String dimUnit = '';
    //for (int i = 0; i < superheros_length.length; i++) {
    for (int i = 0; i < product.length; i++) {
        dimUnit = product['product'][0]['dimension_unit'];
    }
    return dimUnit;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: fetchUsersProducts(),
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
                            radius: 40,
                            backgroundImage: NetworkImage(_post(snapshot.data[index])),
                          ),
                          title: Text(_name(snapshot.data[index]), style: const TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,)),
                          subtitle: Text(_dimensionUnit(snapshot.data[index])),
                        ),
                        Container (
                          width: 300,
                          height: 100,
                          alignment:Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            child: Container(
                              width: 300,
                              height: 100,
                              alignment:Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                                child: ListTile(
                                  title: Text(_description(snapshot.data[index]), style: const TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,)),
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
