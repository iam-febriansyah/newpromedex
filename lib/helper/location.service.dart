import 'dart:async';

import 'package:galeri_teknologi_bersama/data/model/user.location.dart';
import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  StreamController<UserLocation> _locationStream =
      new StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationStream.stream;

  LocationService() {
    location.requestPermission().then((permissionStatus) => {
          if (permissionStatus == PermissionStatus.granted)
            {
              location.onLocationChanged.listen((locationData) {
                if (locationData != null && _locationStream.isClosed == false) {
                  _locationStream.add(UserLocation(
                      latitude: locationData.latitude,
                      longitude: locationData.longitude));
                }
              })
            }
        });
  }

  void dispose() => _locationStream.close();
}
