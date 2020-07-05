import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Destination extends StatefulWidget {
  @override
  _DestinationState createState() => _DestinationState();
}

class _DestinationState extends State<Destination> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.5, -0.09),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://api.mapbox.com/styles/v1/{style}/tiles/256/{z}/{x}/{y}?access_token={accessToken}",
           additionalOptions: {
              'style': "wemouv/ckc9798x02vgc1ipjusua5lbm",
              'accessToken': 'pk.eyJ1Ijoid2Vtb3V2IiwiYSI6ImNqcGgxN21tZjBwYWgzcWxxZ242NHd5NjkifQ.dbudKtF6QmygxeD1osCvbA',
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(51.5, -0.09),
                builder: (ctx) => Container(
                  child: FlutterLogo(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
