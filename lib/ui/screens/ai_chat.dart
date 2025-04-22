import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart'; // ✅ استيراد ImagePicker
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:road_helperr/ui/screens/ai_welcome_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/home_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/map_screen.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/notification_screen.dart';
import '../screens/bottomnavigationbar_screes/profile_screen.dart';
import 'package:road_helperr/utils/app_colors.dart';
import 'package:road_helperr/utils/text_strings.dart';
import 'package:permission_handler/permission_handler.dart'; // ✅ استيراد permission_handler

class AiChat extends StatefulWidget {
  static const String routeName = "ai chat";
  final int _selectedIndex = 2;

  const AiChat({super.key});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      message: "Answer of your questions",
      details: "( Just ask me anything you like )",
      isUserMessage: false,
    ),
    ChatMessage(
      message: "Available for you all day",
      details: "( Feel free to ask me anytime )",
      isUserMessage: false,
    ),
  ];
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker(); // ✅ إنشاء picker

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;

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
                    : 0.04);
        double iconSize = size.width *
            (isDesktop
                ? 0.02
                : isTablet
                    ? 0.025
                    : 0.03);
        double imageSize = size.width *
            (isDesktop
                ? 0.15
                : isTablet
                    ? 0.2
                    : 0.3);
        double spacing = size.height *
            (isDesktop
                ? 0.04
                : isTablet
                    ? 0.05
                    : 0.06);
        double navBarHeight = size.height *
            (isDesktop
                ? 0.08
                : isTablet
                    ? 0.07
                    : 0.06);

        return Scaffold(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : AppColors.getCardColor(context),
          appBar: AppBar(
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : AppColors.getCardColor(context),
            title: Text(
              TextStrings.appBarAiChat,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontSize: titleSize,
                fontFamily:
                    platform == TargetPlatform.iOS ? '.SF Pro Text' : null,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                platform == TargetPlatform.iOS
                    ? CupertinoIcons.back
                    : Icons.arrow_back,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                size: iconSize * 1.2,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            elevation: 0,
            toolbarHeight: navBarHeight,
          ),
          body: SafeArea(
            child: Container(
              constraints:
                  BoxConstraints(maxWidth: isDesktop ? 1200 : double.infinity),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.02,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : AppColors.getCardColor(context),
              ),
              child: Column(
                children: [
                  SizedBox(height: spacing),
                  Image.asset(
                    'assets/images/ai.png',
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: spacing),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      reverse: false,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: spacing * 0.3),
                          child: InfoCard(
                            title: message.message,
                            subtitle: message.details,
                            isUserMessage: message.isUserMessage,
                          ),
                        );
                      },
                    ),
                  ),
                  _buildChatInput(context, size, titleSize, iconSize, platform),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            constraints:
                BoxConstraints(maxWidth: isDesktop ? 1200 : double.infinity),
            child: CurvedNavigationBar(
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : AppColors.getCardColor(context),
              color: const Color(0xFF023A87),
              animationDuration: const Duration(milliseconds: 300),
              height: navBarHeight,
              index: widget._selectedIndex,
              items: [
                Icon(
                    platform == TargetPlatform.iOS
                        ? CupertinoIcons.home
                        : Icons.home_outlined,
                    size: iconSize,
                    color: Colors.white),
                Icon(
                    platform == TargetPlatform.iOS
                        ? CupertinoIcons.location
                        : Icons.location_on_outlined,
                    size: iconSize,
                    color: Colors.white),
                Icon(
                    platform == TargetPlatform.iOS
                        ? CupertinoIcons.chat_bubble
                        : Icons.textsms_outlined,
                    size: iconSize,
                    color: Colors.white),
                Icon(
                    platform == TargetPlatform.iOS
                        ? CupertinoIcons.bell
                        : Icons.notifications_outlined,
                    size: iconSize,
                    color: Colors.white),
                Icon(
                    platform == TargetPlatform.iOS
                        ? CupertinoIcons.person
                        : Icons.person_2_outlined,
                    size: iconSize,
                    color: Colors.white),
              ],
              onTap: (index) => _handleNavigation(context, index),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatInput(BuildContext context, Size size, double titleSize,
      double iconSize, TargetPlatform platform) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
        horizontal: size.width * 0.04,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 120),
              child: TextField(
                controller: _messageController,
                maxLines: null,
                minLines: 1,
                style: TextStyle(
                  fontSize: titleSize * 0.8,
                  fontFamily:
                      platform == TargetPlatform.iOS ? '.SF Pro Text' : null,
                ),
                decoration: InputDecoration(
                  hintText: TextStrings.hintChatText,
                  hintStyle: TextStyle(
                    fontSize: titleSize * 0.8,
                    fontFamily:
                        platform == TargetPlatform.iOS ? '.SF Pro Text' : null,
                  ),
                  filled: true,
                  fillColor: isLightMode ? const Color(0xFFCCC9C9) : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      platform == TargetPlatform.iOS
                          ? CupertinoIcons.camera
                          : Icons.camera_alt_outlined,
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color(0xFF023A87)
                          : AppColors.basicButton,
                      size: iconSize,
                    ),
                    onPressed: _showCameraConfirmationDialog,
                  ),
                  contentPadding: EdgeInsets.all(size.width * 0.03),
                ),
                onSubmitted: (text) {
                  _sendMessage();
                },
              ),
            ),
          ),
          SizedBox(width: size.width * 0.03),
          Container(
            constraints: BoxConstraints(
              maxWidth: iconSize * 2.5,
              maxHeight: iconSize * 2.5,
            ),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? const Color(0xFF023A87)
                  : AppColors.getAiElevatedButton(context),
              radius: iconSize,
              child: IconButton(
                icon: Icon(
                  platform == TargetPlatform.iOS
                      ? CupertinoIcons.arrow_right
                      : Icons.send,
                  color: Colors.white,
                  size: iconSize * 0.8,
                ),
                onPressed: _sendMessage,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          message: message,
          details: "",
          isUserMessage: true,
        ));
        _messageController.clear();
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _handleNavigation(BuildContext context, int index) {
    final routes = [
      HomeScreen.routeName,
      MapScreen.routeName,
      AiWelcomeScreen.routeName,
      NotificationScreen.routeName,
      ProfileScreen.routeName,
    ];

    if (index < routes.length) {
      Navigator.pushNamed(context, routes[index]);
    }
  }

  // ✅ Dialog التأكيد
  Future<void> _showCameraConfirmationDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Camera Access'),
          content: const Text('Do you allow access to the camera?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Deny'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Allow'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      // إذا وافق المستخدم على الوصول إلى الكاميرا
      await _pickImageFromCamera();
    }
  }

  Future<void> _pickImageFromCamera() async {
    final permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        // إذا تم التقاط صورة بنجاح
        // يمكنك هنا إضافة الكود لرفع الصورة أو التعامل معها
      } else {
        // إذا لم يتم التقاط صورة
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No image selected")),
        );
      }
    } else {
      // إذا لم يتم منح صلاحية الوصول إلى الكاميرا
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera permission denied")),
      );
    }
  }
}

class ChatMessage {
  final String message;
  final String details;
  final bool isUserMessage;

  ChatMessage({
    required this.message,
    required this.details,
    required this.isUserMessage,
  });
}

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isUserMessage;

  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    
    return Card(
      color: isLightMode
          ? const Color(0xFF023A87)
          : (isUserMessage ? Colors.white : AppColors.getStackColor(context)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      margin: const EdgeInsets.all(8.0),
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 50,
          maxWidth: double.infinity,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isLightMode
                      ? Colors.white
                      : (isUserMessage ? Colors.black : Colors.white),
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: isLightMode
                        ? Colors.white70
                        : (isUserMessage ? Colors.black54 : Colors.white70),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
