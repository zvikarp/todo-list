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

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    // _lastMapPosition = position.target;
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 14.0,
                ),
                mapType: _currentMapType,
                markers: _markers,
                onCameraMove: _onCameraMove,
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Align(
                //       alignment: Alignment.topRight,
                //       child: Column(
                //         children: <Widget> [
                //           FloatingActionButton(
                //             onPressed: _onMapTypeButtonPressed,
                //             materialTapTargetSize: MaterialTapTargetSize.padded,
                //             backgroundColor: Colors.green,
                //             child: const Icon(Icons.map, size: 36.0),
                //           ),
                //           SizedBox(height: 16.0),
                //           FloatingActionButton(
                //             onPressed: _onAddMarkerButtonPressed,
                //             materialTapTargetSize: MaterialTapTargetSize.padded,
                //             backgroundColor: Colors.green,
                //             child: const Icon(Icons.add_location, size: 36.0),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}