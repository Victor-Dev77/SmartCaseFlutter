import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:smartcaseflutter/controllers/user_controller.dart';
import 'package:smartcaseflutter/models/destination.dart';
import 'package:smartcaseflutter/repositorys/firebase_firestore_repository.dart';
import 'package:latlong/latlong.dart';
import 'package:smartcaseflutter/utils/functions.dart';

class DestinationController extends GetxController {
  static DestinationController get to => Get.put(DestinationController());

  FirebaseFirestoreRepository _bddRepo = FirebaseFirestoreRepository.to;

  List<Destination> _listDestination = [];
  List<Destination> get listDestination => this._listDestination;

  final MapController _mapController = MapController();
  MapController get mapController => this._mapController;

  int _indexMarker = -1;
  int get indexMarker => this._indexMarker;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  _initData() async {
    _listDestination = await _bddRepo.getListDestination(UserController.to.user.id);
    _listDestination.sort((a, b) => differenceBWDateString(b.date, a.date, "dd/MM/yyyy"));
    update();
  }

  focusMarker(int index) {
    _indexMarker = index;
    _mapController.move(
      LatLng(
        _listDestination[index].location["latitude"],
        _listDestination[index].location["longitude"],
      ),
      3.0,
    );
    update();
  }
}
