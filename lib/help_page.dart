import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';  // Import url_launcher package

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});


  // Function to launch URL (Website)
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);  // Create a Uri object from the string URL
    if (await canLaunchUrl(uri)) {  // Use canLaunchUrl() instead of canLaunch()
      await launchUrl(uri);  // Use launchUrl() instead of launch()
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to launch email with prefilled subject and body
  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'info@qwat.in',
      queryParameters: {
        'subject': 'Help Request',
        'body': 'Hello, I need help with...',  // Prefill email body
      },
    );
    
    // Check if the email URL can be launched (email app installed on device)
    if (await canLaunchUrl(emailUri)) {  // Use canLaunchUrl() for email link
      await launchUrl(emailUri);  // Use launchUrl() for email link
    } else {
      throw 'Could not launch email app';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Need Help?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "For any issues or questions, feel free to contact us:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _launchURL('https://www.qwat.in'),  // Open website in browser
              child: const Text(
                "Website: www.qwat.in",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _launchEmail,  // Open email client with pre-filled subject and body
              child: const Text(
                "Email: info@qwat.in",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "We're here to help!",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
