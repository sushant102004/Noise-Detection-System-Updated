import 'package:flutter/material.dart';
import 'package:noisedetection/sensorDetails.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: size.height / 3),
            Text(
              'Noise Detection System',
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height / 2),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Stats()),
                  );
                },
                child: const Text('Detect Noise'))
          ],
        ),
      ),
    );
  }
}
