import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'network_aware_widget.dart';
import 'network_status_service.dart';
import 'dart:async';

class CheckConnectivity extends StatelessWidget {
  const CheckConnectivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamProvider <NetworkStatus>(
        create: (context) =>
        NetworkStatusService().networkStatusController.stream,
        initialData: NetworkStatus.Offline,
        //initialData: NetworkStatus.Online,
        child: NetworkAwareWidget(
          onlineChild: Container(
            //height: 20.0,
            width: 350.0,
            alignment:Alignment.center,
            child: Center(
              //child: Text(
                //"You are online",
                //style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
             // ),
            ),
          ),
          offlineChild: Container(
            //height: 20.0,
            width: 350.0,
            alignment:Alignment.center,
            child: Center(
              child: Text(
                "No internet connection!",
                style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}