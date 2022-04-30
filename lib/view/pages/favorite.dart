import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../util/app_theme.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('Dark Mode'),
              trailing: Switch.adaptive(
                value: theme.isDark,
                onChanged: (_) {
                  theme.changeMode();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}