import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../Auth/login/login_screen.dart';

class BoardingModel {
  String? image, title, body;

  BoardingModel({required this.image, required this.title, required this.body});
}

List<BoardingModel> boardingList = [
  BoardingModel(
      image: 'assets/images/boarding1.PNG',
      title: 'Community1',
      body: 'Get to know coworkers1'),
  BoardingModel(
      image: 'assets/images/boarding2.PNG',
      title: 'Community2',
      body: 'Get to know coworkers2'),
  BoardingModel(
      image: 'assets/images/boarding3.PNG',
      title: 'Community3',
      body: 'Get to know coworkers3'),
];

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var boardingcControaller = PageController();
  bool isLast = true;

  void submit() {
    CacheHelper.savaData(key: "onBoarding", value: true).then((value) {
      if (value) {
        navigateToFinsh(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == boardingList.length - 1)
                      {
                     setState(() {
                       isLast=true;
                     });
                      // ignore: avoid_print
                      print("lastPage");
                      }
                    else{
                      {
                        setState(() {
                          isLast=false;
                        });
                        // ignore: avoid_print
                        print("NextPage");
                      }
                    }
                  },
                  controller: boardingcControaller,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return buildBoardingItem(boardingList[index]);
                  }),
            ),
            const SizedBox(
              height: 100,
            ),
            SmoothPageIndicator(
              controller: boardingcControaller,
              count: 3,
              axisDirection: Axis.horizontal,
              effect: const ExpandingDotsEffect(
                spacing: 10.0,
                radius: 10.0,
                dotWidth: 10.0,
                dotHeight: 10.0,
                expansionFactor: 4.0,
                dotColor: Colors.grey,
                activeDotColor: defaultColor,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                TextButton(onPressed: submit, child: const Text('Skip')),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast){
                      submit();
                      navigateToFinsh(context, LoginScreen());
                    }
                   else{
                      boardingcControaller.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }
}
