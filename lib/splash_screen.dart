import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mymovies_app/login.dart';

const Color blueNavy = Color.fromARGB(255, 33, 0, 153);

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _coffeeController;
  bool copAnimated = false;
  bool animateCafeText = false;

  @override
  void initState() {
    super.initState();
    _coffeeController = AnimationController(vsync: this);
    _coffeeController.addListener(() {
      if (_coffeeController.value > 0.7) {
        _coffeeController.stop();
        copAnimated = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          animateCafeText = true;
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _coffeeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: blueNavy,
      body: Stack(
        children: [
          // White Container top half
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: copAnimated ? screenHeight / 1.9 : screenHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(copAnimated ? 40.0 : 0.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: !copAnimated,
                  child: Lottie.network(
                      'https://assets3.lottiefiles.com/packages/lf20_CTaizi.json',
                      controller: _coffeeController, onLoaded: (composition) {
                    _coffeeController
                      ..duration = composition.duration
                      ..forward().whenComplete(
                        () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        ),
                      );
                  }),
                ),
              ],
            ),
          ),

          // Text bottom part
          //Visibility(visible: copAnimated, child: const _BottomPart()),
        ],
      ),
    );
  }
}
