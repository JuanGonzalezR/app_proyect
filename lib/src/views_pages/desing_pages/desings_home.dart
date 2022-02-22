import 'package:app/src/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    final _homeBloc = Provider.ofHomeBloc(context);
    return StreamBuilder(
      stream: _homeBloc.currentIndexPage,
      builder: (context, AsyncSnapshot<int> snapshot) {
        int? _currentIndex = 0;
        if (snapshot.hasData) {
          _currentIndex = snapshot.data;
        }
        return SalomonBottomBar(
          currentIndex: _currentIndex ?? 0,
          onTap: (i) => setState(() {_homeBloc.changeCurrentIndexPage(i);}),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(LineAwesomeIcons.home),
              title: const Text("Inicio"),
              selectedColor: Colors.purple,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: const Icon(LineAwesomeIcons.bell),
              title: const Text("Notificaciones"),
              selectedColor: Colors.pink,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(LineAwesomeIcons.folder_open),
              title: const Text("Servicio"),
              selectedColor: Colors.orange,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(LineAwesomeIcons.user_circle),
              title: const Text("Perfil"),
              selectedColor: Colors.teal,
            ),
          ],
        );
      },
    );
  }
}
