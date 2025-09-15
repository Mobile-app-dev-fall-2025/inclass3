import 'package:flutter/material.dart';

// Three main visual componetnts app bar, scaffold, text

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // INCREASE LENGTH
      home: DefaultTabController(length: 4, child: _TabsNonScrollableDemo()),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;
  final RestorableInt tabIndex = RestorableInt(0);
  @override
  String get restorationId => 'tab_non_scrollable_demo';
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  // life cycle method
  void initState() {
    super.initState();

    // increase length
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // For the To do task hint: consider defining the widget and name of the tabs here
    final tabs = ['Cat 1', 'Cat 2', 'Cat 3', 'Cat 4'];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Which cat is the best?',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 101, 196),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [for (final tab in tabs) Tab(text: tab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // First tab → red background
          Container(
            color: Colors.red.shade50,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Spinning Cat',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.network(
                    'https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExNXA0NHVhMXJhd213c2s0b3ljOXM2ODJqZ2w3cXIxdjdzcnQ0ZmxtOCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/ztisqLhP99tVSHG136/giphy.gif',
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
            ),
          ),

          // Second tab → blue background
          Container(
            color: Colors.blue.shade50,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sus Cat',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.network(
                    'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExcThzM2Nva3U5Ynp0MGhzdW9hNzY5YXMyeWx6NWI4YW1idGkxeHZmOSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/wr7oA0rSjnWuiLJOY5/giphy.gif',
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
            ),
          ),

          // Third tab → green background
          Container(
            color: Colors.green.shade50,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Cat Dev',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.network(
                    'https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExM3FhNjNhNHBnYzl0ZzNxZ2hsZ3ZhN2R3YThyNnM3aW1zcHYxNm9xdiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/lJNoBCvQYp7nq/giphy.gif',
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
            ),
          ),

          // Fourth tab → purple background
          Container(
            color: Colors.purple.shade50,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Scared Cat',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.network(
                    'https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExcmszMW96djFxcXFzNm9xbmtsZGVyNWZ0YjIyNXF6eHhvOHNrdnlxNCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/nR4L10XlJcSeQ/giphy.gif',
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
