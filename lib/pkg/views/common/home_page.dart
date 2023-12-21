import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/views/common/left_draw.dart';
import 'package:flutter_application/pkg/views/contact/contact.dart';
import 'package:flutter_application/pkg/views/discover/discover.dart';
import 'package:flutter_application/pkg/views/group/group.dart';
import 'package:flutter_application/pkg/views/message/message.dart';
import 'package:flutter_application/pkg/views/profile/profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<PageData> _pageDataList = [
    PageData(page: const Message(), appBarTitle: 'Message Page'),
    PageData(page: const Contact(), appBarTitle: 'Contact Page'),
    PageData(page: const Group(), appBarTitle: 'Group Page'),
    PageData(page: const Discover(), appBarTitle: 'Discover Page'),
    PageData(page: const Profile(), appBarTitle: 'Profile Page'),
  ];

  Widget getCurrentPage(BuildContext context) {
    if (_currentIndex > _pageDataList.length) {
      return Container();
    }
    return _pageDataList[_currentIndex].page;
  }

  String getLabel(BuildContext context) {
    if (_currentIndex > _pageDataList.length) {
      return "";
    }
    var list = [
      AppLocalizations.of(context)!.messageLabel,
      AppLocalizations.of(context)!.contactsLabel,
      AppLocalizations.of(context)!.groupsLabel,
      AppLocalizations.of(context)!.discoverLabel,
      AppLocalizations.of(context)!.settingsLabel,
    ];

    return list[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    // 目前主題的未選中顏色
    Color themeUnselectedColor = Theme.of(context).unselectedWidgetColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(getLabel(context)),
      ),
      drawer: const LeftDraw(),
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
        // unselectedItemColor: const Color.fromARGB(221, 119, 75, 75),
        unselectedItemColor: themeUnselectedColor,
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

class PageData {
  final Widget page;
  final String appBarTitle;

  PageData({required this.page, required this.appBarTitle});
}
