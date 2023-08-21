import 'package:app_pizzeria/screen/user_account.dart';
import 'package:app_pizzeria/widget/user_widget/top_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper.dart';
import '../providers/page_provider.dart';
import '../providers/user_infos_provider.dart';
import '../widget/user_widget/profile_menu.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final token = await fcm.getToken();

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      Provider.of<UserInfoProvider>(context, listen: false).addToken(token!);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Provider.of<PageProvider>(context, listen: false).changePage(2);
    });

    if (context.mounted) {
      Provider.of<UserInfoProvider>(context, listen: false).addToken(token!);
    }
    
    fcm.subscribeToTopic('utenti');
  }

  @override
  void initState() {
    super.initState();
    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final info = Provider.of<UserInfoProvider>(context, listen: false);
    info.getUser();

    return Column(
      children: [
        const TopBanner(
          title: 'Account',
          icon: Icons.account_box_outlined,
        ),
        Expanded(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundImage: getImage(context),
                  maxRadius: 50,
                ),
              ),
              const SizedBox(height: 20),
              ProfileMenu(
                text: "Il mio Account",
                icon: "assets/images/user_icon.svg",
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const UserAccountScreen()),
                  );
                },
              ),
              ProfileMenu(
                text: "Log Out",
                icon: "assets/images/logout.svg",
                press: () {
                  logOut(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
