import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/car.dart';

class CarProvider with ChangeNotifier {
  List<Car> _allCars = [];
  List<Car> _filteredCars = [];
  String? selectedMake;
  String? selectedCondition;
  String? selectedBodyType;
  RangeValues priceRange = const RangeValues(0, 100000);

  List<Car> get filteredCars => _filteredCars;

  Future<void> loadCars() async {
    print('Loading cars...');
    try {
      final String response = await rootBundle.loadString('assets/data.json');
      print('JSON loaded: $response');
      final List<dynamic> data = json.decode(response) as List<dynamic>;
      _allCars = data
          .map((json) => Car.fromJson(json as Map<String, dynamic>))
          .toList();
      _filteredCars = List.from(_allCars);
      print('Cars loaded: ${_allCars.length} items');
    } catch (e) {
      print('Error loading cars: $e');
      _allCars = [];
      _filteredCars = [];
    }
    notifyListeners();
  }

  void applyFilters() {
    _filteredCars = _allCars.where((car) {
      bool matchesMake = selectedMake == null || car.make == selectedMake;
      bool matchesCondition =
          selectedCondition == null || car.condition == selectedCondition;
      bool matchesBodyType = selectedBodyType == null ||
          car.bodyType == selectedBodyType; // Fixed 'type' to 'bodyType'
      bool matchesPrice =
          car.price >= priceRange.start && car.price <= priceRange.end;
      return matchesMake && matchesCondition && matchesBodyType && matchesPrice;
    }).toList();
    notifyListeners();
  }

  void clearFilters() {
    selectedMake = null;
    selectedCondition = null;
    selectedBodyType = null;
    priceRange = const RangeValues(0, 100000);
    _filteredCars = List.from(_allCars);
    notifyListeners();
  }
}
