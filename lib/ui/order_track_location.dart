import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:galeri_teknologi_bersama/data/model/myorder.dart';
import 'package:galeri_teknologi_bersama/data/model/response/directions_model.dart';
import 'package:galeri_teknologi_bersama/provider/preferences.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/menu.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/payment.provider.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:galeri_teknologi_bersama/widget/app_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:galeri_teknologi_bersama/main.dart';

class PaymentTrack extends StatefulWidget {
  static const routeName = '/paymentTrack_page';

  @override
  _PaymentTrackState createState() => _PaymentTrackState();
}

class _PaymentTrackState extends State<PaymentTrack> {
  MyOrder myOrder;
  Marker _myLocation;
  Directions _info;
  double _myLatitude;
  double _myLongitude;
  bool swabber = false;
  GoogleMapController _googleMapController;
  Timer _timer;

  _PaymentTrackState() {
    _timer = new Timer(const Duration(milliseconds: 7000), () {
      if (_myLatitude != null) {
        setState(() {
          _myLocation = Marker(
            markerId: const MarkerId('myLocation'),
            infoWindow: const InfoWindow(title: 'myLocation'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position: LatLng(_myLatitude, _myLongitude),
          );
        });
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));

        //  debugPrint(message.data.toString(), wrapWidth: 1024);
      }
      print(" =========== from onMessage.listen");
      myOrder = new MyOrder();
      print(" =========== from onMessage.listen");
      print(message.notification.title);
      debugPrint(message.data.toString(), wrapWidth: 1024);

      if (message.data['vaNumber'] != null) {
        if (mounted) {
          setState(() {
            myOrder.channel = message.data['channel'];
            myOrder.clientId = message.data['clientId'];
            myOrder.expiredTime = message.data['expiredTime'];
            myOrder.invoiceNumber = message.data['invoiceNumber'];
            myOrder.status = message.data['status'];
            myOrder.totalPrice = message.data['totalPrice'];
            myOrder.vaNumber = message.data['vaNumber'];
            swabber = true;
            print(myOrder.vaNumber + "Va  number");
          });
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      myOrder = new MyOrder();
      print(" =========== from onMessage.listen");
      print(message.notification.title);
      debugPrint(message.data.toString(), wrapWidth: 1024);

      if (message.data['vaNumber'] != null) {
        if (mounted) {
          setState(() {
            myOrder.channel = message.data['channel'];
            myOrder.clientId = message.data['clientId'];
            myOrder.expiredTime = message.data['expiredTime'];
            myOrder.invoiceNumber = message.data['invoiceNumber'];
            myOrder.status = message.data['status'];
            myOrder.totalPrice = message.data['totalPrice'];
            myOrder.vaNumber = message.data['vaNumber'];
            swabber = true;
            print(myOrder.vaNumber + "Va  number");
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var menuProvider = Provider.of<MenuProvider>(context);
    // menuProvider.setuserLocationLatitude("-6.200000");
    // menuProvider.setuserLocationLongitude("106.816666");

    _myLatitude = double.parse(menuProvider.userLocationLatitude);
    _myLongitude = double.parse(menuProvider.userLocationLongitude);

    // TODO: implement build
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(_myLatitude, _myLongitude),
            zoom: 15.5,
          ),
          onMapCreated: (controller) => _googleMapController = controller,
          markers: {
            if (_myLocation != null) _myLocation,
          },
          polylines: {
            if (_info != null)
              Polyline(
                polylineId: const PolylineId('overview_polyline'),
                color: Colors.red,
                width: 5,
                points: _info.polylinePoints
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
              ),
          },
          //onLongPress: _addMarker,
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.48,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    foregroundColor: Colors.black,
                    // onPressed: () =>

                    // _googleMapController.animateCamera(
                    //   _info != null
                    //       ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
                    //       : CameraUpdate.newCameraPosition(CameraPosition(
                    //           zoom: 17.5,
                    //           target: LatLng(
                    //             userLocation.latitude,
                    //             userLocation.longitude,
                    //           ))),
                    // ),
                    child: const Icon(Icons.center_focus_strong),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.37,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 16),
                  child: Text(
                    "Tetap pakai Masker ya",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.1,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  )
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width,
              child: swabber != true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Kami Carikan Swabber. .",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 0.1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.green,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, bottom: 10),
                          child: Text(
                            "Pesanan telah dikonfirmasi Swabber.",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 0.1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 5),
                          child: Text(
                            myOrder.invoiceNumber,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 0.1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 5),
                          child: Text(
                            "Silahkan lanjutkan Pembayaran ke rekening virtualAccount :  " +
                                myOrder.vaNumber,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 0.1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 5),
                          child: Text(
                            "Sebelum Jam " + myOrder.expiredTime,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 0.1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: AppButton(
                              text: "Lihat daftar pesanan saya",
                              type: ButtonType.PRIMARY,
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
        ),
      ],
    )

        //     Column(
        //   children: [
        //     Consumer<PaymentProvider>(builder: (context, provider, _) {
        //       if (provider.state == ResultState.Loading) {
        //         return Center(
        //           child: Padding(
        //             padding: const EdgeInsets.only(top: 100),
        //             child: RefreshProgressIndicator(),
        //           ),
        //         );
        //       } else if (provider.state == ResultState.HasData) {
        //         return Text("Check Out berhasi");
        //       } else {
        //         return Text(provider.message);
        //       }
        //     }),
        //   ],
        // )

        );
  }
}
