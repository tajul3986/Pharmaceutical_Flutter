import 'package:flutter/material.dart';
import 'package:pharma_app/auth/login_page.dart';
import 'package:pharma_app/admin/admin_home.dart';
import 'package:pharma_app/admin/user_home.dart';
import 'package:pharma_app/provider/DashboardProvider.dart';
import 'package:pharma_app/provider/MedicineProvider.dart';
import 'package:pharma_app/provider/SalesReport.dart';
import 'package:pharma_app/service/SalesReport.dart';
import 'package:pharma_app/ui/MainLayout.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MedicineProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(
          create: (_) => SalesReportProvider(SalesReportService()),
        ),
        
        // Add more providers here if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: SplashScreen(),
      // routes: {
      //   '/login': (context) => LoginPage(),
      //   '/admin_home': (context) => AdminHomePage(),
      //   '/user_home': (context) => UserHomePage(),
      // },
      home: MainLayout(),
     
      routes: {
        '/login': (context) => LoginPage(),
        '/admin_home': (context) => AdminHomePage(),
        '/user_home': (context) => UserHomePage(),
      },
    );
  }
}

