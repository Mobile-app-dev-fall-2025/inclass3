import "package:flutter/material.dart";
import "dart:math";

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
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  // Weather state variables
  final TextEditingController _cityController = TextEditingController();
  String _cityName = "_____";
  String _temperature = "_____";
  String _condition = "_____";

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
    _cityController.dispose();
    super.dispose();
  }

  // Simulate weather data
  void _simulateWeather(String city) {
    final random = Random();
    final int temperature = 70;
    final List<String> conditions = ["Sunny", "Cloudy", "Rainy"];
    final String condition = conditions[random.nextInt(conditions.length)];

    setState(() {
      _cityName = city;
      _temperature = "$temperature°F";
      _condition = condition;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Weather', 'Tab 2', 'Tab 3', 'Tab 4'];
    //idk what im supposed to put on diff tabs

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tabs Demo'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter city name:",
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_cityController.text.isNotEmpty) {
                      _simulateWeather(_cityController.text);
                    }
                  },
                  child: const Text("Fetch Weather"),
                ),
                const SizedBox(height: 20),
                Text("City: $_cityName", style: const TextStyle(fontSize: 18)),
                Text("Temperature: $_temperature", style: const TextStyle(fontSize: 18)),
                Text("Condition: $_condition", style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),

          for (int i = 2; i <= 4; i++)
            Center(
              child: Text("Content for Tab $i",
                  style: const TextStyle(fontSize: 20)),
            ),
        ],
      ),
    );
  }
}
