# Vehicle List App

## Overview
The **Vehicle List App** is a Flutter application that displays a list of vehicles with color-coded categorization based on their fuel efficiency and age. The app integrates with Firebase Firestore as the backend database.

## Features
- Display a list of vehicles fetched from Firebase Firestore.
- Search functionality to filter vehicles by name.
- Add new vehicles with **name, mileage, and manufacturing year**.
- Delete vehicles from the list.
- Color-coded categories:
    - **Green**: Mileage >= 15 km/l and vehicle age ≤ 5 years (Fuel Efficient, Low Pollutant).
    - **Amber**: Mileage >= 15 km/l but vehicle age > 5 years (Fuel Efficient, Moderately Pollutant).
    - **Red**: Mileage < 15 km/l (Not Fuel Efficient, High Pollutant).
- Dark mode support.

## Tech Stack
- **Flutter** (Dart)
- **Firebase Firestore** (Database)
- **Provider** (State Management)

## Installation & Setup
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/vehicle-list-app.git
   cd vehicle-list-app
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Configure Firebase:
    - Create a Firebase project.
    - Add the `google-services.json` file in `android/app/`.
    - Enable Firestore in Firebase console.
4. Run the application:
   ```sh
   flutter run
   ```

## Firebase Setup
1. Go to [Firebase Console](https://console.firebase.google.com/).
2. Create a new project and register your Flutter app.
3. Enable Firestore database and set **rules to allow read & write**.
4. Structure your Firestore collection:
   ```
   vehicles (Collection)
     - document1
       - name: "Toyota Corolla"
       - mileage: 16
       - year: 2019
     - document2
       - name: "Honda Civic"
       - mileage: 14
       - year: 2015
   ```

## API Details
- **Database Used:** Firebase Firestore
- **CRUD Operations:**
    - Fetch all vehicles: `FirebaseFirestore.instance.collection('vehicles').get()`
    - Add a vehicle: `FirebaseFirestore.instance.collection('vehicles').add({...})`
    - Delete a vehicle: `FirebaseFirestore.instance.collection('vehicles').doc(id).delete()`

## Screenshots
| Home Screen | Add Vehicle | Search & Delete |
|------------|------------|----------------|
| ![Home](assets/screens/home.png) | ![Add Vehicle](assets/screens/add_vehicle.png) | ![Search](assets/screens/search_delete.png) |

## Contribution
Feel free to fork the repository and submit pull requests.

## License
This project is licensed under the MIT License.
