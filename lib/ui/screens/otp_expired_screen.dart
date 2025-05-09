import 'package:flutter/material.dart';
import 'package:road_helperr/ui/screens/otp_screen.dart';
import 'package:road_helperr/ui/screens/signin_screen.dart';

class OtpExpiredScreen extends StatefulWidget {
  static const String routeName = "otpexpired";
  const OtpExpiredScreen({super.key});

  @override
  State<OtpExpiredScreen> createState() => _OtpExpiredScreenState();
}

class _OtpExpiredScreenState extends State<OtpExpiredScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final responsive = ResponsiveHelper(
          context: context,
          constraints: constraints,
        );

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: _buildMainContent(responsive),
          ),
        );
      },
    );
  }

  Widget _buildMainContent(ResponsiveHelper responsive) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: responsive.maxContentWidth,
          ),
          padding: EdgeInsets.all(responsive.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildWarningIcon(responsive),
              SizedBox(height: responsive.spacing),
              _buildErrorMessage(responsive),
              SizedBox(height: responsive.largeSpacing * 2.5),
              _buildRequestOtpButton(responsive),
              SizedBox(height: responsive.spacing),
              _buildBackToLoginButton(responsive),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarningIcon(ResponsiveHelper responsive) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: AdaptiveIcon(
        icon: Icons.warning_amber_rounded,
        color: Colors.red,
        size: responsive.iconSize,
      ),
    );
  }

  Widget _buildErrorMessage(ResponsiveHelper responsive) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: AdaptiveText(
        'The OTP has expired!',
        style: TextStyle(
          color: Colors.black,
          fontSize: responsive.titleSize,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRequestOtpButton(ResponsiveHelper responsive) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: AdaptiveButton(
        text: 'Request OTP',
        onPressed: () {
          Navigator.of(context).pushNamed(OtpScreen.routeName);
        },
        width: double.infinity,
        height: responsive.buttonHeight,
        maxWidth: responsive.buttonMaxWidth,
        fontSize: responsive.buttonFontSize,
        backgroundColor: const Color(0xFF023A87),
        padding: responsive.buttonPadding,
        textColor: Colors.white,
        borderRadius: 20,
      ),
    );
  }

  Widget _buildBackToLoginButton(ResponsiveHelper responsive) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: double.infinity,
        height: responsive.buttonHeight,
        constraints: BoxConstraints(maxWidth: responsive.buttonMaxWidth),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(SignInScreen.routeName);
        },
        style: TextButton.styleFrom(
            padding: responsive.buttonPadding,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Color(0xFF808080)),
            ),
        ),
        child: Text(
          'Back to Login',
          style: TextStyle(
              color: const Color(0xFF808080),
            fontSize: responsive.buttonFontSize,
            fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _handleRequestOtp() {
    onpressed() {
      Navigator.of(context).pushNamed(OtpScreen.routeName);
    }
  }

  void _handleBackToLogin() {
    onpressed() {
      Navigator.of(context).pushNamed(SignInScreen.routeName);
    }
  }
}

// Helper Classes
class ResponsiveHelper {
  final BuildContext context;
  final BoxConstraints constraints;
  final Size size;

  ResponsiveHelper({
    required this.context,
    required this.constraints,
  }) : size = MediaQuery.of(context).size;

  bool get isTablet => constraints.maxWidth > 600;
  bool get isDesktop => constraints.maxWidth > 1200;

  double get iconSize =>
      size.width *
          (isDesktop
              ? 0.12
              : isTablet
              ? 0.16
              : 0.2);
  double get titleSize =>
      size.width *
          (isDesktop
              ? 0.035
              : isTablet
              ? 0.045
              : 0.06);
  double get buttonFontSize =>
      size.width *
          (isDesktop
              ? 0.02
              : isTablet
              ? 0.03
              : 0.045);
  double get buttonHeight =>
      size.height *
          (isDesktop
              ? 0.07
              : isTablet
              ? 0.08
              : 0.09);
  double get padding =>
      size.width *
          (isDesktop
              ? 0.04
              : isTablet
              ? 0.05
              : 0.06);
  double get spacing => size.height * 0.03;
  double get largeSpacing => size.height * 0.06;

  double get maxContentWidth => isDesktop
      ? 800
      : isTablet
      ? 600
      : double.infinity;
  double get buttonMaxWidth => isDesktop
      ? 400
      : isTablet
      ? 300
      : double.infinity;

  EdgeInsets get buttonPadding => EdgeInsets.symmetric(vertical: padding * 0.5);
}

// Adaptive Widgets
class AdaptiveIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const AdaptiveIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }
}

class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const AdaptiveText(
      this.text, {
        super.key,
        this.style,
        this.textAlign,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
    );
  }
}

class AdaptiveButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double maxWidth;
  final double fontSize;
  final Color backgroundColor;
  final EdgeInsets padding;
  final Color textColor;
  final double borderRadius;

  const AdaptiveButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.maxWidth,
    required this.fontSize,
    required this.backgroundColor,
    required this.padding,
    this.textColor = Colors.white,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}