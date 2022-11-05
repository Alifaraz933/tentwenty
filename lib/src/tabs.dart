import 'package:flutter/material.dart';
import 'package:tentwenty/src/watchPages/watch.dart';
import '../database/Theme.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _page = 1;

  @override
  void initState() {
    super.initState();
  }

  Widget getPage() {
    if (_page == 0) {
      return AnimatedContainer(
          duration: Duration(seconds: 1), child: Container());
    }
    if (_page == 1) {
      return AnimatedContainer(
        duration: Duration(seconds: 1),
        child: WatchPage(),
      );
    }
    if (_page == 2) {
      return AnimatedContainer(
        duration: Duration(seconds: 0),
        child: Container(),
      );
    }
    if (_page == 3) {
      return AnimatedContainer(
        duration: Duration(seconds: 1),
        child: Container(),
      );
    } else {
      return Container();
    }
  }

  Column tabChild(i) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 18,
          height: 18,
          margin: EdgeInsets.only(bottom: 8),
          child: Image.asset(
            i == 0
                ? 'assets/dashboard.png'
                : i == 1
                    ? 'assets/watch.png'
                    : i == 2
                        ? 'assets/library.png'
                        : 'assets/more.png',
            color: _page == i ? whiteColor : greyColor,
            height: 20,
            width: 20,
          ),
        ),
        Text(
          i == 0
              ? 'Dashboard'
              : i == 1
                  ? 'Watch'
                  : i == 2
                      ? 'Media Library'
                      : 'More',
          style: TextStyle(
              color: _page == i ? whiteColor : greyColor,
              fontSize: f10,
              fontWeight: _page == i ? w700 : w400),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: getPage(),
        bottomNavigationBar: Container(
          height: 75,
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(27), topRight: Radius.circular(27))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                4,
                (index) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _page = index;

                        setState(() {});
                      },
                      child: Container(width: 75, child: tabChild(index)),
                    )),
          ),
        ));
  }
}
