import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/chat_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LangSetting extends StatefulWidget {
  const LangSetting({super.key});

  @override
  State<LangSetting> createState() => _LangSettingState();
}

class _LangSettingState extends State<LangSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.langSetting),
        ),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
          children: <Widget>[
            // 切换为英语
            ListTile(
              title: const Text('Switch to English'),
              onTap: () {
                // 切换为英语
                changeLocale(const Locale('en', ''));
              },
            ),
            // 切换为中文
            ListTile(
              title: const Text('切换到中文'),
              onTap: () {
                // 切换为中文
                changeLocale(const Locale('zh', ''));
              },
            ),
          ],
        )));
  }

  void changeLocale(Locale newLocale) {
    setState(() {
      // 更新应用程序的locale设置
      ChatApp.of(context)?.setLocale(newLocale);
    });
  }
}
