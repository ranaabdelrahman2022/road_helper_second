import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_text_field.dart';
import 'bottomnavigationbar_screes/profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = "EditProfileScreen";
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );
      
      if (image != null) {
        setState(() {
          _image = image;
        });
      }
    } catch (e) {
      // Show error message to user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to pick image. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        final isTablet = constraints.maxWidth > 600;
        final isDesktop = constraints.maxWidth > 1200;

        double titleSize = size.width *
            (isDesktop
                ? 0.02
                : isTablet
                ? 0.03
                : 0.055);
        double iconSize = size.width *
            (isDesktop
                ? 0.015
                : isTablet
                ? 0.02
                : 0.025); // Adjusted icon size
        double avatarRadius = size.width *
            (isDesktop
                ? 0.08
                : isTablet
                ? 0.1
                : 0.15);
        double padding = size.width *
            (isDesktop
                ? 0.03
                : isTablet
                ? 0.04
                : 0.05);

        return Scaffold(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF01122A),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                size: iconSize * 1.2
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, ProfileScreen.routeName);
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Edit Profile",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: titleSize,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 1200 : 800,
              ),
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: size.height * 0.04),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: avatarRadius,
                          backgroundColor: Theme.of(context).brightness == Brightness.light
                              ? const Color(0xFF86A5D9)
                              : Colors.transparent,
                          child: ClipOval(
                            child: SizedBox(
                              width: avatarRadius * 2,
                              height: avatarRadius * 2,
                              child: _image != null
                                  ? Image.file(
                                      File(_image!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      color: Theme.of(context).brightness == Brightness.light
                                          ? const Color(0xFF86A5D9)
                                          : const Color(0xFF2C4874),
                                      child: Icon(
                                        Icons.person,
                                        size: avatarRadius,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: avatarRadius * 0.3,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: avatarRadius * 0.25,
                              backgroundColor: Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xFF86A5D9)
                                  : const Color(0xFF2C4874),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: iconSize,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  const EditTextField(
                    label: "First Name",
                    icon: Icons.person, // Use IconData here
                    iconSize: 16, // Smaller icon size
                  ),
                  const EditTextField(
                    label: "Last Name",
                    icon: Icons.person, // Use IconData here
                    iconSize: 16, // Smaller icon size
                  ),
                  const EditTextField(
                    label: "Phone Number",
                    icon: Icons.phone, // Use IconData here
                    iconSize: 16, // Smaller icon size
                  ),
                  const EditTextField(
                    label: "Email",
                    icon: Icons.email, // Use IconData here
                    iconSize: 16, // Smaller icon size
                  ),
                  const EditTextField(
                    label: "Password",
                    icon: Icons.lock, // Use IconData here
                    iconSize: 16, // Smaller icon size
                    obscureText: true,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: padding),
                    padding: EdgeInsets.all(padding),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : const Color(0xFF01122A),
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.light
                              ? Colors.black
                              : Colors.grey,
                          width: 3,
                        )),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/car_settings_icon.png",
                          width: iconSize * 1.5,
                          height: iconSize * 1.5,
                          color: Theme.of(context).brightness == Brightness.light
                              ? Colors.black
                              : Colors.white,
                        ),
                        SizedBox(width: size.width * 0.02),
                        Text(
                          "Car Settings",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: titleSize * 0.7,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        const Spacer(),
                        InkWell(
                            onTap: () {
                              carSettingsModalBottomSheet(context);
                            },
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                              size: iconSize * 1.5,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: SizedBox(
                      height: size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).brightness == Brightness.light
                                ? const Color(0xFF86A5D9)
                                : const Color(0xFF023A87),
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        child: Text(
                          "Update Changes",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: titleSize * 0.8,
                            color: Theme.of(context).brightness == Brightness.light
                                ? const Color(0xFF023A87)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void carSettingsModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the bottom sheet to be scrollable
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final size = MediaQuery.of(context).size;
            double iconSize = constraints.maxWidth * 0.06;
            double padding = constraints.maxWidth * 0.04;
            double fontSize = size.width * 0.04;

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, // Adjust for keyboard
              ),
              child: Container(
                height: size.height * 0.4,
                padding: EdgeInsets.all(padding),
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : const Color(0xFF01122A),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildCarSettingInput(
                          "Car Number",
                          "assets/images/car_number.png",
                          iconSize,
                          padding,
                          fontSize),
                      _buildCarSettingInput(
                          "Car Color",
                          "assets/images/car_color.png",
                          iconSize,
                          padding,
                          fontSize),
                      _buildCarSettingInput(
                          "Car Kind",
                          "assets/images/password_icon.png",
                          iconSize,
                          padding,
                          fontSize),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCarSettingInput(String title, String iconPath, double iconSize,
      double padding, double fontSize) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding * 0.8,
        vertical: padding * 0.4
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: padding * 0.8,
          vertical: padding * 0.6
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF01122A),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.grey,
            width: 1.5
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: iconSize * 0.7,
              height: iconSize * 0.7,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            SizedBox(width: padding * 0.5),
            Expanded(
              child: TextField(
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  fontSize: fontSize * 0.9
                ),
                decoration: InputDecoration(
                  hintText: title,
                  hintStyle: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black54
                        : Colors.white54
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}