import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:road_helperr/utils/app_colors.dart';
import 'package:road_helperr/utils/text_strings.dart';
import 'signin_screen.dart';
import 'signupScreen.dart';

class OnBoarding extends StatefulWidget {
  static const String routeName = "onboarding";
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      _showLocationDisabledMessage();
    } else {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          _showLocationDisabledMessage();
        }
      }
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        final isTablet = constraints.maxWidth > 600;
        final isDesktop = constraints.maxWidth > 1200;
        final responsive = _ResponsiveSize(size, isDesktop, isTablet);

        return Scaffold(
          body: OrientationBuilder(
            builder: (context, orientation) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/background_photo.png",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: Colors.grey[300]);
                      },
                    ),
                  ),
                  Scaffold(
                    backgroundColor: Theme.of(context).brightness == Brightness.light
                        ? const Color(0xFF86A5D9)
                        : const Color(0xFF1F3551),
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Center(
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: responsive.maxContentWidth,
                              ),
                              padding: responsive.contentPadding,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(height: responsive.spacing),
                                  Image.asset(
                                    Theme.of(context).brightness == Brightness.light
                                        ? "assets/images/OnBoardingLight.png"
                                        : "assets/images/onboarding.png",
                                    width: responsive.imageWidth,
                                    height: responsive.imageHeight,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(height: responsive.spacing),
                                  _AdaptiveText(
                                    text: "If you've got the time,\nwe've got the shine",
                                    style: TextStyle(
                                      fontSize: responsive.titleSize,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: responsive.spacing),
                                  _AdaptiveText(
                                    text: "JUST THE PROTECTION\nYOU and your CAR NEED\nSPEAK TO US FOR BEST SERVICES",
                                    style: TextStyle(
                                      fontSize: responsive.subtitleSize,
                                      color: const Color(0xFFD6D1D1),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: responsive.spacing * 2),
                                  _AdaptiveButtonRow(
                                    buttonWidth: responsive.buttonWidth,
                                    buttonHeight: responsive.buttonHeight,
                                    spacing: responsive.spacing,
                                    onSignUpPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SignupScreen()),
                                    ),
                                    onSignInPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SignInScreen()),
                                    ),
                                  ),
                                  SizedBox(height: responsive.bottomSpacing),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

// Helper classes for better organization and reusability
class _ResponsiveSize {
  final Size size;
  final bool isDesktop;
  final bool isTablet;

  _ResponsiveSize(this.size, this.isDesktop, this.isTablet);

  double get maxContentWidth => isDesktop ? 1200 : 800;

  EdgeInsets get contentPadding => EdgeInsets.symmetric(
    horizontal: size.width * 0.05,
    vertical: size.height * 0.02,
  );

  double get titleSize =>
      size.width *
          (isDesktop
              ? 0.025
              : isTablet
              ? 0.035
              : 0.08);
  double get subtitleSize => titleSize * 0.5;
  double get buttonWidth =>
      size.width *
          (isDesktop
              ? 0.25
              : isTablet
              ? 0.35
              : 0.48);
  double get buttonHeight =>
      size.height *
          (isDesktop
              ? 0.08
              : isTablet
              ? 0.09
              : 0.075);
  double get imageWidth =>
      size.width *
          (isDesktop
              ? 0.3
              : isTablet
              ? 0.4
              : 0.8);
  double get imageHeight => imageWidth * 0.53;
  double get spacing => size.height * 0.04;
  double get bottomSpacing => size.height * 0.08;
  double get buttonSpacing => size.width * 0.03;
}

class _AdaptiveImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const _AdaptiveImage({
    required this.imagePath,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.error, color: Colors.red),
        );
      },
    );
  }
}

class _AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;

  const _AdaptiveText({
    required this.text,
    required this.style,
    required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        textAlign: textAlign,
        style: style,
      ),
    );
  }
}

class _AdaptiveButtonRow extends StatelessWidget {
  final double buttonWidth;
  final double buttonHeight;
  final double spacing;
  final VoidCallback onSignUpPressed;
  final VoidCallback onSignInPressed;

  const _AdaptiveButtonRow({
    required this.buttonWidth,
    required this.buttonHeight,
    required this.spacing,
    required this.onSignUpPressed,
    required this.onSignInPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth * 2.2,
      height: buttonHeight * 1.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFDAD8D8)
                    : AppColors.getAiElevatedButton(context),
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: buttonHeight * 0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(15),
                  ),
                ),
              ),
              onPressed: onSignUpPressed,
              child: Text(
                TextStrings.textButton,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  fontSize: buttonHeight * 0.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFF023A87)
                    : AppColors.getAiElevatedButton2(context),
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: buttonHeight * 0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(15),
                  ),
                ),
              ),
              onPressed: onSignInPressed,
              child: Text(
                TextStrings.textButton2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: buttonHeight * 0.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}