import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:smartcaseflutter/controllers/user_controller.dart';
import 'package:smartcaseflutter/models/destination.dart';
import 'package:smartcaseflutter/repositorys/firebase_firestore_repository.dart';
import 'package:latlong/latlong.dart';
import 'package:smartcaseflutter/services/google_places.dart';
import 'package:smartcaseflutter/utils/date_handle.dart';
import 'package:smartcaseflutter/utils/snackbar.dart';

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
    _listDestination =
        await _bddRepo.getListDestination(UserController.to.user.id);
    _sortList();
    update();
  }

  _sortList() {
    _listDestination.sort((a, b) =>
        DateHandle.to.differenceBWDateString(b.id, a.id, "dd-MM-yyyy HH:mm"));
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

  showAddressDialog() {
    GooglePlaces.showAddressDialog();
  }

  insertDestination(String city, double lat, double lon) async {
    var index = _listDestination.indexWhere((dest) => dest.city == city);
    if (index != -1) {
      CustomSnackbar.snackbar("Destination déjà enregistrée !");
      return;
    }
    DateTime dateNow = DateTime.now();
    Destination destination = Destination(
      id: "$dateNow",
      date: DateHandle.to.parseDateTime(dateNow, "dd/MM/yyyy"),
      city: city,
      location: {
        "latitude": lat,
        "longitude": lon,
      },
    );

    await _bddRepo.addDestination(UserController.to.user.id, destination.toMap());
    _listDestination.add(destination);
    _sortList();
    update();
  }
}
