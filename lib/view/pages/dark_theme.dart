import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../navigation.dart';
import '../../util/app_theme.dart';

class CangeThemePage extends StatelessWidget {
  const CangeThemePage({Key key}) : super(key: key);

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
            ElevatedButton(
              child: const Text(' back '),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.black,
                shape: const StadiumBorder(),
              ),
              onPressed: () async {
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return Navigation();
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}