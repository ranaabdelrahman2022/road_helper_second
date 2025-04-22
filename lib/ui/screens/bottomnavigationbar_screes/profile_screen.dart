import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:road_helperr/ui/screens/ai_welcome_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/map_screen.dart';
import '../../../utils/app_colors.dart';
import 'home_screen.dart';
import 'notification_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:road_helperr/ui/screens/signin_screen.dart';
import 'dart:io';
import '../profile_ribon.dart';
import '../edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "profscreen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  String name = "";
  String email = "";
  String selectedLanguage = "English";
  String currentTheme = "System";

  static const int _selectedIndex = 4;

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to pick image. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Here you would typically load the user's data from storage or API
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // TODO: Load actual user data from storage or API
    // For now using placeholder data
    setState(() {
      name = "User Name"; // Replace with actual user name
      email = "user@example.com"; // Replace with actual user email
    });
  }

  void _changeLanguage(String? newValue) {
    setState(() {
      selectedLanguage = newValue!;
    });
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, SignInScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF01122A),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 10),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                size: 18,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              'profile',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? const Color(0xFF86A5D9)
                  : const Color(0xFF1F3551),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildProfileImage(),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light
                              ? const Color(0xFF86A5D9)
                              : Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 230),
            child: Column(
              children: [
                const SizedBox(height: 25),
                Text(
                  name,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  email,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black.withOpacity(0.7)
                        : Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 35),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildListTile(
                          icon: Icons.edit_outlined,
                          title: "Edit Profile",
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, EditProfileScreen.routeName);
                          },
                        ),
                        const SizedBox(height: 5),
                        _buildLanguageSelector(),
                        const SizedBox(height: 5),
                        _buildThemeSelector(),
                        const SizedBox(height: 5),
                        _buildListTile(
                          icon: Icons.info_outline,
                          title: "About",
                          onTap: () {},
                        ),
                        const SizedBox(height: 5),
                        _buildListTile(
                          icon: Icons.logout,
                          title: "Logout",
                          onTap: () => _logout(context),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : AppColors.getCardColor(context),
        color: AppColors.getBackgroundColor(context),
        animationDuration: const Duration(milliseconds: 300),
        height: 60,
        index: _selectedIndex,
        items: const [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.location_on_outlined, color: Colors.white),
          Icon(Icons.textsms_outlined, color: Colors.white),
          Icon(Icons.notifications_outlined, color: Colors.white),
          Icon(Icons.person_2_outlined, color: Colors.white),
        ],
        onTap: (index) {
          if (index != _selectedIndex) {
            final routes = [
              HomeScreen.routeName,
              MapScreen.routeName,
              AiWelcomeScreen.routeName,
              NotificationScreen.routeName,
              ProfileScreen.routeName,
            ];
            Navigator.pushReplacementNamed(context, routes[index]);
          }
        },
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
          fontSize: 16,
        ),
      ),
      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            size: 16
          ),
      onTap: onTap,
    );
  }

  Widget _buildLanguageSelector() {
    return _buildListTile(
      icon: Icons.language,
      title: "Language",
      trailing: PopupMenuButton<String>(
        icon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedLanguage,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black.withOpacity(0.7)
                    : Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              size: 16,
            ),
          ],
        ),
        color: const Color(0xFF1F3551),
        onSelected: (String value) {
          setState(() {
            selectedLanguage = value;
          });
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: "English",
            child: Text(
              'English',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const PopupMenuItem<String>(
            value: "العربية",
            child: Text(
              'العربية',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _buildThemeSelector() {
    return _buildListTile(
      icon: Theme.of(context).platform == TargetPlatform.iOS
          ? CupertinoIcons.paintbrush
          : Icons.palette_outlined,
      title: "Theme",
      trailing: PopupMenuButton<AppThemeMode>(
        icon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentTheme,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black.withOpacity(0.7)
                    : Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              size: 16,
            ),
          ],
        ),
        color: const Color(0xFF1F3551),
        onSelected: (AppThemeMode value) {
          setState(() {
            switch (value) {
              case AppThemeMode.system:
                currentTheme = 'System';
                break;
              case AppThemeMode.light:
                currentTheme = 'Light';
                break;
              case AppThemeMode.dark:
                currentTheme = 'Dark';
                break;
            }
          });
          AppColors.setThemeMode(value, context);
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<AppThemeMode>>[
          const PopupMenuItem<AppThemeMode>(
            value: AppThemeMode.system,
            child: Text(
              'System',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const PopupMenuItem<AppThemeMode>(
            value: AppThemeMode.light,
            child: Text(
              'Light',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const PopupMenuItem<AppThemeMode>(
            value: AppThemeMode.dark,
            child: Text(
              'Dark',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  CircleAvatar _buildProfileImage() {
    return CircleAvatar(
      radius: 65,
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF86A5D9)
          : Colors.white,
      child: _profileImage != null
          ? ClipOval(
              child: Image.file(
                _profileImage!,
                width: 130,
                height: 130,
                fit: BoxFit.cover,
              ),
            )
          : Icon(
              Icons.person,
              size: 65,
              color: Colors.white,
            ),
    );
  }
}
