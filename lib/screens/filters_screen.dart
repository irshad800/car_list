import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/car_provider.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: const Text('Select Make'),
              value: carProvider.selectedMake,
              items: ['Toyota', 'Honda']
                  .map((make) =>
                      DropdownMenuItem(value: make, child: Text(make)))
                  .toList(),
              onChanged: (value) {
                setState(() => carProvider.selectedMake = value);
              },
            ),
            CheckboxListTile(
              title: const Text('New'),
              value: carProvider.selectedCondition == 'New',
              onChanged: (bool? value) {
                setState(() =>
                    carProvider.selectedCondition = value! ? 'New' : null);
              },
            ),
            CheckboxListTile(
              title: const Text('Used'),
              value: carProvider.selectedCondition == 'Used',
              onChanged: (bool? value) {
                setState(() =>
                    carProvider.selectedCondition = value! ? 'Used' : null);
              },
            ),
            const Text('Body Type'),
            RadioListTile<String>(
              title: const Text('Sedan'),
              value: 'Sedan',
              groupValue: carProvider.selectedBodyType,
              onChanged: (value) {
                setState(() => carProvider.selectedBodyType = value);
              },
            ),
            RadioListTile<String>(
              title: const Text('SUV'),
              value: 'SUV',
              groupValue: carProvider.selectedBodyType,
              onChanged: (value) {
                setState(() => carProvider.selectedBodyType = value);
              },
            ),
            RangeSlider(
              values: carProvider.priceRange,
              min: 0,
              max: 100000,
              divisions: 100,
              labels: RangeLabels(
                '\$${carProvider.priceRange.start.round()}',
                '\$${carProvider.priceRange.end.round()}',
              ),
              onChanged: (RangeValues values) {
                setState(() => carProvider.priceRange = values);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    carProvider.clearFilters();
                    Navigator.pop(context);
                  },
                  child: const Text('Clear All'),
                ),
                ElevatedButton(
                  onPressed: () {
                    carProvider.applyFilters();
                    Navigator.pop(context);
                  },
                  child: const Text('View Vehicles'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
