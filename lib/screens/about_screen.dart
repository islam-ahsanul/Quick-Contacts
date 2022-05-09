import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'About',
          style: TextStyle(
            fontFamily: 'MPLUSRounded',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 30.0,
            color: Colors.black,
            fontFamily: 'RobotoMono',
            // fontWeight: FontWeight.bold,
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(
                'This App',
              ),
              FlickerAnimatedText('is created'),
              FlickerAnimatedText('by'),
              FlickerAnimatedText('Ahsanul Islam'),
            ],
          ),
        ),
      ),
    );
  }
}
