import 'package:flutter/material.dart';
import 'package:inheritance_distribution/screens/deceased_info_form.dart';
import 'package:inheritance_distribution/services/theme_provider.dart';
import 'package:inheritance_distribution/widgets/custom_app_bar.dart';
import 'package:inheritance_distribution/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    darkMode = themeProvider.isDarkMode;
    return SafeArea(
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: const CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text("Hello"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PersonInformation(),
                fullscreenDialog: true,
              ),
            );
          },
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).scaffoldBackgroundColor,
          tooltip: "Add new Entry",
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
