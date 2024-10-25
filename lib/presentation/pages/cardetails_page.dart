// // import 'package:flutter/material.dart';

// // class CarDetailsPage extends StatelessWidget {
// //   final Map<String, String> car; // Car details will be passed in this map

// //   CarDetailsPage({super.key, required this.car});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(car['name'] ?? 'Car Details'),
// //         backgroundColor: Color.fromARGB(255, 102, 114, 193),
// //       ),
// //       body: Stack(
// //         children: [
// //           // Background color to match the splash screen
// //           Container(
// //             color: Color.fromARGB(255, 102, 114, 193).withOpacity(0.8), // Slightly darker for contrast
// //           ),
// //           // Dark overlay to improve text visibility
// //           Container(
// //             color: Colors.black.withOpacity(0.4),
// //             child: Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: SingleChildScrollView(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     // Car Image with Hero Animation
// //                     Hero(
// //                       tag: car['image']!,
// //                       child: ClipRRect(
// //                         borderRadius: BorderRadius.circular(15),
// //                         child: Image.asset(
// //                           car['image'] ?? 'assets/images/default_car.jpg', // Fallback image
// //                           fit: BoxFit.cover,
// //                           height: 300, // Increased height for a more dramatic effect
// //                           width: double.infinity,
// //                         ),
// //                       ),
// //                     ),
// //                     SizedBox(height: 16.0),

// //                     // Car Information
// //                     Text(
// //                       car['name'] ?? 'Car Name',
// //                       style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
// //                     ),
// //                     SizedBox(height: 8.0),
// //                     Text(
// //                       'Location: ${car['location'] ?? 'Unknown'}',
// //                       style: TextStyle(fontSize: 20, color: Colors.white70),
// //                     ),
// //                     SizedBox(height: 8.0),
// //                     Text(
// //                       'Rating: ${car['rating'] ?? 'N/A'}',
// //                       style: TextStyle(fontSize: 20, color: Colors.amberAccent),
// //                     ),
// //                     SizedBox(height: 16.0),

// //                     // Description
// //                     Text(
// //                       'Description:',
// //                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
// //                     ),
// //                     SizedBox(height: 8.0),
// //                     Text(
// //                       'This is a beautiful ${car['name'] ?? 'car'} that provides comfort and style. Perfect for all your driving needs, whether it’s a weekend getaway or a business trip.',
// //                       style: TextStyle(fontSize: 18, color: Colors.white70),
// //                     ),
// //                     SizedBox(height: 24.0),

// //                     // Booking Button
// //                     Center(
// //                       child: ElevatedButton(
// //                         onPressed: () {
// //                           // Navigate to booking logic or page
// //                         },
// //                         child: Text('Book Now'),
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: Color.fromARGB(255, 102, 114, 193),
// //                           padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
// //                           textStyle: TextStyle(fontSize: 20),
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(10),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }







// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// class CarDetailsPage extends StatelessWidget {
//   final Map<String, String> car; // Car details will be passed in this map

//   CarDetailsPage({super.key, required this.car});

//   @override
//   Widget build(BuildContext context) {
//     double latitude = double.tryParse(car['latitude'] ?? '0') ?? 0.0;
//     double longitude = double.tryParse(car['longitude'] ?? '0') ?? 0.0;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(car['name'] ?? 'Car Details'),
//         backgroundColor: Color.fromARGB(255, 102, 114, 193),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             color: Color.fromARGB(255, 102, 114, 193).withOpacity(0.8),
//           ),
//           Container(
//             color: Colors.black.withOpacity(0.4),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Hero(
//                       tag: car['image']!,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Image.asset(
//                           car['image'] ?? 'assets/images/default_car.jpg',
//                           fit: BoxFit.cover,
//                           height: 300,
//                           width: double.infinity,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16.0),

//                     Text(
//                       car['name'] ?? 'Car Name',
//                       style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                     SizedBox(height: 8.0),
//                     GestureDetector(
//                       onTap: () => _openMap(latitude, longitude),
//                       child: Text(
//                         'Location: ${car['location'] ?? 'Unknown'}',
//                         style: TextStyle(fontSize: 20, color: Colors.white70, decoration: TextDecoration.underline),
//                       ),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'Rating: ${car['rating'] ?? 'N/A'}',
//                       style: TextStyle(fontSize: 20, color: Colors.amberAccent),
//                     ),
//                     SizedBox(height: 16.0),

//                     SizedBox(
//                       height: 200,
//                       child: GoogleMap(
//                         initialCameraPosition: CameraPosition(
//                           target: LatLng(latitude, longitude),
//                           zoom: 14,
//                         ),
//                         markers: {
//                           Marker(
//                             markerId: MarkerId(car['name'] ?? 'Car'),
//                             position: LatLng(latitude, longitude),
//                           ),
//                         },
//                       ),
//                     ),

//                     SizedBox(height: 16.0),
//                     Text(
//                       'Description:',
//                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'This is a beautiful ${car['name'] ?? 'car'} that provides comfort and style. Perfect for all your driving needs, whether it’s a weekend getaway or a business trip.',
//                       style: TextStyle(fontSize: 18, color: Colors.white70),
//                     ),
//                     SizedBox(height: 24.0),

//                     Center(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Navigate to booking logic or page
//                         },
//                         child: Text('Book Now'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color.fromARGB(255, 102, 114, 193),
//                           padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//                           textStyle: TextStyle(fontSize: 20),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _openMap(double latitude, double longitude) async {
//     final Uri launchUri = Uri(
//       scheme: 'https',
//       host: 'www.google.com',
//       path: 'maps/@$latitude,$longitude,15z',
//     );

//     // Use launchUrl instead of launch
//     if (await canLaunchUrl(launchUri)) {
//       await launchUrl(launchUri);
//     } else {
//       throw 'Could not launch $launchUri';
//     }
//   }
// }












import 'package:car_rental_app/presentation/pages/booknow_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CarDetailsPage extends StatelessWidget {
  final Map<String, String> car; // Car details will be passed in this map

  CarDetailsPage({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    // Fallback coordinates for New York if no coordinates are provided
    double latitude = double.tryParse(car['latitude'] ?? '40.7128') ?? 40.7128;
    double longitude = double.tryParse(car['longitude'] ?? '-74.0060') ?? -74.0060;

    return Scaffold(
      
      appBar: AppBar(
        title: Text(car['name'] ?? 'Car Details'),
        backgroundColor: Color.fromARGB(255, 102, 114, 193),
      ),
      body: Stack(
        children: [
          // Background color for the screen
          Container(
            color: Color.fromARGB(255, 102, 114, 193).withOpacity(0.8),
          ),
          // Dark overlay to improve text visibility
          Container(
            color: Colors.black.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Car Image with Hero Animation
                    Hero(
                      tag: car['image']!,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          car['image'] ?? 'assets/images/default_car.jpg',
                          fit: BoxFit.cover,
                          height: 300,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Car Information
                    Text(
                      car['name'] ?? 'Car Name',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 8.0),
                    
                    // Tapable Location Text
                    GestureDetector(
                      onTap: () => _openMap(latitude, longitude),
                      child: Text(
                        'Location: ${car['location'] ?? 'New York, NY'}',
                        style: TextStyle(fontSize: 20, color: Colors.white70, decoration: TextDecoration.underline),
                      ),
                    ),
                    SizedBox(height: 8.0),

                    // Car Rating
                    Text(
                      'Rating: ${car['rating'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 20, color: Colors.amberAccent),
                    ),
                    SizedBox(height: 16.0),

                    // Google Map to Display the Car Location
                    SizedBox(
                      height: 200,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latitude, longitude),
                          zoom: 14,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId(car['name'] ?? 'Car'),
                            position: LatLng(latitude, longitude),
                          ),
                        },
                      ),
                    ),

                    SizedBox(height: 16.0),

                    // Car Description
                    Text(
                      'Description:',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'This is a beautiful ${car['name'] ?? 'car'} that provides comfort and style. Perfect for all your driving needs, whether it’s a weekend getaway or a business trip.',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    SizedBox(height: 24.0),

                    // Booking Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder:(context) => BookNowPage(car:car  ), ));
                          
                          // Navigate to booking logic or page
                        },
                        child: Text('Book Now'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 102, 114, 193),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                          textStyle: TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to open Google Maps with given latitude and longitude
  Future<void> _openMap(double latitude, double longitude) async {
    final Uri launchUri = Uri(
      scheme: 'https',
      host: 'www.google.com',
      path: 'maps/@$latitude,$longitude,15z',
    );

    // Use launchUrl instead of launch
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }
}
