import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:road_helperr/ui/screens/ai_chat.dart';
import 'package:road_helperr/ui/screens/ai_welcome_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/home_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/map_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/notification_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/profile_screen.dart';
import 'package:road_helperr/ui/screens/edit_profile_screen.dart';
import 'package:road_helperr/ui/screens/email_screen.dart';
import 'package:road_helperr/ui/screens/on_boarding.dart';
import 'package:road_helperr/ui/screens/onboarding.dart';
import 'package:road_helperr/ui/screens/otp_expired_screen.dart';
import 'package:road_helperr/ui/screens/otp_screen.dart';
import 'package:road_helperr/ui/screens/signin_screen.dart';
import 'package:road_helperr/ui/screens/signupScreen.dart';
import 'package:road_helperr/ui/screens/emergency_contacts.dart';
import 'package:road_helperr/utils/theme_provider.dart';
import 'utils/location_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LocationService _locationService = LocationService();
  late Stream<Position> _positionStream;

  @override
  void initState() {
    super.initState();
    _positionStream = _locationService.positionStream;
    _checkLocation();
  }

  Future<void> _checkLocation() async {
    await _locationService.checkLocationPermission();
    bool isLocationEnabled = await _locationService.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      _showLocationDisabledMessage();
    }
  }

  void _showLocationDisabledMessage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Required'),
        content: const Text('Please enable location services to continue.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ٌRoad Helper App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      themeMode: ThemeMode.system,
      routes: {
        SignupScreen.routeName: (context) => const SignupScreen(),
        SignInScreen.routeName: (context) => const SignInScreen(),
        AiWelcomeScreen.routeName: (context) => const AiWelcomeScreen(),
        AiChat.routeName: (context) => const AiChat(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        MapScreen.routeName: (context) => const MapScreen(),
        NotificationScreen.routeName: (context) => const NotificationScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        OtpScreen.routeName: (context) => const OtpScreen(),
        OnBoarding.routeName: (context) => const OnBoarding(),
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        OtpExpiredScreen.routeName: (context) => const OtpExpiredScreen(),
        EditProfileScreen.routeName: (context) => const EditProfileScreen(),
        EmailScreen.routeName: (context) => const EmailScreen(),
        EmergencyContactsScreen.routeName: (context) =>
            const EmergencyContactsScreen(),
      },
        //initialRoute:OtpScreen.routeName,
     initialRoute: OnboardingScreen.routeName,
    );
  }
}
