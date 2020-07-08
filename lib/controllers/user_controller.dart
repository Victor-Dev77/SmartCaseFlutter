import 'package:get/get.dart';
import 'package:smartcaseflutter/models/user.dart';

class UserController extends GetxController {

  static UserController get to => Get.find();

  User _user;
  User get user => this._user;

  initUser(User user) async {
    _user = user;
    update();
  }

}