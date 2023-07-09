import 'package:flutter/material.dart';
import '../../../utils/color_theme.dart';
import '../../../utils/constants.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  // AuthController authController = Get.find();

  late PageController pageController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
    pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorTheme.kOnboardingColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                currentIndex < 1
                    ? Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (routeContext) => Home(),
                            // ));
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(124, 124, 124, 1),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 30,
                      ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                scrollBehavior: const ScrollBehavior(),
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                physics: const BouncingScrollPhysics(),
                itemCount: Constants.slides.length,
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.5,
                      child: Image.asset(
                        Constants.slides[currentIndex][0],
                      ),
                    ),
                    // SizedBox(
                    //   height: size.height * 0.01,
                    // ),
                    Text(
                      Constants.slides[currentIndex][1],
                      style: TextStyle(
                        color: ColorTheme.kPrimaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,

                        // letterSpacing: 2,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      height: size.height * 0.1,
                      child: Text(
                        Constants.slides[currentIndex][2],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18, color: ColorTheme.kTextColor,
                          // letterSpacing: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    Constants.slides.length,
                    (index) => buildDot(index: index),
                  ),
                ),
                SizedBox(
                  width: currentIndex < 1 ? size.width * 0.3 : size.width * 0.4,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(
                        () {
                          print('Go to Home Page');
                          if (currentIndex < Constants.slides.length - 1) {
                            currentIndex = currentIndex + 1;
                          } else {
                            print('Go to Home Page');
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (routeContext) => Home(),
                            // ));
                          }
                        },
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(ColorTheme.kPrimaryColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    child: currentIndex < 1
                        ? const Text(
                            "Next",
                            style: TextStyle(fontSize: 18),
                          )
                        : const Text(
                            "Get Started",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 9.5,
      width: currentIndex == index ? 22 : 9.5,
      decoration: BoxDecoration(
        color: currentIndex == index
            ? ColorTheme.kPrimaryColor
            : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
