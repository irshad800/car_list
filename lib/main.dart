import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/car_provider.dart';
import 'screens/car_listing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CarProvider(),
      child: MaterialApp(
        title: 'Car Listing App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: CarListingScreen(),
      ),
    );
  }
}
