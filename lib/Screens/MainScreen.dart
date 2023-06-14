import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Common/Enums.dart';
import 'package:nike/Data/Repos/Cart/CartRepository.dart';
import 'package:nike/Screens/Cart/CartScreen.dart';
import 'package:nike/Screens/Home/HomeScreen.dart';
import 'package:nike/Screens/Profile/ProfileScreen.dart';
import 'package:nike/Screens/Widget/Badge.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<NavigatorState> _profileKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _homeKey = GlobalKey<NavigatorState>();

  Map<ScreenName, GlobalKey<NavigatorState>> _myMap = {};

  List<ScreenName> _history = [];
  ScreenName currentScreen = ScreenName.HOME;

  @override
  void initState() {
    _myMap = {
      ScreenName.PROFILE: _profileKey,
      ScreenName.CARD: _cartKey,
      ScreenName.HOME: _homeKey,
    };
    cartRepository.GetCount();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentScreen.index,
            onTap: (int index) {
              setState(() {
                _history.remove(currentScreen);
                _history.add(currentScreen);
                currentScreen = ScreenName.values.elementAt(index);
              });
            },
            items: [
              const BottomNavigationBarItem(
                label: 'خانه',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'سبد خرید',
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.card_travel_sharp),
                    Positioned(
                      right: -10,
                      top: -2,
                      child: ValueListenableBuilder<int>(
                        valueListenable: CartRepository.cartItemCountNotifier,
                        builder:
                            (BuildContext context, int value, Widget? child) {
                          return Badge(value: value);
                        },
                      ),
                    )
                  ],
                ),
              ),
              const BottomNavigationBarItem(
                label: 'پروفایل',
                icon: Icon(CupertinoIcons.person),
              ),
            ],
          ),
          body: IndexedStack(
            index: currentScreen.index,
            children: [
              Navigator(
                key: _homeKey,
                onGenerateRoute: (RouteSettings setting) => MaterialPageRoute(
                  builder: (BuildContext context) => const HomeScreen(),
                ),
              ),
              Navigator(
                key: _cartKey,
                onGenerateRoute: (RouteSettings setting) => MaterialPageRoute(
                  builder: (BuildContext context) => const CartScreen(),
                ),
              ),
              Navigator(
                key: _profileKey,
                onGenerateRoute: (RouteSettings setting) => MaterialPageRoute(
                  builder: (BuildContext context) => const ProfileScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    NavigatorState currentState = _myMap[currentScreen]!.currentState!;
    if (currentState.canPop()) {
      currentState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        currentScreen = _history.last;
        _history.removeLast();
      });
      return false;
    } else {
      return true;
    }
  }
}
