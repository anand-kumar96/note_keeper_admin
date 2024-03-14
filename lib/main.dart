import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:note_keeper/screen/splash_screen.dart';
import 'package:note_keeper/sync/sqlite_to_mongodb.dart';

void main() {
  runApp( const MyApp());
  startTimer();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note book',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// Sync data to mongodb and sqlite in each 2 minutes
void startTimer() {
  Timer.periodic(const Duration(minutes: 2), (timer) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      // Internet connection is available
      postNotesToMongoDbFromSqlite();
    }
  });
}