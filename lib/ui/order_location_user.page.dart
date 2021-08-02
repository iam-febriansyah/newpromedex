import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/model/dataorder.dart';
import 'package:galeri_teknologi_bersama/data/model/response/directions_model.dart';
import 'package:galeri_teknologi_bersama/data/model/response/merchant.dart';
import 'package:galeri_teknologi_bersama/data/model/user.location.dart';
import 'package:galeri_teknologi_bersama/data/remote/speedlab/directions_repository.dart';
import 'package:galeri_teknologi_bersama/helper/location.service.dart';
import 'package:galeri_teknologi_bersama/provider/speedlab/menu.provider.dart';
import 'package:galeri_teknologi_bersama/ui/order_profil.page.dart';
import 'package:galeri_teknologi_bersama/widget/app_button.dart';
import 'package:galeri_teknologi_bersama/widget/input_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationUserPage extends StatefulWidget {
  static const routeName = '/LocationUser_Page';
  final Merchant merchant;

  const LocationUserPage({Key key, this.merchant}) : super(key: key);

  @override
  _LocationUserPageState createState() => _LocationUserPageState();
}

class _LocationUserPageState extends State<LocationUserPage> {
  DataOrderTransaction transaction = new DataOrderTransaction();
  DataOrder dataOrder = new DataOrder();

  TextEditingController address = new TextEditingController();
  TextEditingController info = new TextEditingController();

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(-6.200000, 106.816666),
    zoom: 15.5,
  );

  GoogleMapController _googleMapController;

  Marker _myLocation;

  Marker _origin;
  Marker _destination;
  Directions _info;
  BitmapDescriptor myIcon;

  LocationService _locationService = LocationService();
  UserLocation userLocation = UserLocation();

  double _latitude;
  double _longitude;
  LatLng _locationCamera;

  @override
  void dispose() {
    _googleMapController.dispose();
    _locationService.dispose();
    super.dispose();
  }

  @override
  void initState() {}

  void onCameraMove(CameraPosition cameraPosition) {
    _locationCamera = cameraPosition.target;
    // print(_locationCamera);
  }

  bool isFinish = false;
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            onCameraMove: onCameraMove,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_origin != null) _origin,
              if (_destination != null) _destination,
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
          Align(
            alignment: Alignment.center,
            child: Container(
              transform: Matrix4.translationValues(
                  0.0, -MediaQuery.of(context).size.height * 0.045, 0.0),
              child: Image.asset(
                "assets/marker.png",
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ),
          ),
          if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info.totalDistance}, ${_info.totalDuration} ',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          isFinish == false
              ? StreamBuilder(
                  stream: _locationService.locationStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      userLocation = snapshot.data;
                      _latitude = userLocation.latitude;
                      _longitude = userLocation.longitude;
                      //  _addMarkerMyLocation();

                      Future.delayed(Duration.zero, () async {
                        _googleMapController.animateCamera(
                          _info != null
                              ? CameraUpdate.newLatLngBounds(
                                  _info.bounds, 100.0)
                              : CameraUpdate.newCameraPosition(CameraPosition(
                                  zoom: 17.5,
                                  target: LatLng(
                                    userLocation.latitude,
                                    userLocation.longitude,
                                  ))),
                        );

                        setState(() {
                          isFinish = true;
                        });
                      });

                      return Text("");

                      // return Center(
                      //     child: Container(
                      //         padding: EdgeInsets.all(8),
                      //         color: Colors.white,
                      //         child: Text(userLocation.latitude.toString() +
                      //             " " +
                      //             userLocation.longitude.toString())));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  })
              : Padding(padding: EdgeInsets.all(0)),
          Positioned(
            bottom: 0.0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.48,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: FloatingActionButton(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      foregroundColor: Colors.black,
                      onPressed: () => _googleMapController.animateCamera(
                        _info != null
                            ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
                            : CameraUpdate.newCameraPosition(CameraPosition(
                                zoom: 17.5,
                                target: LatLng(
                                  userLocation.latitude,
                                  userLocation.longitude,
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
              height: MediaQuery.of(context).size.height * 0.38,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                color: ThemeData.light().scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Kami butuh lokasi anda ",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: 0.1,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 50,
                          child: FloatingActionButton(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            foregroundColor: Colors.black,
                            child: const Icon(Icons.home_work),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: InputWidget(
                          controller: address,
                          textInputType: TextInputType.text,
                          hintText: "Tambahakan Alamat Lengkap",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 8,
                        child: InputWidget(
                          controller: info,
                          textInputType: TextInputType.text,
                          hintText: "Informasi Tambahan ,, ex . dekat dengan",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Expanded(child:
                      Consumer<MenuProvider>(builder: (context, provider, _) {
                    return AppButton(
                      onPressed: () {
                        if (address.text.length < 6) {
                          snackBar("Mohon isi Alamat Lengkap");
                        } else if (userLocation.latitude == null ||
                            userLocation.longitude == null) {
                          snackBar("Mohon Izinkan Layanan Lokasi");
                        } else {
                          transaction.serviceClientId = int.parse(widget
                              .merchant
                              .service[widget.merchant.serviceClick]
                              .serviceClientId);
                          transaction.price = widget.merchant
                              .service[widget.merchant.serviceClick].price;
                          transaction.orderType = "homecare";
                          transaction.dateReservation =
                              DateTime.now().toString().substring(0, 10);
                          transaction.hourReservation = "";

                          dataOrder.transaction = transaction;

                          provider.setuserLocationLatitude(
                              userLocation.latitude.toString());

                          provider.setuserLocationLongitude(
                              userLocation.longitude.toString());

                          provider.setuserLocationAddres(address.text);

                          provider.fetchListSwabber;

                          Navigator.pushReplacementNamed(
                              context, OrderProfilPage.routeName,
                              arguments: dataOrder);
                        }
                      },
                      text: "Lanjutkan",
                      type: ButtonType.PRIMARY,
                    );
                  })),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addMarkerMyLocation() async {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          if (_latitude != null || _longitude != null) {
            _myLocation = Marker(
              markerId: const MarkerId('myLocation'),
              infoWindow: const InfoWindow(title: 'myLocation'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
              position: LatLng(_latitude, _longitude),
            );
          }
        }));
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin

      // var customIcons = await BitmapDescriptor.fromAssetImage(
      //     ImageConfiguration(devicePixelRatio: 2.5), 'assets/dokter.png');

      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Swabber'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Pasien'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() {
        _info = directions;
        //print(_info.bounds);
      });
    }
  }
}
