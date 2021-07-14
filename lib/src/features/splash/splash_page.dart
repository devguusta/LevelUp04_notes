import 'package:animated_card/animated_card.dart';

import 'package:flutter/material.dart';
import 'package:notas/src/features/home/home_page.dart';
import 'package:notas/src/shared/constants/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 2)).then(
        (value) => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(),
          ),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.blueGradient,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedCard(
              direction: AnimatedCardDirection.top,
              duration: Duration(seconds: 1),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: (MediaQuery.of(context).size.height / 2) - 100,
                    child: Hero(
                      tag: "notes_logo",
                      child: Image.asset(
                        "assets/images/notes_logo.png",
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Hero(
                          tag: "journal",
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              "journal",
                              style: TextStyle(
                                fontSize: 72.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: "Montserrat",
                                letterSpacing: -0.05,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "YOUR ACADEMY'S BEST FRIEND",
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            letterSpacing: 0.165,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AnimatedCard(
              direction: AnimatedCardDirection.bottom,
              duration: Duration(seconds: 1),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "powered by",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                        fontFamily: "Roboto",
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Image.asset("assets/images/raro_academy_logo.png"),
                    SizedBox(height: 40.0)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}