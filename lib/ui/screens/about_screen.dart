import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:road_helperr/ui/screens/constants.dart';

class AboutScreen extends StatelessWidget {
  static const String routeName = "aboutscreen";

  final Color lightPrimary = Color(0xFF023A87);
  final Color lightSecondary = Color(0xFF86A5D9);
  final Color lightBackground = Color(0xFFFDFEFF);

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'roadhelper200@gmail.com',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.primaryBlue : lightBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDarkMode
                        ? [AppColors.primaryBlue, AppColors.primaryBlue.withOpacity(0.8)]
                        : [lightPrimary, lightSecondary],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              title: Text('About Us',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  shadows: isDarkMode ? null : [
                  Shadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.3),
                  )],
                ),
              ),
            ),
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: isDarkMode ? Colors.transparent : lightPrimary,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeatureCard(
                    icon: Icons.medical_services,
                    title: "Emergency Services",
                    content: "Quickly locate nearby hospitals, police stations, and emergency contacts",
                    isDarkMode: isDarkMode,
                  ),
                  SizedBox(height: 16),
                  _buildFeatureCard(
                    icon: Icons.local_gas_station,
                    title: "Gas Stations",
                    content: "Find the nearest fuel stations with real-time availability information",
                    isDarkMode: isDarkMode,
                  ),
                  SizedBox(height: 16),
                  _buildFeatureCard(
                    icon: Icons.people,
                    title: "Community Help",
                    content: "Request assistance from nearby users in case of emergencies",
                    isDarkMode: isDarkMode,
                  ),
                  SizedBox(height: 24),
                  Text(
                    "About the App",
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : lightPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Our mission is to make your journeys safer and more convenient through innovative technology solutions. "
                        "The app combines real-time location services with AI to provide intelligent assistance when you need it most.",
                    style: TextStyle(
                      color: isDarkMode ? Colors.white70 : lightPrimary.withOpacity(0.8),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildInfoSection(isDarkMode),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String content,
    required bool isDarkMode,
  }) {
    return Card(
      color: isDarkMode
          ? Colors.white.withOpacity(0.1)
          : lightSecondary.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon,
                color: isDarkMode ? Colors.white : lightPrimary,
                size: 28),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : lightPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    content,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white70 : lightPrimary.withOpacity(0.8),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.white.withOpacity(0.1)
            : lightSecondary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.info, "Version: 1.0.0", isDarkMode),
          _buildInfoRow(Icons.people_alt, "Developer: Road Helper Team", isDarkMode),
          InkWell(
            onTap: _launchEmail,
            child: _buildInfoRow(
              Icons.email,
              "Contact: roadhelper200@gmail.com",
              isDarkMode,
              isEmail: true,
            ),
          ),
          _buildInfoRow(Icons.copyright, "All rights reserved © 2025", isDarkMode),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, bool isDarkMode, {bool isEmail = false}) {
    final textColor = isDarkMode ? Colors.white70 : Color(0xFF023A87).withOpacity(0.8);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,
              color: isEmail
                  ? isDarkMode ? Colors.blue[200] : Color(0xFF023A87)
                  : textColor,
              size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isEmail
                    ? isDarkMode ? Colors.blue[200] : Color(0xFF023A87)
                    : textColor,
                decoration: isEmail ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}