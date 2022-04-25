import 'package:flutter/material.dart';
import 'package:inheritance_distribution/services/firebase/authentication.dart';
import 'package:inheritance_distribution/services/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget  implements PreferredSizeWidget{
  final bool? closeThis;
  const CustomAppBar({Key? key, this.closeThis}) : super(key: key);


  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _CustomAppBarState extends State<CustomAppBar>{
  late bool darkMode = false;
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    darkMode = themeProvider.isDarkMode;
    return AppBar(
      actions: [
        PopupMenuButton<int>(
          onSelected: (item) => onSelected(context, item),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.brightness_4,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Dark Mode"),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Settings"),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Logout"),
                  ],
                ),
              ),
            ];
          },
        ),
      ],
    );
  }
  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        setState(() {
          darkMode = !darkMode;
          Provider.of<ThemeProvider>(context, listen: false)
              .toggleTheme(darkMode);
        });
        break;
      case 2:
        logoutNow(context);
        break;
      default:
        break;
    }
  }

  void logoutNow(context) {
    final provider = Provider.of<Auth>(context, listen: false);
    provider.signOut(context);
    if(widget.closeThis??false){
      Navigator.pop(context);
    }
  }
}
