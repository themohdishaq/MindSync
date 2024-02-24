import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nayapakistan/common/color_extension.dart';
import 'package:nayapakistan/common_widget/round_button.dart';
import 'package:nayapakistan/common_widget/round_textfield.dart';
import 'package:nayapakistan/view/login/complete_profile_view.dart';
import 'package:nayapakistan/view/main_tab/main_tab_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isCheck = false;
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
      return null;
    }
    return null;
  }

  Future<void> checkUserProfileExists(User user) async {
    try {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('userProfile')
          .doc(user.uid)
          .get();
      if (userData.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logged in successfully')));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainTabView()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please Complete your profile')));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const CompleteProfileView()));
      }
    } catch (e) {
      print("Error checking user profile existence: $e");
    }
  }

  Future<void> signIn() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          checkUserProfileExists(userCredential.user!);
        }
      } catch (e) {
        final errorMessage = e is FirebaseAuthException
            ? e.message
            : 'An unknown error occurred';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    errorMessage!)) // Corrected: Wrapping the error message with a Text widget
            );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please Enter both email and password")));
    }
  }

  Future<void> handleGoogleSignIn() async {
    final User? user = await signInWithGoogle();
    if (user != null) {
      checkUserProfileExists(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: media.height * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.1,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  controller: _emailController,
                  label: "Email",
                  icon: "assets/images/email.png",
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  controller: _passwordController,
                  label: "Password",
                  icon: "assets/images/lock.png",
                  obscureText: !isPasswordVisible,
                  rightIcon: TextButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        child: Icon(isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Forgot your password?",
                        style: TextStyle(
                            color: TColor.gray,
                            fontSize: 15,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                RoundButton(
                    title: "Login",
                    onPressed: () {
                      signIn();
                    }),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      color: TColor.gray.withOpacity(0.5),
                    )),
                    Text(
                      "  Or  ",
                      style: TextStyle(color: TColor.black, fontSize: 12),
                    ),
                    Expanded(
                        child: Container(
                      height: 1,
                      color: TColor.gray.withOpacity(0.5),
                    )),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: ElevatedButton.icon(
                        onPressed: handleGoogleSignIn,
                        icon: Image.asset("assets/images/google.png",
                            width: 20, height: 20),
                        label: const Text(
                            "Sign in with Google"), // You can adjust the text as needed
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don’t have an account yet? ",
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
