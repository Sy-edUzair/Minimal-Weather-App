import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/theme/theme_provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text("Dark Mode"),
        ),
        Expanded(
          child: Consumer<ThemeProvider>(
            builder: (context, notifier, child) => Switch(
              value: notifier.isDarkModeEnabled,
              onChanged: (value) {
                notifier.toggleTheme();
              },
              thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return const Icon(Icons.nightlight, color: Colors.white);
                }
                return const Icon(Icons.sunny);
              }),
            ),
          ),
        ),
      ],
    );
  }
}
