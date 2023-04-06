import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tiktok Clone",
                  style: TextStyle(
                    fontSize: 35,
                    color: buttonColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                heightSpace(25),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(profileImagePath),
                      backgroundColor: Colors.white,
                    ),
                    Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: () => authController.pickImage(),
                          icon: const Icon(
                            Icons.add_a_photo,
                          ),
                        ))
                  ],
                ),
                heightSpace(30),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _usernameController,
                    labelText: "Username",
                    prefixIcon: Icons.person,
                  ),
                ),
                heightSpace(25),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _emailController,
                    labelText: "Email",
                    prefixIcon: Icons.email,
                  ),
                ),
                heightSpace(25),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _passwordController,
                    obscureText: true,
                    labelText: "Password",
                    prefixIcon: Icons.lock,
                  ),
                ),
                heightSpace(30),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: InkWell(
                    onTap: () => authController.registerUser(
                      _usernameController.text.trim(),
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      authController.profilePhoto,
                    ),
                    child: const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                heightSpace(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 20),
                    ),
                    InkWell(
                      onTap: () => Get.off(() => LoginScreen()),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                          color: buttonColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
