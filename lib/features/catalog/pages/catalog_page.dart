import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lusy_in_the_sky/features/catalog/blocs/catalog_bloc/catalog_bloc.dart';
import 'package:lusy_in_the_sky/features/catalog/widgets/widgets.dart';

class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage>
    with SingleTickerProviderStateMixin {
  // ignore: close_sinks
  CatalogBloc _catalogBloc;
  TabController _tabController;
  int _currentTab;

  @override
  void initState() {
    super.initState();
    _currentTab = 0;
    _catalogBloc = BlocProvider.of<CatalogBloc>(context);
    _catalogBloc.add(GetCatalogItemListEvent());
    _tabController = TabController(length: 1, vsync: this);
    _tabController.addListener(() {
      _currentTab = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            TabBarView(
              controller: _tabController,
              children: [
                ItemTab(),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                color: Colors.black.withOpacity(0.2),
                width: ScreenUtil().setWidth(375),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MainPageTabButton(
                        icon: 'assets/button_images/home.png',
                        text: 'Home',
                        onPressed: () {
                          _tabController.animateTo(0);
                          setState(() {
                            _currentTab = 0;
                          });
                        },
                        current: _currentTab == 0,
                      ),
                      MainPageTabButton(
                        icon: 'assets/button_images/search.png',
                        text: 'Discover',
                        onPressed: () {
                          setState(() {
                            _currentTab = 1;
                          });
                        },
                        current: _currentTab == 1,
                      ),
                      MainPageCentralButton(
                        icon: 'assets/button_images/main.png',
                        onPressed: () {
                          setState(() {
                            _currentTab = 2;
                          });
                        },
                      ),
                      MainPageTabButton(
                        icon: 'assets/button_images/inbox.png',
                        text: 'Inbox',
                        onPressed: () {
                          setState(() {
                            _currentTab = 3;
                          });
                        },
                        current: _currentTab == 3,
                      ),
                      MainPageTabButton(
                        icon: 'assets/button_images/me.png',
                        text: 'Me',
                        onPressed: () {
                          setState(() {
                            _currentTab = 4;
                          });
                        },
                        current: _currentTab == 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
