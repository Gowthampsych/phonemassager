import 'package:flutter/material.dart';
import 'package:phonemassager/get_started_page.dart'; // Import the GetStartedPage

void main() {
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetStartedPage(), // Start the app from GetStartedPage
    );
  }
}
