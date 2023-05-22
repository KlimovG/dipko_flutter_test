import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dipko flutter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const MyHomePage(title: "Klimapunkte"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  int _points = 280;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPoints() {
    setState(() {
      _points += 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        elevation: 0,
        selectedFontSize: 12,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.confirmation_num),
              icon: Icon(Icons.confirmation_num_outlined), label: 'Prämien'),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.energy_savings_leaf),
              icon: Icon(Icons.energy_savings_leaf_outlined),
              label: 'Aktionen'),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.account_circle),
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.black38,
        onTap: _onItemTapped,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 14, top: 90, right: 14),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Klimapunkte',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: _onPoints,
                      icon: const Icon(Icons.energy_savings_leaf),
                      label: Text('${_points ?? 0}'),
                    ),
                  )
                ],
              ),
              HeroCard(points: _points,),
              const ActionList(),
              const SizedBox(height: 16),
              const Text("Gemeinsam stark",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)
              ),
              const SizedBox(height: 8),
              const CollectCards()
            ],
          ),
        ),
      ),
    );
  }
}

class CollectCards extends StatelessWidget {
  const CollectCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index){
          return Card(
            margin: const EdgeInsets.only(right: 16),
            child: SizedBox(
              height: 200,
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/carsharing_image.png", width: 250, ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Carsharing',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text('Carsharing offers convenient, cost-effective transportation without car ownership.'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ActionList extends StatelessWidget {
  const ActionList({
    super.key,
  });
  static final List<ActionData> actions = [
    ActionData(
        name: "Zu Fuß",
        distance: "200 m",
        icon: Icons.directions_run,
        color: Colors.green,
        progress: 0.8),
    ActionData(
        name: "Fahrrad",
        distance: "8 km",
        icon: Icons.directions_bike,
        color: Colors.blue,
        progress: 0.65),
    ActionData(
        name: "ÖPNV",
        distance: "2.5 km",
        icon: Icons.directions_bus,
        color: Colors.orange,
        progress: 0.31),
    ActionData(
        name: "E-Auto",
        distance: "2 km",
        icon: Icons.directions_car,
        color: Colors.purple,
        progress: 0.85)
  ];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Card(
        child: SizedBox(
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return ActionTile(index: index, action: actions[index]);
              }),
        ),
      ),
    );
  }
}

class ActionData {
  String name;
  String distance;
  IconData icon;
  MaterialColor? color;
  double progress;

  ActionData(
      {required this.name,
      required this.distance,
      required this.icon,
      required this.color,
      required this.progress});
}

class ActionTile extends StatelessWidget {
  const ActionTile({super.key, required this.index, required this.action});

  final int index;
  final ActionData action;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
          child: SizedBox(
            width: 200,
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Icon(action.icon,
                      textDirection: TextDirection.rtl, size: 36),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      action.distance,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      action.name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: Container(
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                                child: LinearPercentIndicator(
                                  width: 100,
                                  animation: true,
                                  lineHeight: 15.0,
                                  animationDuration: 2000,
                                  percent: action.progress,
                                  barRadius: Radius.circular(10),
                                  progressColor: action.color![400],
                                  backgroundColor: action.color![900],
                                )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if(index != 3) const VerticalDivider(
          width: 20,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          color: Colors.grey,
        )
      ],
    );
  }
}

class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    required this.points
  });

  final num points;

  @override
  Widget build(BuildContext context) {
    const items = [
      ["Eingespart Gesamt", 3586],
      ["Monat", 675],
      ["Heute", 57]
    ];
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12.0, right: 12.0, top: 12, bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 170,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 4, top: 4),
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final Color color = index == 0
                      ? const Color(0xff86C716)
                      : const Color(0xff000031);
                  final num count = items[index][1] as num ?? 0;
                  return Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items[index][0] as String,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        AnimatedFlipCounter(
                          curve: Curves.easeIn,
                          duration: Duration(seconds: 1),
                          // value: 0,
                          value: count + points,
                          thousandSeparator: ".",
                          suffix: " CO²",
                          textStyle: TextStyle(
                            color: color,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Center(
              child: SizedBox(
                width: 160,
                height: 160,
                child: ModelViewer(
                  src: 'assets/images/low_poly_trees.glb',
                  autoPlay: true,
                  autoRotate: true,
                  ar: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
