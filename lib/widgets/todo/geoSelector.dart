import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoSelectorWidget extends StatefulWidget {
  GeoSelectorWidget({
    Key key,
    this.initGeo,
    this.initZoom,
    this.geoChanged,
  }) : super(key: key);

  @override
  _GeoSelectorWidgetState createState() => _GeoSelectorWidgetState();

  final LatLng initGeo;
  final double initZoom;
  final void Function(LatLng, double) geoChanged;
}

class _GeoSelectorWidgetState extends State<GeoSelectorWidget> {
  Completer<GoogleMapController> _controller = Completer();

  void _onGeoChanged(CameraPosition position) {
    widget.geoChanged(position.target, position.zoom);
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.initGeo);
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
                      target: widget.initGeo,
                      zoom: widget.initZoom,
                    ),
                    onCameraMove: _onGeoChanged,
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
