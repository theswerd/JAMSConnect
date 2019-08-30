import 'package:flutter/material.dart';
import 'constants.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      mapType: MapType.hybrid,
      markers: {
        Marker(
          markerId: MarkerId("tennis courts"),
          position: LatLng(34.012703272587146, -118.46938021481036),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          infoWindow: InfoWindow(title: "Tennis Courts", snippet: "The John Adams Middle School Tennis Courts.")
        ),
        Marker(
          markerId: MarkerId("basketball courts"),
          position: LatLng(34.012854180260945, -118.4691921249032),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          infoWindow: InfoWindow(title: "Basketball Courts", snippet: "The John Adams Middle School Basketball Courts.")
        ),
        Marker(
          markerId: MarkerId("football field"),
          position: LatLng(34.01267742649457, -118.46775848418474),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          infoWindow: InfoWindow(title: "Football Field", snippet: "The John Adams Middle School Football Field.")
        ),
        Marker(
          markerId: MarkerId("baseball field"),
          position: LatLng(34.012251103789225, -118.46857957541943),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          infoWindow: InfoWindow(title: "Baseball Field", snippet: "The John Adams Middle School Baseball Field.")
        ),
        Marker(
          markerId: MarkerId("soccer field"),
          position: LatLng(34.01320907625618, -118.46858661621809),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          infoWindow: InfoWindow(title: "Soccer Field", snippet: "The John Adams Middle School Soccer Field.")
        ),
        Marker(
          markerId: MarkerId("gym"),
          position: LatLng(34.01331885192924, -118.46953142434359),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          infoWindow: InfoWindow(title: "Gym", snippet: "The John Adams Middle School Gym.")
        ),
        Marker(
          markerId: MarkerId("girls locker room"),
          position: LatLng(34.01348532160317, -118.46924945712088),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          infoWindow: InfoWindow(title: "Girls Locker Room", snippet: "The John Adams Middle School Girls Locker Room.")
        ),
        Marker(
          markerId: MarkerId("boys locker room"),
          position: LatLng(34.01311375194899, -118.46978187561035),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          infoWindow: InfoWindow(title: "Boys Locker Room", snippet: "The John Adams Middle School Boys Locker Room.")
        ),
        Marker(
          markerId: MarkerId("library"),
          position: LatLng(34.01338027066162, -118.47009468823671),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: "Library", snippet: "The John Adams Middle School Library.")
        ),
        Marker(
          markerId: MarkerId("attendance"),
          position: LatLng(34.01371571064678, -118.4704701974988),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: "Attendance Office", snippet: "The John Adams Middle School Attendance Office. Home to both vice principals.")
        ),
        Marker(
          markerId: MarkerId("Main"),
          position: LatLng(34.01372404799491, -118.47024757415058),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: "Main Office", snippet: "The John Adams Middle School Main Office. Home to Mr.Richardson.")
        ),
        Marker(
          markerId: MarkerId("yearbook"),
          position: LatLng(34.01361177163816, -118.46972588449717),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: "Yearbook Room", snippet: "The John Adams Middle School Yearbook Room.")
        ),
        Marker(
          markerId: MarkerId("asb"),
          position: LatLng(34.014402983295476, -118.4690737724304),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: "ASB Room", snippet: "The John Adams Middle School ASB Room.")
        ),
        Marker(
          markerId: MarkerId("cafeteria"),
          position: LatLng(34.01374850421133, -118.46871100366116),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: "Cafeteria", snippet: "The John Adams Middle School Cafeteria.")
        ),
        Marker(
          markerId: MarkerId("construction"),
          position: LatLng(34.01457056247893, -118.47039375454187),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          infoWindow: InfoWindow(title: "Construction", snippet: "The John Adams Middle School Construction Zone.")
        )
      },
      onTap: (ll){
        print(ll);
      },
      initialCameraPosition: CameraPosition(
        bearing: -45,
        target: LatLng(34.013351,-118.469147),
        zoom: 17.7
      ),
    );
  }
}