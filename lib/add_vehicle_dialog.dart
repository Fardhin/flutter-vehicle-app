import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'vehicle_provider.dart';

Future<void> openAddVehicleDialog(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Add Vehicle"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Vehicle Name"),
            ),
            TextField(
              controller: mileageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Mileage (km/l)"),
            ),
            TextField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Year"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final provider = Provider.of<VehicleProvider>(context, listen: false);
            provider.addVehicle(
              nameController.text,
              int.parse(mileageController.text),
              int.parse(yearController.text),
            );
            Navigator.pop(context);
          },
          child: const Text("Add"),
        ),
      ],
    ),
  );
}
