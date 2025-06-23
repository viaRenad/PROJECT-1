import 'dart:math';

import "package:adhan_dart/adhan_dart.dart";
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

class QiblaCompass extends StatefulWidget {
  const QiblaCompass({super.key});

  @override
  State<QiblaCompass> createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<QiblaCompass> {
  Future<Position>? getPostioned;
  bool _hasCompass = false;

  @override
  void initState() {
    super.initState();
    getPostioned = _determinePosition();
    _checkCompass();
  }

  Future<void> _checkCompass() async {
    try {
      final hasCompass = await FlutterCompass.events?.first != null;
      setState(() {
        _hasCompass = hasCompass;
      });
    } catch (e) {
      print('Error checking compass: $e');
      setState(() {
        _hasCompass = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPostioned,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error.toString()}',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        getPostioned = _determinePosition();
                      });
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Getting location..."),
                ],
              ),
            );
          }

          if (!_hasCompass) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.compass_calibration,
                    size: 48,
                    color: Colors.orange,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Compass sensor not available',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please make sure your device has a compass sensor',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          Position positionResult = snapshot.data!;
          Coordinates coordinates = Coordinates(
            positionResult.latitude,
            positionResult.longitude,
          );
          double qiblaDirection = Qibla.qibla(coordinates);

          return StreamBuilder(
            stream: FlutterCompass.events,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 48, color: Colors.red),
                      SizedBox(height: 16),
                      Text(
                        'Compass Error: ${snapshot.error.toString()}',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text("Waiting for compass..."),
                    ],
                  ),
                );
              }

              double? direction = snapshot.data?.heading;

              if (direction == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.compass_calibration,
                        size: 48,
                        color: Colors.orange,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Compass heading not available',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please make sure your device has a compass sensor',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              // Normalize the direction to be between 0 and 360
              direction = (direction + 360) % 360;

              // Calculate the angle between current direction and qibla
              double angle = direction - qiblaDirection;
              if (angle < 0) angle += 360;
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Implement the image here
                  Image.asset(
                    "images/compass-bg.png",
                    width: 800,
                    color: const Color.fromARGB(5, 0, 0, 0),
                    colorBlendMode: BlendMode.darken,
                    fit: BoxFit.cover,
                  ),
                  Positioned(top: 200, child: Image.asset("images/kabah.png")),
                  Positioned(
                    top: 60,
                    child: SizedBox(
                      width: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xFF7E5A3B),
                            ),
                          ),
                          Text(
                            "إتجاه القبلة",
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF7E5A3B),
                            ),
                          ),
                          Text(""),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 180,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: pi / 2 + 0.55,
                          child: Image.asset(
                            "images/half-circle-reveal.png",

                            width: 175,
                          ),
                        ),
                        // Rotating compass needle
                        Transform.rotate(
                          angle: (-1 * direction * (pi / 180)),
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  top: 20,
                                  right: 40,
                                  child: Image.asset(
                                    "images/compass-circle.png",
                                  ),
                                ),
                                Transform.rotate(
                                  angle: 3.14,
                                  child: Image.asset("images/anchor.png"),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Qibla indicator
                        Padding(
                          padding: const EdgeInsets.only(top: 270.0),
                          child: Text(
                            getHeading(direction, qiblaDirection),
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF7E5A3B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool isServiceEnabled;
  LocationPermission permission;

  isServiceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!isServiceEnabled) {
    return Future.error("Location Services are disabled");
  }

  permission = await Geolocator.checkPermission();

  if (permission != LocationPermission.denied) {
    return await Geolocator.getCurrentPosition();
  }

  permission = await Geolocator.requestPermission();

  if (permission == LocationPermission.denied) {
    return Future.error("Location is denied");
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error("Location is denied forever");
  }

  return await Geolocator.getCurrentPosition();
}

String getHeading(double direction, double qiblaDirection) {
  int distance = direction.toInt() - qiblaDirection.toInt();
  if (distance < 0) distance = distance + 360;
  if (distance == 0) {
    return "أنت تواجه القبلة";
  }
  if (distance < 180) {
    return "تحرك $distance° إلى اليسار";
  }
  return "تحرك ${(distance - 360).abs()}° إلى اليمين";
}
