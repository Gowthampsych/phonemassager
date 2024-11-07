import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phonemassager/home_page.dart';

class GetStartedPage extends StatefulWidget {
  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {

  @override
  void initState() {
    super.initState();

    // Wait for 2 seconds and navigate to HomePage
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size using MediaQuery
    final screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/Phone_massager.svg', // Your SVG asset
          width: screenWidth, // Full width of the screen
          height: screenHeight, // Full height of the screen
          fit: BoxFit.cover, // Ensure the image covers the screen
        ),
      ),
    );
  }
}
