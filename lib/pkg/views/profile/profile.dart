import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/service/sphelper.dart';
import 'package:flutter_application/pkg/views/common/home_page.dart';
import 'package:flutter_application/pkg/views/profile/lang_setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // 列表项 1: 用户资料
          ListTile(
            title: const Text('用户资料'),
            onTap: () {
              // 导航到用户资料页面
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const UserProfilePage(),
              ));
            },
          ),
          // 列表项 2: 语言设置
          ListTile(
            title: Text(AppLocalizations.of(context)!.langSetting),
            onTap: () {
              // 导航到语言设置页面
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LangSetting(),
              ));
            },
          ),
          // 列表项 3: 登出
          ListTile(
            title: Text(AppLocalizations.of(context)!.logout),
            onTap: () {
              SPHelper().logOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
              Navigator.pushNamed(context, "/login");
            },
          ),
          // 可以添加更多的列表项...
        ],
      ),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户资料'),
      ),
      // 用户资料页面的内容...
    );
  }
}
