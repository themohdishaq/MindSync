import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nayapakistan/common/color_extension.dart';
import 'package:nayapakistan/common_widget/round_button.dart';
import 'package:nayapakistan/view/main_tab/main_tab_view.dart';
import 'package:nayapakistan/view/on_boarding/on_boarding_view.dart';

class StartedView extends StatefulWidget {
  const StartedView({Key? key}) : super(key: key);

  @override
  State<StartedView> createState() => _StartedViewState();
}

class _StartedViewState extends State<StartedView> {
  @override
  void initState() {
    super.initState();
    checkLoggedIn();
  }

  void checkLoggedIn() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainTabView()),
        );
      });
    } else {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnBoardingView()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: Container(
        width: media.width,
        height: media.height,
        decoration: BoxDecoration(
          color: Colors.blue[600],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Image.asset('assets/images/mindsync.png'),
            ),
            const Spacer(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: RoundButton(
                  title: "Get Started",
                  type: RoundButtonType.bgGradient,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OnBoardingView()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
