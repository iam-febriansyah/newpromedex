import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:galeri_teknologi_bersama/data/model/historyorder.dart';
import 'package:galeri_teknologi_bersama/data/model/myorder.dart';
import 'package:galeri_teknologi_bersama/data/model/response/directions_model.dart';
import 'package:galeri_teknologi_bersama/data/remote/speedlab/directions_repository.dart';
import 'package:galeri_teknologi_bersama/provider/order_database.provider.dart';
import 'package:galeri_teknologi_bersama/provider/preferences.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/menu.provider.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/payment.provider.dart';
import 'package:galeri_teknologi_bersama/ui/navigasi.page.dart';
import 'package:galeri_teknologi_bersama/ui/order_history.page.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:galeri_teknologi_bersama/widget/app_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:galeri_teknologi_bersama/main.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class PaymentTrack extends StatefulWidget {
  static const routeName = '/paymentTrack_page';

  @override
  _PaymentTrackState createState() => _PaymentTrackState();
}

class _PaymentTrackState extends State<PaymentTrack>
    with WidgetsBindingObserver {
  final oCcy = new NumberFormat("#,##0", "en_US");

  MyOrder myOrder;
  Marker _myLocation;
  Directions _info;
  bool directionLine = false;
  double _myLatitude;
  double _myLongitude;
  bool swabber = false;
  GoogleMapController _googleMapController;
  Timer _timer;
  String invoice = "";
  String idswabber = "";

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
    WidgetsBinding.instance.addObserver(this);

    //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //     RemoteNotification notification = message.notification;
    //     AndroidNotification android = message.notification?.android;
    //     if (notification != null && android != null && !kIsWeb) {
    //       flutterLocalNotificationsPlugin.show(
    //           notification.hashCode,
    //           notification.title,
    //           notification.body,
    //           NotificationDetails(
    //             android: AndroidNotificationDetails(
    //               channel.id,
    //               channel.name,
    //               channel.description,
    //               // TODO add a proper drawable resource to android, for now using
    //               //      one that already exists in example app.
    //               icon: 'launch_background',
    //             ),
    //           ));

    //       //  debugPrint(message.data.toString(), wrapWidth: 1024);
    //     }
    //     myOrder = new MyOrder();
    //     print(" ==Order Track========= from onMessage.listen");
    //     print(message.notification.title);
    //     debugPrint(message.data.toString(), wrapWidth: 1024);

    //     if (message.data['vaNumber'] != null) {
    //       if (mounted) {
    //         setState(() {
    //           myOrder.channel = message.data['channel'];
    //           myOrder.clientId = message.data['clientId'];
    //           myOrder.expiredTime = message.data['expiredTime'];
    //           myOrder.invoiceNumber = message.data['invoiceNumber'];
    //           myOrder.status = message.data['status'];
    //           myOrder.totalPrice = message.data['totalPrice'];
    //           myOrder.vaNumber = message.data['vaNumber'];
    //           swabber = true;
    //           print(myOrder.vaNumber + "Va  number");
    //         });
    //       }
    //     }
    //   });

    //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    //     myOrder = new MyOrder();
    //     print(" =========== from onMessage.listen");
    //     print(message.notification.title);
    //     debugPrint(message.data.toString(), wrapWidth: 1024);

    //     if (message.data['vaNumber'] != null) {
    //       if (mounted) {
    //         setState(() {
    //           myOrder.channel = message.data['channel'];
    //           myOrder.clientId = message.data['clientId'];
    //           myOrder.expiredTime = message.data['expiredTime'];
    //           myOrder.invoiceNumber = message.data['invoiceNumber'];
    //           myOrder.status = message.data['status'];
    //           myOrder.totalPrice = message.data['totalPrice'];
    //           myOrder.vaNumber = message.data['vaNumber'];
    //           swabber = true;
    //           print(myOrder.vaNumber + "Va  number");
    //         });
    //       }
    //     }
    //   });
  }

  @override
  Widget build(BuildContext context) {
    var menuProvider = Provider.of<MenuProvider>(context);
    var paymentProvider = Provider.of<PaymentProvider>(context);

    paymentProvider.responsePaymenthomecare;

    if (paymentProvider.responsePaymenthomecare != null) {
      invoice = paymentProvider.responsePaymenthomecare.data.invoiceNumber;
    }
    // menuProvider.setuserLocationLatitude("-6.200000");
    // menuProvider.setuserLocationLongitude("106.816666");

    _myLatitude = double.parse(menuProvider.userLocationLatitude);
    _myLongitude = double.parse(menuProvider.userLocationLongitude);

    // TODO: implement build
    return Scaffold(
        body: Stack(
      children: [
        fetchSwabber(),
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
                color: Colors.blue,
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
            height: MediaQuery.of(context).size.height * 0.58,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    onPressed: () => _googleMapController.animateCamera(
                      _info != null
                          ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
                          : CameraUpdate.newCameraPosition(CameraPosition(
                              zoom: 17.5,
                              target: LatLng(
                                _myLatitude,
                                _myLongitude,
                              ))),
                    ),
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
            height: MediaQuery.of(context).size.height * 0.47,
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
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.9),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        height: 3,
                        width: 50,
                      ),
                    ),
                    notifOrder(),
                  ],
                ))

            // swabber != true
            //     ? Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Center(
            //             child: Container(
            //               margin: EdgeInsets.only(top: 10),
            //               decoration: BoxDecoration(
            //                 color: Colors.green.withOpacity(0.9),
            //                 borderRadius: BorderRadius.only(
            //                   topRight: Radius.circular(30),
            //                   topLeft: Radius.circular(30),
            //                   bottomLeft: Radius.circular(30),
            //                   bottomRight: Radius.circular(30),
            //                 ),
            //               ),
            //               height: 3,
            //               width: 50,
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(20.0),
            //             child: Text(
            //               "Kami Carikan Swabber. .",
            //               style: GoogleFonts.poppins(
            //                 textStyle: TextStyle(
            //                     color: Colors.black,
            //                     letterSpacing: 0.1,
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.w700),
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(40.0),
            //             child: Center(
            //               child: CircularProgressIndicator(
            //                 backgroundColor: Colors.green,
            //                 valueColor:
            //                     AlwaysStoppedAnimation<Color>(Colors.white),
            //               ),
            //             ),
            //           )
            //         ],
            //       )
            //     : Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Center(
            //             child: Container(
            //               margin: EdgeInsets.only(top: 10),
            //               decoration: BoxDecoration(
            //                 color: Colors.grey,
            //                 borderRadius: BorderRadius.only(
            //                   topRight: Radius.circular(30),
            //                   topLeft: Radius.circular(30),
            //                   bottomLeft: Radius.circular(30),
            //                   bottomRight: Radius.circular(30),
            //                 ),
            //                 boxShadow: const [
            //                   BoxShadow(
            //                     color: Colors.black26,
            //                     offset: Offset(0, 2),
            //                     blurRadius: 6.0,
            //                   )
            //                 ],
            //               ),
            //               height: 3,
            //               width: 50,
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(
            //                 top: 20, left: 20, bottom: 10),
            //             child: Text(
            //               "Pesanan telah dikonfirmasi Swabber.",
            //               style: GoogleFonts.poppins(
            //                 textStyle: TextStyle(
            //                     color: Colors.black,
            //                     letterSpacing: 0.1,
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.w700),
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 25, top: 5),
            //             child: Text(
            //               myOrder.invoiceNumber,
            //               style: GoogleFonts.poppins(
            //                 textStyle: TextStyle(
            //                     color: Colors.black,
            //                     letterSpacing: 0.1,
            //                     fontSize: 14,
            //                     fontWeight: FontWeight.w500),
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 25, top: 5),
            //             child: Text(
            //               "Silahkan lanjutkan Pembayaran ke rekening virtualAccount :  " +
            //                   myOrder.vaNumber,
            //               style: GoogleFonts.poppins(
            //                 textStyle: TextStyle(
            //                     color: Colors.black,
            //                     letterSpacing: 0.1,
            //                     fontSize: 14,
            //                     fontWeight: FontWeight.w400),
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 25, top: 5),
            //             child: Text(
            //               "Sebelum Jam " + myOrder.expiredTime,
            //               style: GoogleFonts.poppins(
            //                 textStyle: TextStyle(
            //                     color: Colors.black,
            //                     letterSpacing: 0.1,
            //                     fontSize: 14,
            //                     fontWeight: FontWeight.w400),
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 5,
            //           ),
            //           Expanded(
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 20),
            //               child: AppButton(
            //                 text: "Lihat daftar pesanan saya",
            //                 type: ButtonType.PRIMARY,
            //                 onPressed: () {},
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //         ],
            //       )),
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

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget fetchSwabber() {
    return Consumer<MenuProvider>(builder: (context, provider, _) {
      if (provider.stateListSwabber == ResultState.Loading) {
        return Center(child: CircularProgressIndicator());
      } else if (provider.stateListSwabber == ResultState.HasData) {
        return ListView.builder(
            // physics: NeverScrollableScrollPhysics(),

            shrinkWrap: true,
            itemCount: provider.responseListSwabber.listSwabbers.length,
            itemBuilder: (context, index) {
              //

              var swabberlatitude =
                  provider.responseListSwabber.listSwabbers[index].latitude;
              var swabberlongitude =
                  provider.responseListSwabber.listSwabbers[index].longitude;

              print("indexid swabber" +
                  provider.responseListSwabber.listSwabbers[index].id +
                  " " +
                  "swabber long : " +
                  swabberlongitude);

              if (provider.responseListSwabber.listSwabbers[index].id ==
                      idswabber &&
                  swabberlatitude != "") {
                // print("=======================     kepanggil");
                // print("heheheheeh" +
                //     provider.responseListSwabber.listSwabbers[index].id +
                //     " " +
                //     idswabber);
                Future.delayed(Duration.zero, () async {
                  if (directionLine == false) {
                    final directions = await DirectionsRepository()
                        .getDirections(
                            origin: LatLng(_myLatitude, _myLongitude),
                            destination: LatLng(double.parse(swabberlatitude),
                                double.parse(swabberlongitude)));

                    setState(() {
                      _info = directions;
                      directionLine = true;
                    });
                  }
                });
              }

              return Text("");
            });
      } else {
        return Text("");
      }
    });
  }

  Widget notifOrder() {
    return Consumer<DatabaseHistoryOrderProvider>(
      builder: (context, provider, _) {
        if (provider.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.HasData) {
          return ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: provider.bookmarks.length,
            itemBuilder: (context, index) {
              var data = provider.bookmarks[index];

              return FutureBuilder<bool>(
                  future: provider.isBookmarked(data.id.toString()),
                  builder: (context, snapshot) {
                    var isBookmarked = snapshot.data ?? false;

                    //  print("data invoice:" + data.invoiceNumber);
                    // print("invoice     :" + invoice);

                    if (invoice == data.invoiceNumber) {
                      idswabber = data.idswabber;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Swabber ditemukan!",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 0.1,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  child: Text("Total Pembayaran ")),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 2),
                                child: Text(
                                  "Rp. " + oCcy.format(data.totalPrice),
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.blueGrey,
                                        letterSpacing: 0.1,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                              margin:
                                  EdgeInsets.only(top: 5, bottom: 10, left: 20),
                              child: Text("No. Rekening " + data.channel + "")),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 2),
                                child: Text(
                                  data.vaNumber,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  ClipboardData datacpy =
                                      ClipboardData(text: data.invoiceNumber);
                                  await Clipboard.setData(datacpy);
                                  snackBar("Berhasil Disalin . .");
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 2),
                                  child: Text(
                                    "SALIN",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.deepOrangeAccent,
                                          letterSpacing: 1,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: AppButton(
                              text: "Lihat riwayat transaksi",
                              type: ButtonType.PRIMARY,
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    OrderHistory.routeName,
                                    ModalRoute.withName(NavPage.routeName));
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Padding(padding: EdgeInsets.all(0));
                      // return Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       margin: EdgeInsets.symmetric(
                      //           horizontal: 15, vertical: 0),
                      //       child: Text(
                      //         "Mencari Swabber . . .",
                      //         style: GoogleFonts.poppins(
                      //           textStyle: TextStyle(
                      //               color: Colors.black,
                      //               letterSpacing: 0.1,
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.w600),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 50,
                      //     ),
                      //     Center(
                      //       child: CircularProgressIndicator(
                      //         backgroundColor: Colors.green,
                      //         valueColor:
                      //             AlwaysStoppedAnimation<Color>(Colors.white),
                      //       ),
                      //     ),
                      //   ],
                      // );
                    }
                  });
            },
          );
        } else if (provider.state == ResultState.Error) {
          return Center(
              child: Text(
            provider.message,
            textAlign: TextAlign.center,
          ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        _googleMapController.setMapStyle("[]");
        print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState detached');
        break;
    }
  }
}
