import 'package:flutter/material.dart';
import 'package:food_del/config/colors.dart';
import 'package:food_del/providers/check_out_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({Key? key}) : super(key: key);

  @override
  State<CustomGoogleMap> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<CustomGoogleMap> {
  LatLng _initialcameraposition = LatLng(28.3949, 84.1240);
  GoogleMapController? controller;
  Location _location = Location();
  void _onMapCreated(GoogleMapController _value) {
    controller = _value;
    _location.onLocationChanged.listen((event) {
      controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              event.latitude!.toDouble(),
              event.longitude!.toDouble(),
            ),
            zoom: 15,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialcameraposition,
                ),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                mapToolbarEnabled: true,
              ),
//positioned is a class like container
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 59,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    right: 69,
                    left: 10,
                    bottom: 40,
                    top: 40,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      await _location.getLocation().then((value) => {
                            setState(
                              () {
                                checkoutProvider.setLocation = value;
                              },
                            ),
                          });
                      Navigator.of(context).pop();
                    },
                    color: primaryColor,
                    child: Text("Set Location"),
                    shape: StadiumBorder(),
                  ), // MaterialButton
                ), // Container
              ), // Positioned
            ],
          ), // Stack
        ),
      ), // Container
    ); // Scaffold
  }
}
