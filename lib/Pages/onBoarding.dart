import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nbtt_masr/Pages/start_page.dart';
import 'package:nbtt_masr/helpers/constants.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
  /* Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => StartPage(firstTime: true,)),
    );*/
   Navigator.push(
       context,
       MaterialPageRoute(
           builder: (context) => StartPage(
             firstTime: false,
           )));
    /*await Navigator.push(context, MaterialPageRoute(builder:
        (context) => StartPage(firstTime: false,)));*/
  }

  Widget _buildImage(String assetName,double screenHeight,double screenWidth) {
    return Image.asset('assets/$assetName', width: double.infinity,height: double.infinity,
    fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    const bodyStyle = TextStyle(fontSize: 0.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 0.0),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.zero,
      pageColor: Colors.white,
      imageFlex: 5,
      bodyFlex: 0,
      titlePadding: EdgeInsets.zero,
      imagePadding: EdgeInsets.zero,
      footerPadding: EdgeInsets.zero,

      //imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "",
          body:
          "",
          image: _buildImage('images/iPhone 6, 7, 8 – 38.png',screenHeight,screenWidth),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body:
          "",
          image: _buildImage('images/iPhone 6, 7, 8 – 39.png',screenHeight,screenWidth),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body: "",
          image: _buildImage('images/iPhone 6, 7, 8 – 40.png',screenHeight,screenWidth),
          /*footer: RaisedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            child: const Text(
              'FooButton',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),*/
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
        body: "",
        /*  bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Click on ", style: bodyStyle),
              Icon(Icons.edit),
              Text(" to edit a post", style: bodyStyle),
            ],
          ),*/
          image: _buildImage('images/iPhone 6, 7, 8 – 41.png',screenHeight,screenWidth),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body: "",
          image: _buildImage('images/iPhone 6, 7, 8 – 42.png',screenHeight,screenWidth),
          decoration: pageDecoration,

        ),
        PageViewModel(
          title: "",
          body: "",
          image: _buildImage('images/iPhone 6, 7, 8 – 36.png',screenHeight,screenWidth),
          decoration: pageDecoration,

        ),
        PageViewModel(
          title: "",
          body: "",
          image: _buildImage('images/iPhone 6, 7, 8 – 47.png',screenHeight,screenWidth),
          decoration: pageDecoration,

        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      skip: const Text('تخطى'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('تخطى', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeColor: kGreenColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

