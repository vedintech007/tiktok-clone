import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.uid});

  final String uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    profileController.updateUserId(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black12,
              leading: const Icon(Icons.person_add_alt_1_outlined),
              title: Text(
                controller.user['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              actions: const [
                Icon(Icons.more_horiz),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: controller.user['profilePhoto'],
                                height: 100,
                                width: 100,
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.error,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  controller.user['following'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Following",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.black54,
                              width: 1,
                              height: 15,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  controller.user['followers'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Followers",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.black54,
                              width: 1,
                              height: 15,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  controller.user['likes'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Likes",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        // sign out
                        Container(
                          width: 140,
                          height: 47,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                if (widget.uid == authController.user.uid) {
                                  authController.signOut();
                                } else {
                                  controller.followUser();
                                }
                              },
                              child: Text(
                                widget.uid == authController.user.uid
                                    ? "Sign Out"
                                    : !controller.user['isFollowing']
                                        ? "Follow"
                                        : "Unfollow",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // video list
                        GridView.builder(
                          itemCount: controller.user['thumbnails'].length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            String thumbnail = controller.user['thumbnails'][index];

                            return CachedNetworkImage(
                              imageUrl: thumbnail,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
