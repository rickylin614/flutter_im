import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/views/contact/contact.dart';
import 'package:flutter_application/pkg/views/discover/discover.dart';
import 'package:flutter_application/pkg/views/group/group.dart';
import 'package:flutter_application/pkg/views/message/message.dart';
import 'package:flutter_application/pkg/views/profile/profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationBars extends StatefulWidget {
  const NavigationBars({super.key});

  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  int _currentIndex = 0;

  final List _pageList = [
    const Message(),
    const Contact(),
    const Group(),
    const Discover(),
    const Profile(),
  ];

  Widget getCurrentPage(BuildContext context) {
    if (_currentIndex > _pageList.length) {
      return Container();
    }
    return _pageList[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home Page'),
      // ),
      body: getCurrentPage(context),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.message),
              label: AppLocalizations.of(context)!.messageLabel,
              activeIcon: const Icon(Icons.home)),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_pin_sharp),
            label: AppLocalizations.of(context)!.contactsLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.groups),
            label: AppLocalizations.of(context)!.groupsLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: AppLocalizations.of(context)!.discoverLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context)!.settingsLabel,
          ),
        ],
        backgroundColor: Colors.blue[200],
        unselectedItemColor: const Color.fromARGB(221, 119, 75, 75),
        selectedItemColor: Colors.red,
        showUnselectedLabels: true, // 顯示非選取的標籤
        currentIndex: _currentIndex,
        onTap: (index) {
          // 需要設定點擊動作 切換頁面才會有動作
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
