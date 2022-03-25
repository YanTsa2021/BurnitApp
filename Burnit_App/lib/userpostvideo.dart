//User post video page implementation

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:image/image.dart';
import 'package:intl/intl.dart';

//class UserPostVideo extends StatelessWidget{
void main() => runApp(UserPostVideo());

class UserPostVideo extends StatelessWidget {
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

  final String apiUrl = "http://api.burnit.socecepme.com/api/exercise";
  final String baseUrl = "http://api.burnit.socecepme.com/public/";

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //Fonction to retrieve differents images post from the database
  Future<List<dynamic>> fetchUsersVideos() async {

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

   String _details(dynamic exercise){
      return exercise['reps'] + " Reps * " + exercise['sets'] + " Sets *" +  exercise['time']+ " Min" ;

   }

  String _name(dynamic exercise){
    return exercise['coach']['name'];
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

  String _post(Map<dynamic, dynamic> exercise){
    return  baseUrl + exercise['image_url'];
  }

  String _profileImage(Map<dynamic, dynamic> exercise){
    return  baseUrl + exercise['coach']['image_url'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: fetchUsersVideos(),
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
                          ),
                          title: Text(_name(snapshot.data[index]), style: const TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,)),
                          subtitle: Text(_time(snapshot.data[index])),
                          trailing: Text(_dot(snapshot.data[index]), style: const TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold,)),
                        ),
                        Container (
                          width: 350,
                          height: 200,
                          alignment:Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            child: Container(
                              width: 350,
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
                                 child: Stack(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: _controller.value.aspectRatio,
                                      //child: VideoPlayer(_controller),
                                      //child: VideoPlayer(VideoPlayerController.network(_post(snapshot.data[index])),),
                                      child: VideoPlayer(VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')),
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        setState(() {
                                          // pause
                                          if (_controller.value.isPlaying) {
                                            _controller.pause();
                                          } else {
                                            // play
                                            _controller.play();
                                          }
                                        });
                                      },
                                      // icon
                                      child: Icon(
                                        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                      ),
                                    ),
                                  ],
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
