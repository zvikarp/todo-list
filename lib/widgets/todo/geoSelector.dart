import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoSelectorWidget extends StatefulWidget {
  GeoSelectorWidget({Key key}) : super(key: key);

  @override
  _GeoSelectorWidgetState createState() => _GeoSelectorWidgetState();
}

class _GeoSelectorWidgetState extends State<GeoSelectorWidget> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(32.0667, 34.7667);

  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.location_on,
            color: Theme.of(context).primaryColor,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width - 75,
            height: 200,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 14.0,
                    ),
                    onCameraMove: _onCameraMove,
                    tiltGesturesEnabled: false,
                  ),
                ),
                Center(
                    child: Icon(
                  Icons.my_location,
                  color: Theme.of(context).primaryColor,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
