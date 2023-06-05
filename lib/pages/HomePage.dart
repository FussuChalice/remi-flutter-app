import 'dart:io';
import 'package:flutter/material.dart';
import '../platform_sizes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class ChipData {
  Text label;
  bool isSelected;
  Color bgColor;

  ChipData(this.label, this.isSelected, this.bgColor);
}
/// I put this code under classes, because if I put back I will have an error

class _HomePageState extends State<HomePage> {

  // Don't edit this func !!!
  List<Widget> buildFilterChips(List<ChipData> structure) {
    List<Widget> result = [];
    for (int i = 0; i < structure.length; i++) {
      Widget temp = Padding(padding: EdgeInsets.only(left: 4), child: FilterChip(
        label: structure[i].label,
        shape: StadiumBorder(side: BorderSide(color: Colors.black)),
        selectedColor: Color(0xFFFCA311),
        backgroundColor: structure[i].bgColor,
        onSelected: (bool value) {
          setState(() {
            filter_adds[i] = value;
            structure[i].isSelected = value;
          });
          print(structure[i].isSelected);
        },
        selected: structure[i].isSelected,
      ),);
      result.add(temp);
    }
    return result;
  }

  List<bool> filter_adds = [true, false, false, false, false];
  List<int> loadedCardID = [];
  int loadedCount = 0;

  List<ChipData> chipsets = [
    ChipData(Text("Restaurants"), true, Colors.white),
    ChipData(Text("Coffees"), false, Colors.white),
    ChipData(Text("Bars"), false, Colors.white),
    ChipData(Text("Pizzeria"), false, Colors.white),
    ChipData(Text("Pub"), false, Colors.white),
  ];



  List<Color> navButtonColors = [Color(0xFFFCA311), Color(0xFF1C1B1F), Color(0xFF1C1B1F),];

  int _selectedBottomNavIndex = 0;

  MapType _currentMapType = MapType.normal;
  LatLng _initialCameraPosition = LatLng(20.5937, 78.9629);

  @override

  Widget build(BuildContext context) {

    PlatformSizes PSize = PlatformSizes(Platform.operatingSystem, context);
    PSize.initScreenSize();

    TextEditingController _SearchController = TextEditingController();

    Widget _homePageInStack = Stack(
      children: [
        Positioned(
          top: 0,
          child: Container(
            width: PSize.ScreenWidth(),
            height: 151,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(25, 0, 0, 0),
                    spreadRadius: 0,
                    blurRadius: 39,
                    offset: Offset(0, 4)
                ),
              ],
            ),
            child: Stack(
                children: <Widget>[

                  Positioned(
                    // SearchBox
                    top: 35,
                    left: PSize.ScreenWidth() / 23,
                    child: Container(
                      width: PSize.ScreenWidth() / 1.3,
                      height: 41,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular((PSize.ScreenWidth() / 2) / 2),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 10,
                            bottom: 0 - 3,
                            child: TextField(
                              cursorColor: Color(0xFFFCA311),
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                              ),
                              controller: _SearchController,
                            ),
                            width: (PSize.ScreenWidth() / 1.3) - 50,
                          ),
                          // Search button
                          Positioned(
                            right: 0 - 10,
                            bottom: 0 - 2.5,
                            child: TextButton(
                              onPressed: () {/* search */},
                              child: Image.asset(
                                'assets/icons/search.png',
                                height: 24,
                              ),
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(Colors.transparent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      right: PSize.ScreenWidth() / 23,
                      top: 35,
                      width: 41,
                      height: 41,
                      child: TextButton(
                        child: Image.asset(
                          'assets/icons/tune.png',
                          width: 15,
                        ),
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.5),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                      )
                  ),
                  Positioned(
                      top: 85,
                      left: 11,
                      width: PSize.ScreenWidth(),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: buildFilterChips(chipsets),
                        ),
                      )
                  ),
                ]
            ),
          ),
        ),
        Positioned(
            width: PSize.ScreenWidth(),
            top: 151,
            height: PSize.ScreenHeight() - (151),
            child: Text("Hello, App!"),
        ),
      ],
    );

    Widget _mapsPageInStack = Stack(
      children: [
        Positioned(
          top: 0,
          child: Container(
            width: PSize.ScreenWidth(),
            height: 151,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(25, 0, 0, 0),
                    spreadRadius: 0,
                    blurRadius: 39,
                    offset: Offset(0, 4)
                ),
              ],
            ),
            child: Stack(
                children: <Widget>[

                  Positioned(
                    // SearchBox
                    top: 35,
                    left: PSize.ScreenWidth() / 23,
                    child: Container(
                      width: PSize.ScreenWidth() / 1.3,
                      height: 41,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular((PSize.ScreenWidth() / 2) / 2),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 10,
                            bottom: 0 - 3,
                            child: TextField(
                              cursorColor: Color(0xFFFCA311),
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                              ),
                              controller: _SearchController,
                            ),
                            width: (PSize.ScreenWidth() / 1.3) - 50,
                          ),
                          // Search button
                          Positioned(
                            right: 0 - 10,
                            bottom: 0 - 2.5,
                            child: TextButton(
                              onPressed: () {/* search */},
                              child: Image.asset(
                                'assets/icons/search.png',
                                height: 24,
                              ),
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(Colors.transparent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      right: PSize.ScreenWidth() / 23,
                      top: 35,
                      width: 41,
                      height: 41,
                      child: TextButton(
                        child: Image.asset(
                          'assets/icons/tune.png',
                          width: 15,
                        ),
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.5),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                      )
                  ),
                  Positioned(
                      top: 85,
                      left: 11,
                      width: PSize.ScreenWidth(),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: buildFilterChips(chipsets),
                        ),
                      )
                  ),
                ]
            ),
          ),
        ),

        Positioned(
            width: PSize.ScreenWidth(),
            height: PSize.ScreenHeight() - (151 + 58),
            top: 151,
            left: 0,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: _initialCameraPosition),
              mapType: _currentMapType,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            ),
        ),
        Positioned(
            top: 151 + 60,
            right: 12,
            height: 37,
            width: 38,
            child: InkWell(
              onTap: () {
                setState(() {
                  _currentMapType = (_currentMapType == MapType.hybrid) ? MapType.normal : MapType.hybrid;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  border: Border.all(color: Colors.grey, width: 0.2),
                  borderRadius: BorderRadius.all(Radius.circular(2))
                ),
                child: Icon(Icons.layers_outlined, color: Color(0xFF4b4f52)),
              ),
            )
        ),
      ],
    );

    Widget _profilePageInStack = Stack(
      children: [],
    );

    List<Widget> _pages = [_homePageInStack, _mapsPageInStack, _profilePageInStack];


    void _onBottomNavTap(int index) {
      setState(() {
        _selectedBottomNavIndex = index;
      });

    }

    return Scaffold(
     backgroundColor: Colors.white,
      body: _pages.elementAt(_selectedBottomNavIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFBFBFB),
        selectedItemColor: Color(0xFFFCA311),
        unselectedItemColor: Color(0xFF1C1B1F),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: _onBottomNavTap,
        currentIndex: _selectedBottomNavIndex,
      ),
    );
  }
}
