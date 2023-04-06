import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Video {
  Video({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.thumbnail,
    required this.profilePhoto,
  });

  final String username;
  final String uid;
  final String id;
  final List likes;
  final int commentCount;
  final int shareCount;
  final String songName;
  final String caption;
  final String videoUrl;
  final String thumbnail;
  final String profilePhoto;

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'id': id,
        'likes': likes,
        'commentCount': commentCount,
        'shareCount': shareCount,
        'songName': songName,
        'caption': caption,
        'videoUrl': videoUrl,
        'thumbnail': thumbnail,
        'profilePhoto': profilePhoto,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
      username: snapshot["username"],
      uid: snapshot["uid"],
      id: snapshot["id"],
      likes: snapshot["likes"],
      commentCount: snapshot["commentCount"],
      shareCount: snapshot["shareCount"],
      songName: snapshot["songName"],
      caption: snapshot["caption"],
      videoUrl: snapshot["videoUrl"],
      thumbnail: snapshot["thumbnail"],
      profilePhoto: snapshot["profilePhoto"],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Video.fromJson(String source) => Video.fromMap(json.decode(source) as Map<String, dynamic>);
}
