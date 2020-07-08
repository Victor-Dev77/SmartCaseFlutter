import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/state_manager.dart';
import 'package:latlong/latlong.dart';
import 'package:smartcaseflutter/controllers/destination_controller.dart';

class DestinationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff293251),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: _buildMap(),
                ),
                Expanded(
                  child: _buildListDestination(),
                )
              ],
            ),
            Positioned(
              child: FloatingActionButton(
                backgroundColor: Color(0xff80BFFD),
                onPressed: () => DestinationController.to.showAddressDialog(),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              right: 20,
              top: MediaQuery.of(context).size.height * 0.75 - 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMap() {
    return GetBuilder<DestinationController>(
      init: DestinationController(),
      builder: (controller) {
        return FlutterMap(
          mapController: controller.mapController,
          options: MapOptions(
            center: LatLng(48.8566969, 2.3514616),
            zoom: 3.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/{style}/tiles/256/{z}/{x}/{y}?access_token={accessToken}",
              additionalOptions: {
                'style': "wemouv/ckc9798x02vgc1ipjusua5lbm",
                'accessToken':
                    'pk.eyJ1Ijoid2Vtb3V2IiwiYSI6ImNqcGgxN21tZjBwYWgzcWxxZ242NHd5NjkifQ.dbudKtF6QmygxeD1osCvbA',
              },
            ),
            MarkerLayerOptions(
              markers: _buildListMarker(controller),
            ),
          ],
        );
      },
    );
  }

  List<Marker> _buildListMarker(DestinationController controller) {
    return List.generate(controller.listDestination.length, (index) {
      var data = controller.listDestination[index];
      return Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(data.location["latitude"], data.location["longitude"]),
        builder: (ctx) => Container(
          child: Icon(
            FontAwesomeIcons.mapMarkerAlt,
            color: (controller.indexMarker == index)
                ? Colors.white
                : Colors.orange,
            size: 35,
          ),
        ),
      );
    });
  }

  Widget _buildListDestination() {
    var style = TextStyle(color: Colors.white);
    return GetBuilder<DestinationController>(
      builder: (controller) {
        if (controller.listDestination.length == 0)
          return Center(
            child: Text(
              "Aucune destination ajoutée",
              style: style,
            ),
          );
        return Container(
          margin: EdgeInsets.only(top: 20),
          child: ListView.builder(
            itemCount: controller.listDestination.length,
            itemBuilder: (ctx, index) {
              var data = controller.listDestination[index];
              return ListTile(
                title: Text(data.city, style: style),
                trailing: Text(
                  data.date,
                  style: style,
                ),
                onTap: () => controller.focusMarker(index),
              );
            },
          ),
        );
      },
    );
  }
}
