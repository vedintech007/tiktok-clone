import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUser = Rx<List<User>>([]);

  List<User> get seachedUsers => _searchedUser.value;

  searchUsers(String typedUser) async {
    print("Searching in progress...");
    _searchedUser.bindStream(
      firestore.collection("users").where('name', isGreaterThan: typedUser).snapshots().map(
        (QuerySnapshot query) {
          List<User> retVal = [];

          for (var elem in query.docs) {
            retVal.add(User.fromSnap(elem));
          }

          return retVal;
        },
      ),
    );
  }
}
