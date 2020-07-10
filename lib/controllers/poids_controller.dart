import 'package:get/get.dart';
import 'package:smartcaseflutter/controllers/user_controller.dart';
import 'package:smartcaseflutter/repositorys/firebase_firestore_repository.dart';
import 'package:smartcaseflutter/services/mqtt_client.dart';

class PoidsController extends GetxController {

  static PoidsController get to => Get.find();

  List<double> listPoids = [0.0, 0.0];
  FirebaseFirestoreRepository _bddRepo = FirebaseFirestoreRepository.to;
  double difference = 0.0;
  bool isClicked = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initPoids();
  }

  _initPoids() async{
    listPoids = await _bddRepo.getListPoids(UserController.to.user.id);
    if(listPoids == null || listPoids.length == 0){
      listPoids = [0.0, 0.0];
    }
    update();
  }

  getPoidsFromESP(){
    isClicked = true;
    update();
    MQTTService.publishPoidESP();
  }

  setPoids(double poids) async {
    print(listPoids);
      listPoids.insert(0, poids);
      listPoids.removeLast();
    print(listPoids);
    _setDifference();
    await _bddRepo.setPoidsToCloud(UserController.to.user.id, {"poids1": listPoids[0], "poids2": listPoids[1]});
    isClicked = false;
    update();
  }

  _setDifference(){
    if(listPoids[0] == 0.0 || listPoids[1] == 0.0){
      difference = 0.0;
    } else {
      difference = (listPoids[1] - listPoids[0]);
      difference = double.parse((difference).toStringAsFixed(2));
    }
  }

  poidsRefresh() async {
    difference = 0;
    listPoids = [0.0, 0.0];
    await _bddRepo.setPoidsToCloud(UserController.to.user.id, {"poids1": listPoids[0], "poids2": listPoids[1]});
    isClicked = false;
    update();
  }
}