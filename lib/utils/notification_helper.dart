import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper _instance;
  static int randomNumber;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  // Future<void> showNotification(
  //     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  //     ResponseJobSwabber responseJobSwabber) async {
  //   var _channelId = "1";
  //   var _channelName = "Swabber";
  //   var _channelDescription = "Swabber";

  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       _channelId, _channelName, _channelDescription,
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       ticker: 'ticker',
  //       styleInformation: DefaultStyleInformation(true, true));

  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //       iOS: iOSPlatformChannelSpecifics);

  //   var titleNotification = "<b>New Restaurant For You ..</b>";
  //   var titleNews = responseJobSwabber.request.transaction.customerName;
  //   var locationNews = articles.city;

  //   await flutterLocalNotificationsPlugin.show(0, titleNotification,
  //       titleNews + ', ' + locationNews, platformChannelSpecifics,
  //       payload: json.encode(articles.toJson()));
  // }

  // void configureSelectNotificationSubject(String route) {
  //   selectNotificationSubject.stream.listen(
  //     (String payload) async {
  //       var data = Restaurant.fromJson(json.decode(payload));
  //       var article = data;
  //       Navigation.intentWithData(route, article);
  //     },
  //   );
  // }
}
