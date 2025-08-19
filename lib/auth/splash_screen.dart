// import 'package:flutter/material.dart';
// import 'package:pharma_app/dashboard/admin_home.dart';
// import 'package:pharma_app/dashboard/user_home.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'login_page.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//   }

//   Future<void> _checkLoginStatus() async {
//     await Future.delayed(Duration(seconds: 2)); // simulate loading
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final role = prefs.getString('role');

//     if (role != null) {
//       if (role == 'admin') {
//         Navigator.pushReplacement(
//           // ignore: use_build_context_synchronously
//           context,
//           MaterialPageRoute(builder: (context) => AdminHomePage()),
//         );
//       } else {
//         Navigator.pushReplacement(
//           // ignore: use_build_context_synchronously
//           context,
//           MaterialPageRoute(builder: (context) => UserHomePage()),
//         );
//       }
//     } else {
//       Navigator.pushReplacement(
//         // ignore: use_build_context_synchronously
//         context,
//         MaterialPageRoute(builder: (context) => LoginPage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[50],
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.medical_services, size: 80, color: Colors.blue),
//             SizedBox(height: 20),
//             Text("Pharma App", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             CircularProgressIndicator()
//           ],
//         ),
//       ),
//     );
//   }
// }
