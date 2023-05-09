import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  int sensorOneValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamData();
    resetDB();
  }

  void streamData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("sensorOne");
    Stream<DatabaseEvent> stream = ref.onValue;

    stream.listen((DatabaseEvent event) {
      print('Snapshot: ${event.snapshot.value}');
      setState(() {
        sensorOneValue = event.snapshot.value as int;
      });
    });
  }

  void resetDB() async {
    Timer mytimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      await ref.update({"sensorOne": 0});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Noise Detection System'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.notifications),
          )
        ],
      ),
      drawer: const Drawer(),
      body: Padding(
        padding: EdgeInsets.only(
            top: size.height / 15,
            left: size.height / 30,
            right: size.height / 30),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              SensorContainer(
                size: size,
                sensorNumber: '1',
                color: sensorOneValue == 1 ? Colors.red : Colors.grey.shade300,
              ),
              SensorContainer(
                  size: size, sensorNumber: '2', color: Colors.grey.shade300),
            ]),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              SensorContainer(
                size: size,
                sensorNumber: '3',
                color: Colors.grey.shade300,
              ),
              SensorContainer(
                size: size,
                sensorNumber: '4',
                color: Colors.grey.shade300,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class SensorContainer extends StatelessWidget {
  SensorContainer(
      {super.key,
      required this.size,
      required this.sensorNumber,
      required this.color});

  final Size size;
  final String sensorNumber;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 3,
      height: size.height / 7,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400, width: 2),
      ),
      child: Center(
          child: Text(
        sensorNumber,
        style: const TextStyle(fontSize: 38),
      )),
    );
  }
}
