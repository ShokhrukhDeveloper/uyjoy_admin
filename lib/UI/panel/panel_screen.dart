import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:uy_admin/UI/panel/pages/announce_info/announce_info.dart';
import 'package:uy_admin/UI/panel/pages/announcements/announcement.dart';
import 'package:uy_admin/UI/panel/pages/announce_add/announcement_add.dart';



class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}
enum screenType{
  home,
  productAdd
}
class _AdminPanelState extends State<AdminPanel> {
  // List<PlatformFile>? _files;

  int _selectedIndex = 1;

  static  final List<Widget> _pages = [

    const AnnouncementWidget(),
    const AnnounceInfo(),
    const Icon(Icons.u_turn_left),
    const Icon(Icons.u_turn_left),
    const Icon(Icons.face),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
screenType screen=screenType.home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:MediaQuery.of(context).size.width<600? NavigationSidebar(selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,)
          :
      const SizedBox(),
      appBar: AppBar(
        title:  const InkWell(
          child: Text('Admin Panel'),

        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar Navigation Menu
          if(MediaQuery.of(context).size.width>=600) NavigationSidebar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
          // Main Content Area
          Expanded(
            child:screen==screenType.productAdd?AnnouncementAdd(onTapBack: () {
              setState(() {
                screen=screenType.home;
              });
            },): _pages[_selectedIndex],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.plus_one),onPressed: (){
        screen=screenType.productAdd;
        setState(() {

        });
      },),
    );
  }
}

class NavigationSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const NavigationSidebar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Admin Panel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Uylar'),
            leading: const Icon(Icons.category),
            selected: selectedIndex == 0,
            onTap: () => onItemTapped(0),
          ),
          ListTile(
            title: Text('Subjects'),
            leading: Icon(Icons.subject),
            selected: selectedIndex == 1,
            onTap: () => onItemTapped(1),
          ),
          ListTile(
            title: Text('Products'),
            leading: Icon(Icons.shopping_bag),
            selected: selectedIndex == 2,
            onTap: () => onItemTapped(2),
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            selected: selectedIndex == 3,
            onTap: () => onItemTapped(3),
          ),
        ],
      ),

    );
  }
}