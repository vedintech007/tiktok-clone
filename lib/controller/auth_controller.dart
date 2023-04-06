import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user.dart' as model;
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/home/home_screen.dart';

class AuthController extends GetxController {
  // create an instance so we can call this directly anywhere
  static AuthController instance = Get.find();

  // create a firebase auth user with the firebase User model
  late Rx<User?> _user;

  // make the picked image file reactive
  late Rx<File?> _pickedImage;

  // _pickedImage is a private var, so we use this to be able to access the image file
  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();

    // we set the user to the current user value
    _user = Rx<User?>(firebaseAuth.currentUser);

    // we bind to a stream which will listen to the auth state and bind it to our user stream
    _user.bindStream(firebaseAuth.authStateChanges());

    //
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      Get.snackbar("Profile Pictured", "You selected a profile picture");
    }

    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  // upload to firestore storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage.ref().child("profilePic").child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  // registering users
  void registerUser(String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        // save user to db
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String downloadUrl = await _uploadToStorage(image!);

        model.User user = model.User(
          name: username,
          profilePhoto: downloadUrl,
          email: email,
          uid: cred.user!.uid,
        );

        await firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
      } else {
        Get.snackbar(
          "Error",
          'Please fill all the fields',
        );
      }
    } catch (e) {
      Get.snackbar("Error creating account.", e.toString());
    }
  }

  // login user
  Future<void> loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((response) => {
              log(response.user.toString()),
            });

        log("login successful");
      } else {
        Get.snackbar("Error", "Fields cannot be empty.");
      }
    } catch (e) {
      Get.snackbar("Invalid username or password.", e.toString());
    }
  }
}
