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
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Which cat is the best?'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [for (final tab in tabs) Tab(text: tab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // First tab → Custom Text widget + Button
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // centers content vertically
              children: [
                Text(
                  'Spinning Cat',
                  style: TextStyle(
                    fontSize: 40, // make text bigger
                    fontWeight: FontWeight.bold, // bold text
                    color: const Color.fromARGB(
                      255,
                      255,
                      33,
                      25,
                    ), // custom color
                    letterSpacing: 2, // space between letters
                  ),
                  textAlign: TextAlign.center, // center align text
                ),
                SizedBox(height: 20), // spacing between text and button
                Image.network(
                  'https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExNXA0NHVhMXJhd213c2s0b3ljOXM2ODJqZ2w3cXIxdjdzcnQ0ZmxtOCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/ztisqLhP99tVSHG136/giphy.gif', // replace with real URL
                  width: 150,
                  height: 150,
                ),
              ],
            ),
          ),

          // Second tab → Text input + Image
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter text here',
                    ),
                  ),
                ),
                SizedBox(height: 20), // space between textfield and image
                Image.network(
                  'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExcThzM2Nva3U5Ynp0MGhzdW9hNzY5YXMyeWx6NWI4YW1idGkxeHZmOSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/wr7oA0rSjnWuiLJOY5/giphy.gif', // replace with real URL
                  width: 150,
                  height: 150,
                ),
              ],
            ),
          ),

          // Third tab → default text
          Center(
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Button pressed in ${tabs[2]} tab!')),
                );
              },
              child: Text('Click me'),
            ),
          ),

          // Fourth tab → default text
          ListView(
            children: const <Widget>[
              ListTile(leading: Icon(Icons.map), title: Text('Map')),
              ListTile(leading: Icon(Icons.photo_album), title: Text('Album')),
              ListTile(leading: Icon(Icons.phone), title: Text('Phone')),
            ],
          ),
        ],
      ),
    );
  }
}
