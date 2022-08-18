import 'package:busbro_flutter/routes/maps.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';

import 'routes/nearme.dart';
import 'routes/favourite.dart';
import 'routes/search.dart';
import 'routes/more.dart';

class TabbedApp extends StatefulWidget {
  @override
  TabbedAppState createState() => TabbedAppState();
}

class TabbedAppState extends State<TabbedApp> {
  int _selectedIndex = 0;
  static List<Widget> _tabViews = <Widget>[
    FavouritePage(),
    //MapsPage(),
    NearMePage(),
    SearchPage(),
    MorePage()
  ];

  static List<BottomNavigationBarItem> _tabs(BuildContext context) => [
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heartPulse), label: 'Favourite'),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.mapMarkerAlt), label: 'Main'),
        BottomNavigationBarItem(
            icon: GestureDetector(
              child: FaIcon(FontAwesomeIcons
                  .searchengin), // onTap: () => _enteringSearchPage(context),
            ),
            label: 'Search'),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.sliders), label: 'More'),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            // use below to not save state between tab state
            child: _tabViews[_selectedIndex],

            // use below to save state between tab switch
            // child: IndexedStack(
            //   index: _selectedIndex,
            //   children: _tabViews,
            // ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigationBar(
              landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: Color.fromARGB(255, 13, 35, 100),
              type: BottomNavigationBarType.fixed,
              elevation: 2,
              items: _tabs(context),
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              unselectedIconTheme:
                  IconThemeData(size: 24, color: Colors.black45),
              selectedIconTheme: IconThemeData(size: 30),
            ),
          )
        ],
      ),
    );
  }

  static void _enteringSearchPage(BuildContext context) {
    // if no stops found is true from search provider, we need to set it to false
    // final SearchProvider searchProvider = Provider.of<SearchProvider>(context, listen: false);
    // searchProvider.noStopsFound = false;
  }
}
