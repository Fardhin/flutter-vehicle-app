import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleProvider with ChangeNotifier {
  List<Map<String, dynamic>> _vehicles = [];
  bool _isLoading = true;
  bool _isDarkMode = false;
  String _searchQuery = "";

  // Getters
  List<Map<String, dynamic>> get vehicles => _filteredVehicles;
  List<Map<String, dynamic>> get filteredVehicles => _filteredVehicles;
  bool get isLoading => _isLoading;
  bool get isDarkMode => _isDarkMode;

  List<Map<String, dynamic>> get _filteredVehicles {
    if (_searchQuery.isEmpty) {
      return _vehicles;
    }
    return _vehicles.where((vehicle) {
      return vehicle['name'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  // Fetch vehicles from Firestore
  Future<void> fetchVehicles() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('vehicles').get();

      _vehicles = snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error fetching vehicles: $e");
    }
  }

  // Add a new vehicle
  Future<void> addVehicle(String name, int mileage, int year) async {
    try {
      DocumentReference docRef = await FirebaseFirestore.instance.collection('vehicles').add({
        'name': name,
        'mileage': mileage,
        'year': year,
        'createdAt': Timestamp.now(),
      });

      _vehicles.add({
        'id': docRef.id,
        'name': name,
        'mileage': mileage,
        'year': year,
        'createdAt': Timestamp.now(),
      });

      notifyListeners(); // Update UI after adding
    } catch (e) {
      print("Error adding vehicle: $e");
    }
  }

  // Delete a vehicle
  Future<void> deleteVehicle(String id) async {
    try {
      await FirebaseFirestore.instance.collection('vehicles').doc(id).delete();
      _vehicles.removeWhere((vehicle) => vehicle['id'] == id);
      notifyListeners();
    } catch (e) {
      print("Error deleting vehicle: $e");
    }
  }

  // Toggle dark mode
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Update search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Assign colors based on mileage and vehicle age
  Color getVehicleColor(Map<String, dynamic> vehicle) {
    int mileage = vehicle['mileage'];
    num vehicleAge = DateTime.now().year - vehicle['year'];

    if (mileage >= 15 && vehicleAge <= 5) {
      return Colors.green;
    } else if (mileage >= 15 && vehicleAge > 5) {
      return Colors.amber;
    } else {
      return Colors.red;
    }
  }
}
