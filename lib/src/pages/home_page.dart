import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/authentication/authentication_bloc.dart';
import 'package:si_app/src/pages/plots/plot_list.dart';
import 'package:si_app/src/pages/settings_page.dart';
import 'package:si_app/src/widgets/fructify_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  final List<Widget> _pages = [
    const PlotList(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FructifyAppBar(onClick: switchPage),
      body: _pages[_currentPage],
    );
  }

  void switchPage(int newPageIndex) {
    setState(() {
      _currentPage = newPageIndex;
    });
  }
}
