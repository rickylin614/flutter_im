import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/service/state.dart';
import 'package:flutter_application/pkg/views/profile/lang_setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeftDraw extends StatefulWidget {
  const LeftDraw({super.key});

  @override
  State<LeftDraw> createState() => _LeftDrawState();
}

class _LeftDrawState extends State<LeftDraw> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Ricky"),
            accountEmail: Text("ricky.lin@test.com"),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green[800],
              child: const Icon(Icons.person, color: Colors.white),
            ),
            title: const Text("添加新联系人"),
            onTap: () {
              // 处理添加新联系人的操作
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[800],
              child: const Icon(Icons.group, color: Colors.white),
            ),
            title: const Text("添加新群组"),
            onTap: () {
              // 处理添加新群组的操作
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.color_lens, color: Colors.white),
            ),
            title: const Text("切换主题颜色"),
            trailing: Switch(
              value: BlocProvider.of<ThemeBloc>(context).isDarkTheme,
              onChanged: (value) {
                final themeBloc = BlocProvider.of<ThemeBloc>(context);
                themeBloc.toggleTheme(context);
                // setState(() {});
              },
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.language, color: Colors.white),
            ),
            title: Text(AppLocalizations.of(context)!.langSetting),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LangSetting(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
