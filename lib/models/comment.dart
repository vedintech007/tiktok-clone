// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  Comment({
    required this.username,
    required this.comment,
    required this.datePublished,
    required this.profilePhoto,
    required this.likes,
    required this.uid,
    required this.id,
  });
  final String username;
  final String comment;
  final datePublished;
  final String profilePhoto;
  final List likes;
  final String uid;
  final String id;

  Map<String, dynamic> toJson() => {
        "username": username,
        "comment": comment,
        "datePublished": datePublished,
        "profilePhoto": profilePhoto,
        "likes": likes,
        "uid": id,
        "id": id,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Comment(
      username: snapshot["username"],
      comment: snapshot["comment"],
      datePublished: snapshot["datePublished"],
      profilePhoto: snapshot["profilePhoto"],
      likes: snapshot["likes"],
      uid: snapshot["uid"],
      id: snapshot["id"],
    );
  }
}
