//User get video by regular page implementation

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:better_player/better_player.dart';
import 'dart:convert';


//class UserGetVideoByRegular extends StatelessWidget{
void main() => runApp(UserGetVideoByRegular());

class UserGetVideoByRegular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  //const VideoPlayerScreen({required Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  final String apiUrl = "http://api.burnit.socecepme.com/api/exercise/getByUser/User";
  final String baseUrl = "http://api.burnit.socecepme.com/public/";

  VideoPlayerController? _controller;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  //Fonction to retrieve differents images post from the database
  Future<List<dynamic>> fetchUsersVideos() async {

    var response = await  http.get(Uri.parse(apiUrl));

    print("Response status: ${response.statusCode}");
    print("Response data: ${response.body}");

    if (response.statusCode == 200) {

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

  String _details(dynamic exercise){
    return exercise['reps'] + " Reps * " + exercise['sets'] + " Sets *" +  exercise['time']+ " Min" ;
  }

  String _name(dynamic exercise){
    return exercise['user']['name'];
  }

  String _description(dynamic exercise){
    return exercise['description'];
  }

  String _time(dynamic exercise){
    DateTime time = DateTime.parse(exercise['created_at']);
    return convertToAgo(time);
  }

  String _dot(Map<dynamic, dynamic> exercise){
    return ":" ;
  }

  String _profileImage(Map<dynamic, dynamic> exercise){
    return  baseUrl + exercise['user']['profile']['profile_image_url'];
  }

  String _post(Map<dynamic, dynamic> exercise){
    print("Video Image Post Dynamic: ${ baseUrl + exercise['image_url']}");
    return  baseUrl + exercise['image_url'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: fetchUsersVideos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  return
                    Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(_profileImage(snapshot.data[index])),
                          ),
                          title: Text(_name(snapshot.data[index]), style: const TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,)),
                          subtitle: Text(_time(snapshot.data[index])),
                          trailing: Text(_dot(snapshot.data[index]), style: const TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold,)),
                        ),
                        Container (
                          width: 440,
                          height: 200,
                          alignment:Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                            child: Container(
                              width: 440,
                              height: 200,
                              alignment:Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                width: 350.0,
                                height: 200.0,
                                alignment:Alignment.center,
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: BetterPlayer.network(_post(snapshot.data[index]),
                                    betterPlayerConfiguration: const BetterPlayerConfiguration(
                                      aspectRatio: 16 / 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(_description(snapshot.data[index]), style: const TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,)),
                          trailing: Text(_details(snapshot.data[index]), style: const TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold,)),
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
