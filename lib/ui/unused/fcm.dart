import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LalaSwitchPage extends StatefulWidget {
  static const routeName = '/lala_page';

  @override
  _LalaSwitchPageState createState() => _LalaSwitchPageState();
}

class _LalaSwitchPageState extends State<LalaSwitchPage> {
  FirebaseMessaging messaging;
  TextEditingController tokensaya = new TextEditingController();

  @override
  void initState() {
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print(value);
      tokensaya.text = value;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification.body);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("FCM"),
              content: ListView(
                children: [
                  Text("Title : " + event.notification.title),
                  Text("Body : " + event.notification.body),
                  Text("Data : " + event.data.toString()),
                ],
              ),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Test FCM"),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            TextField(
              controller: tokensaya,
            )
          ],
        ));
  }
}
