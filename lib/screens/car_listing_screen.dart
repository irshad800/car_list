import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/car_provider.dart';
import 'filters_screen.dart';

// 1. Convert to a StatefulWidget
class CarListingScreen extends StatefulWidget {
  @override
  State<CarListingScreen> createState() => _CarListingScreenState();
}

class _CarListingScreenState extends State<CarListingScreen> {
  // 2. Declare a variable to hold the Future
  late Future<void> _carsFuture;

  @override
  void initState() {
    super.initState();
    // 3. Initialize the Future ONLY ONCE in initState
    // We use Provider.of<CarProvider>(context, listen: false) here because we
    // are inside initState, and we only need the instance, not to listen for changes.
    final carProvider = Provider.of<CarProvider>(context, listen: false);
    _carsFuture = carProvider.loadCars();
  }

  @override
  Widget build(BuildContext context) {
    // We use Provider.of here to listen to changes (like filtering)
    final carProvider = Provider.of<CarProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Listings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FiltersScreen()),
              );
            },
          ),
        ],
      ),
      // 4. Pass the stored, one-time Future to the FutureBuilder
      body: FutureBuilder(
        future: _carsFuture, // <-- Using the stored Future here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Check for error state from the Future (optional but good practice)
          if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          }

          // Now the provider state holds the filtered cars after loading
          if (carProvider.filteredCars.isEmpty) {
            return const Center(
                child: Text('No vehicles found matching the criteria.'));
          }

          return ListView.builder(
            itemCount: carProvider.filteredCars.length,
            itemBuilder: (context, index) {
              final car = carProvider.filteredCars[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: car.image.isNotEmpty
                        ? Image.asset(car.image, width: 100, fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported,
                                size: 100, color: Colors.grey);
                          })
                        : const Icon(Icons.image_not_supported,
                            size: 100, color: Colors.grey),
                  ),
                  title: Text(
                    car.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Model: ${car.modelCode} | Color: ${car.color}'),
                        Text(
                            'Distance: ${car.distanceCovered} km | Engine: ${car.engineCapacity} cc'),
                        const SizedBox(height: 4),
                        Text(
                          'Price: \$${car.price}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  trailing: car.hasCashback
                      ? const Chip(
                          label: Text('Cashback',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10)),
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
