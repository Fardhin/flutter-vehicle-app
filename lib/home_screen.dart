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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
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
          ),
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
                  margin: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 10),
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
                      "Mileage: ${vehicle['mileage']} km/l\nYear: ${vehicle['year']}",
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

          /// 🔲 Fixed Legend Bar for Color Meaning
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10, // Space between boxes horizontally
              runSpacing: 5, // Space between rows when wrapping
              children: [
                _buildColorLegend(Colors.green, "Efficient (15km/l+, <5 yrs)"),
                _buildColorLegend(Colors.amber, "Moderate (15km/l+, >5 yrs)"),
                _buildColorLegend(Colors.red, "Inefficient (<15km/l, any age)"),
              ],
            ),
          ),
        ],
      ),

      /// 🔼 Adjusted FAB Position (Moved Slightly Up)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40), // Moves FAB slightly up
        child: FloatingActionButton(
          onPressed: () => openAddVehicleDialog(context),
          tooltip: 'Add Vehicle',
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  /// 🟩🟨🟥 Helper Widget for Color Legend
  Widget _buildColorLegend(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Keeps items compact
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 1),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
