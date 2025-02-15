import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'vehicle_provider.dart';
import 'add_vehicle_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VehicleProvider>(context);
    final filteredVehicles = provider.filteredVehicles;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle List"),
        actions: [
          IconButton(
            icon: provider.isDarkMode
                ? const Icon(Icons.wb_sunny)
                : const Icon(Icons.nightlight_round),
            onPressed: () {
              provider.toggleDarkMode();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Search Vehicles",
                prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) => provider.setSearchQuery(value),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredVehicles.isEmpty
                  ? const Center(
                child: Text(
                  "No Vehicles Found",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              )
                  : ListView.builder(
                itemCount: filteredVehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = filteredVehicles[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: provider.getVehicleColor(vehicle),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      title: Text(
                        vehicle['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "Mileage: ${vehicle['mileage']} km/l",
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.black),
                        onPressed: () {
                          provider.deleteVehicle(vehicle['id']);

                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAddVehicleDialog(context),
        tooltip: 'Add Vehicle',
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
