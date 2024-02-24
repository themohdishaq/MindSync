import 'package:flutter/material.dart';
import 'package:nayapakistan/common/color_extension.dart';
import 'package:nayapakistan/common_widget/on_boarding_page.dart';
import 'package:nayapakistan/view/login/signup_view.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int selectPage = 0;
  PageController controller = PageController();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      selectPage = controller.page?.round() ?? 0;
      setState(() {});
    });
  }

  List pageArr = [
    {
      "title": "Features",
      "subtitle": "Psychiatrist Bot for Personalized Counselling",
      "size": " \n\n",
      "image": 'assets/images/on_1.png'
    },
    {
      "title": "Mental Yoga Exercise",
      "subtitle":
          "To achieve tranquility of the mind and create a sense of well-being, feelings of relaxation, improved self-confidence",
      "image": 'assets/images/on_2.png'
    },
    {
      "title": "Integration with smart watches",
      "subtitle":
          "Let's start a healthy lifestyle with us, integrate it with your smart watch for healthy lifestyle",
      "image": 'assets/images/on_3.png'
    },
    {
      "title": "Healthy life Style",
      "subtitle":
          "Along with eating right and being active, real health includes getting enough sleep, practicing mindfulness, managing stress, keeping mind and body fit, connecting socially, and more.",
      "image": 'assets/images/on_4.png'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView.builder(
              controller: controller,
              itemCount: pageArr.length,
              itemBuilder: (context, index) {
                var pObj = pageArr[index] as Map? ?? {};
                return OnBoardingPage(pObj: pObj);
              }),
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    color: TColor.primaryColor1,
                    value: selectPage / 3,
                    strokeWidth: 3,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: TColor.primaryColor1,
                      borderRadius: BorderRadius.circular(35)),
                  child: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      color: TColor.white,
                      size: 35,
                    ),
                    onPressed: () {
                      if (selectPage < 3) {
                        selectPage = selectPage + 1;
                        controller.animateToPage(selectPage,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.bounceInOut);
                        // controller.jumpToPage(selectPage);

                        setState(() {});
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpView()));
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
