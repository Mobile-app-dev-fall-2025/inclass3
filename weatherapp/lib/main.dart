import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}


class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() =>
  __TabsNonScrollableDemoState();
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
  void initState() {
    super.initState();
    _tabController = TabController(
    initialIndex: 0,
    length: 4,
    vsync: this,
  );

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
    final tabs = [
      {'title': 'Tab 1', 'color': const Color.fromARGB(255, 253, 126, 117)},
      {'title': 'Tab 2', 'color': const Color.fromARGB(255, 189, 252, 137)},
      {'title': 'Tab 3', 'color': const Color.fromARGB(255, 87, 173, 243)},
      {'title': 'Tab 4', 'color': const Color.fromARGB(255, 250, 155, 65)},
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tabs Demo',),
        bottom: TabBar(
        controller: _tabController,
        isScrollable: false,
        tabs: [for (final tab in tabs) Tab(text: tab['title'] as String),],
      ),
    ),

    bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "Bottom App Bar",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
    ),

    body: TabBarView(
      controller: _tabController,

      children: [
        //tab 1
        Container(
            color: tabs[0]['color'] as Color,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("⋆˚✿˖°Hello⋆˚✿˖°"),
                      content: Text("This is an Alert"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("OK"),
                        )
                      ],
                    ),
                  );
                },
                child: Text("Show Alert Dialog"),
              ),
            ),
          ),

          //tab2
          Container(
            color: tabs[1]['color'] as Color,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: "Enter some text",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Image.network(
                  'https://images.unsplash.com/photo-1522926193341-e9ffd686c60f?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  width: 150,
                  height: 150,
                ),
              ],
            ),
          ),

          //tab 3
          Container(
            color: tabs[2]['color'] as Color,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Button pressed in ${tabs[2]['title']}!"),
                    ),
                  );
                },
                child: Text("Click Me"),
              ),
            ),
          ),

          //tab 4
          Container(
            color: tabs[3]['color'] as Color,
            child: ListView(
              padding: EdgeInsets.all(12),
              children: [
                Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text("Item 1"),
                    subtitle: Text("Details about Item 1"),
                  ),
                ),
                Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text("Item 2"),
                    subtitle: Text("Details about Item 2"),
                  ),
                ),
                Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text("Item 3"),
                    subtitle: Text("Details about Item 3"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
