import 'package:app/src/providers/provider.dart';
import 'package:app/src/views_pages/desing_pages/desings_home.dart';
import 'package:app/src/views_pages/home_menu_pages/home.dart';
import 'package:app/src/views_pages/home_menu_pages/notifys.dart';
import 'package:app/src/views_pages/home_menu_pages/profile_service.dart';
import 'package:app/src/views_pages/home_menu_pages/profile_user.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
 }

class _HomePageState extends State<HomePage> {
 
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: _BodyHome(),
     bottomNavigationBar: const CustomBottomNavigationBar(),
   );
  }
}

class _BodyHome extends StatelessWidget {
 @override
 Widget build(BuildContext context) {

   final _homeBloc = Provider.ofHomeBloc(context);
  
  return StreamBuilder(
    stream: _homeBloc.currentIndexPage,
    initialData: 0,
    builder: (BuildContext context, AsyncSnapshot<int> snap){
    //int? currentIndex = snap.data;
      switch (3) {
    case 0:
      return const Home();
    case 1:
      return const Notifications();
    case 2:
      return const ProfileService();
    case 3:
      return const ProfileUser();
    default:
      return const Notifications();
  }
    },
  );
  
  
 }
}