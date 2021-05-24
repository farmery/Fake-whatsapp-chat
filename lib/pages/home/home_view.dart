import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'calls/calls.dart';
import 'chats/chats.dart';
import 'status/status.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xff262D31),
              elevation: 0,
              floating: true,
              pinned: true,
              snap: true,
              title: Text(
                'Fake Whatsapp',
              ),
              actions: [
                CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    onPressed: () {})
              ],
              bottom: PreferredSize(
                child: TabBar(
                    controller: tabController,
                    unselectedLabelColor: Colors.white.withOpacity(0.50),
                    labelColor: Color(0xff00AF9C),
                    tabs: [
                      Tab(
                        text: 'CHATS',
                      ),
                      Tab(
                        text: 'STATUS',
                      ),
                      Tab(text: 'CALLS'),
                    ]),
                preferredSize: Size.fromHeight(60),
              ),
            ),
            SliverFillRemaining(
                child: TabBarView(
              controller: tabController,
              children: [Chats(), Status(), Calls()],
            ))
          ],
        ),
      ),
    );
  }
}
