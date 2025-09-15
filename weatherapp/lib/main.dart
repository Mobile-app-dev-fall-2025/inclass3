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

  //weather variables tab 1
  final TextEditingController _cityController = TextEditingController();
  String _cityName = "______";
  String _temperature = "______";
  String _condition = "______";

  //7 day forecast storage tab 2
  final TextEditingController _forecastCityController = TextEditingController();
  List<Map<String, String>> _forecast = [];

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
    _forecastCityController.dispose();
    super.dispose();
  }

  //current weather 
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

  //7 day weather
  void _simulateForecast(String city) {
    final random = Random();
    final List<String> conditions = ["Sunny", "Cloudy", "Rainy"];

    List<Map<String, String>> forecast = [];
    for (int i = 1; i <= 7; i++) {
      int temp = 75;
      String cond = conditions[random.nextInt(conditions.length)];
      forecast.add({
        "day": "Day $i",
        "temp": "$temp°F",
        "cond": cond,
      });
    }

    setState(() {
      _forecast = forecast;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Weather', '7-Day Forecast', 'Tab 3', 'Tab 4'];

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
          //tab 1: display current 
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter city name",
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
                Text("Temperature: $_temperature",
                    style: const TextStyle(fontSize: 18)),
                Text("Condition: $_condition",
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),

          //tab 2: 7 day forecast
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _forecastCityController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter city name",
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_forecastCityController.text.isNotEmpty) {
                      _simulateForecast(_forecastCityController.text);
                    }
                  },
                  child: const Text("Fetch 7-Day Forecast"),
                ),
                const SizedBox(height: 20),
                if (_forecast.isNotEmpty) ...[
                  Text("7-Day Forecast for ${_forecastCityController.text}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _forecast.length,
                      itemBuilder: (context, index) {
                        final dayForecast = _forecast[index];
                        return Card(
                          child: ListTile(
                            title: Text(dayForecast["day"]!),
                            subtitle: Text(
                                "${dayForecast["temp"]} and ${dayForecast["cond"]}"),
                          ),
                        );
                      },
                    ),
                  ),
                ]
              ],
            ),
          ),

          //tab 3 and 4 blank
          Center(
            child: Text("Tab 3",),
          ),
          Center(
            child: Text("Tab 4",),
          ),
        ],
      ),
    );
  }
}
