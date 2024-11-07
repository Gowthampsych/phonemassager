import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart'; // Import vibration package
import 'package:startapp_sdk/startapp.dart'; // Import Start.io SDK
import 'about_page.dart';  // Import AboutPage
import 'help_page.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _speed = 50.0; // Initial speed value
  bool _isVibrating = false; // Flag to check if vibration is ongoing
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey for Scaffold

  // Start.io SDK integration
  final StartAppSdk _startAppSdk = StartAppSdk();
  StartAppBannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _initializeAds();
  }

  void _initializeAds() {
    // TODO: Ensure this is disabled before release
    _startAppSdk.setTestAdsEnabled(true);

    _startAppSdk.loadBannerAd(StartAppBannerType.BANNER).then((bannerAd) {
      setState(() {
        _bannerAd = bannerAd;
      });
    }).onError<StartAppException>((ex, stackTrace) {
      debugPrint("Error loading Banner ad: ${ex.message}");
    }).onError((error, stackTrace) {
      debugPrint("Error loading Banner ad: $error");
    });
  }

  // Function to start vibrating based on the speed
  void _startVibration() async {
    if (await Vibration.hasVibrator() ?? false) {
      setState(() {
        _isVibrating = true;
      });

      // Continuously vibrate with varying durations based on the speed
      while (_isVibrating) {
        Vibration.vibrate(duration: (_speed * 10).toInt());
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
  }

  // Function to stop the vibration
  void _stopVibration() {
    Vibration.cancel();
    setState(() {
      _isVibrating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Set the scaffold key
      appBar: AppBar(
        title: const Text("Phone Massager"),
        leading: IconButton( // This button will appear on the left side
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open drawer using the scaffold key
          },
        ),
      ),
      drawer: AppDrawer(), // AppDrawer remains on the left
      body: Center( // Center the content vertically and horizontally
        child: SizedBox(
          width: double.infinity, // Take full width of the screen
          height: MediaQuery.of(context).size.height * 0.6, // You can adjust the height as per your requirement
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
              children: [
                const Text(
                  "Adjust Vibration Speed",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 40),
                Slider(
                  min: 10.0,
                  max: 100.0,
                  divisions: 10,
                  value: _speed,
                  activeColor: Colors.red, // Red color for the slider's active part
                  inactiveColor: Colors.grey, // Gray for the inactive part of the slider
                  onChanged: (value) {
                    setState(() {
                      _speed = value;
                    });
                    if (_isVibrating) {
                      _stopVibration();
                      _startVibration();
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isVibrating ? _stopVibration : _startVibration,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Red color for the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded edges
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  ),
                  child: Text(
                    _isVibrating ? "Stop Vibration" : "Start Vibration",
                    style: const TextStyle(color: Colors.white), // White text inside the button
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Disclaimer: This is a fun app and not a real massager. Prolonged use may reduce battery life or cause excessive heating. Please use responsibly.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (_bannerAd != null) StartAppBanner(_bannerAd!) // Display banner ad
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// AppDrawer widget to be used in the Drawer of the Scaffold
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'Phone Massager',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Help'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
