// import 'package:flutter/material.dart';
// import 'package:pharma_app/auth/auth_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserHomePage extends StatefulWidget {
//   const UserHomePage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _UserHomePageState createState() => _UserHomePageState();
// }

// class _UserHomePageState extends State<UserHomePage> {
//   String? name;
//   String? username;

//   @override
//   void initState() {
//     super.initState();
//     loadUserInfo();
//   }

//   Future<void> loadUserInfo() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       name = prefs.getString('name');
//       username = prefs.getString('username');
//     });
//   }

//   void _logout() async {
//     final authService = AuthService();
//     await authService.logout();
//     // ignore: use_build_context_synchronously
//     Navigator.pushReplacementNamed(context, '/login');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Dashboard'),
//         actions: [IconButton(icon: Icon(Icons.logout), onPressed: _logout)],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Hello, $name!', style: TextStyle(fontSize: 22)),
//             SizedBox(height: 10),
//             Text('Username: $username', style: TextStyle(color: Colors.grey)),
//             SizedBox(height: 30),
            
//           ],
//         ),
//       ),
//     );
//   }
// }


//homepage
// import 'package:flutter/material.dart';

// class UserHomePage extends StatefulWidget {
//   const UserHomePage({super.key});

//   @override
//   State<UserHomePage> createState() => _UserHomePage();
// }

// class _UserHomePage extends State<UserHomePage> {
//   bool isDarkMode = false;
//   final PageController _bannerController = PageController(viewportFraction: 0.9);

//   // Banner images list (dummy urls for now)
//   final List<String> banners = [
//     'assets/images/banner1.png',
//     'assets/images/banner2.png',
//     'assets/images/banner3.png',
//   ];

//   @override
//   void dispose() {
//     _bannerController.dispose();
//     super.dispose();
//   }

//   void _toggleDarkMode() {
//     setState(() {
//       isDarkMode = !isDarkMode;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = isDarkMode ? ThemeData.dark() : ThemeData.light();
//     final size = MediaQuery.of(context).size;

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: theme,
//       home: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Pharma Homepage'),
//             backgroundColor: isDarkMode ? Colors.grey[900] : Colors.green[700],
//             actions: [
//               IconButton(
//                 icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
//                 onPressed: _toggleDarkMode,
//               ),
//             ],
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Banner Carousel
//                 SizedBox(
//                   height: size.height * 0.25,
//                   child: PageView.builder(
//                     controller: _bannerController,
//                     itemCount: banners.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(16),
//                           child: Image.asset(
//                             banners[index],
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Featured Section
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Text(
//                     "Featured Medicines",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: theme.textTheme.bodyLarge?.color,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),

//                 // Horizontal scrollable cards
//                 SizedBox(
//                   height: size.height * 0.2,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     itemCount: 5, // later replace with dynamic list length
//                     itemBuilder: (context, index) {
//                       return Container(
//                         width: 140,
//                         margin: const EdgeInsets.only(right: 12),
//                         decoration: BoxDecoration(
//                           color: theme.cardColor,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black12,
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: ClipRRect(
//                                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                                 child: Container(
//                                   color: Colors.grey[300],
//                                   width: double.infinity,
//                                   child: const Center(child: Text('Image')),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 'Medicine Name',
//                                 style: const TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Text(
//                                 '৳0.00',
//                                 style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // Medicines Section (Grid)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Text(
//                     "All Medicines",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: theme.textTheme.bodyLarge?.color,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),

//                 // Grid (replace with dynamic data later)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: GridView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: 6, // later replace with dynamic list length
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: size.width < 600 ? 2 : 3,
//                       crossAxisSpacing: 12,
//                       mainAxisSpacing: 12,
//                       childAspectRatio: 0.65,
//                     ),
//                     itemBuilder: (context, index) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: theme.cardColor,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black12,
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: ClipRRect(
//                                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                                 child: Container(
//                                   color: Colors.grey[300],
//                                   width: double.infinity,
//                                   child: const Center(child: Text('Image')),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 'Medicine Name',
//                                 style: const TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Text(
//                                 '৳0.00',
//                                 style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



//imtiaz vai

// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';


// class UserHomePage extends StatefulWidget {
//   const UserHomePage({super.key});

//   @override
//   State<UserHomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<UserHomePage> {
//   int _currentCarousel = 0;
//   int _currentPromo = 0;

//   final List<String> carouselImages = [
//     'assets/images/3d-yellow-great-discount-sale-260nw-2056851839.webp',
//     'assets/images/360_F_249501541_XmWdfAfUbWAvGxBwAM0ba2aYT36ntlpH.jpg',
//     // 'assets/images/HavitHeadphone.webp',
//     // 'assets/images/mini-3-pro-09Drone.webp',
//     // 'assets/images/mi-a-pro-43-01-500x500.webp',
//   ];

//   final List<Map<String, dynamic>> productOffers = [
//     {
//       'name': 'Wireless Headphones',
//       'price': '2,499',
//       'image': 'assets/images/HavitHeadphone.webp',
//       'discount': '20% OFF',
//     },
//     {
//       'name': 'Smart Watch',
//       'price': '7,999',
//       'image': 'assets/images/t3-ultra-black-01-500x500.webp',
//       'discount': '৳50% OFF',
//     },
//     {
//       'name': 'Dressers',
//       'price': '1,799',
//       'image': 'assets/images/Dressers.webp',
//       'discount': '৳10% OFF',
//     },
//     {
//       'name': 'Power Bank',
//       'price': '1,299',
//       'image': 'assets/images/j105-blue-01-500x500.webp',
//       'discount': '৳05% OFF',
//     },
//     {
//       'name': 'DJI Mini 3 Pro Drone',
//       'price': '89,900',
//       'image': 'assets/images/mini-3-pro-09Drone.webp',
//       'discount': '৳05% OFF',
//     },
//     {
//       'name': 'Rapoo C200 720p HD Webcam',
//       'price': '2,449',
//       'image': 'assets/images/RapooWebcap.webp',
//       'discount': '৳10% OFF',
//     },
//     {
//       'name': 'Canon Pixma G1010 Refillable Ink Tank Printer',
//       'price': '13,600',
//       'image': 'assets/images/CanonPrinter.jpg',
//       'discount': '৳08% OFF',
//     },
//     {
//       'name': 'Samsung Galaxy Tab A9 LTE 4GB Ram',
//       'price': '22,500',
//       'image': 'assets/images/SamsungGalaxyTAB.webp',
//       'discount': '৳15% OFF',
//     },
//     {
//       'name': 'KSTR HP930C Online UPS With Metal Body',
//       'price': '33,500',
//       'image': 'assets/images/KstarUPS.webp',
//       'discount': '৳13% OFF',
//     },
//     {
//       'name': 'Cukoo CR-303230 Cup Rice Cooker',
//       'price': '3,299',
//       'image': 'assets/images/CuckooCR.jpg',
//       'discount': '৳10% OFF',
//     },
//   ];
//   final List<Map<String, dynamic>> popularProducts = [
//     {
//       'name': 'iPhone X',
//       'price': '25,999',
//       'image': 'assets/images/appleiphonex-new-1.jpg',
//     },
//     {
//       'name': 'Lenovo Thinkpad',
//       'price': '65,999',
//       'image': 'assets/images/ideapad-slim-3-15iah8-01-500x500.webp',
//     },
//     {
//       'name': 'Mi 4k TV',
//       'price': '42,999',
//       'image': 'assets/images/mi-a-pro-43-01-500x500.webp',
//     },
//     {
//       'name': 'Gaming Console',
//       'price': '34,999',
//       'image':
//           'assets/images/nintendo-switch-oled-model-white-set-01-500x500.webp',
//     },
//     {
//       'name': 'DJI Mini 3 Pro Drone',
//       'price': '89,999',
//       'image': 'assets/images/mini-3-pro-09Drone.webp',
//     },
//     {
//       'name': 'Cisily Black Sponge Holder',
//       'price': '1,899',
//       'image': 'assets/images/CisilyBlackHolder.webp',
//     },
//     {
//       'name': 'Smart Watch',
//       'price': '7,999',
//       'image': 'assets/images/t3-ultra-black-01-500x500.webp',
//     },
//     {
//       'name': 'Candle Warner Lamp with Timer Dimmable',
//       'price': '2,499',
//       'image': 'assets/images/CandleWarnerLanp.webp',
//     },
//   ];

//   final List<Map<String, dynamic>> promotionalHighlights = [
//     {
//       'name': 'DJI Mini 3 Pro Drone',
//       'price': 89900,
//       'image': 'assets/images/mini-3-pro-09Drone.webp',
//     },
//     {
//       'name': 'Rapoo C200 720p HD Webcam',
//       'price': 2449,
//       'image': 'assets/images/RapooWebcap.webp',
//     },
//   ];

//   int getCrossAxisCount(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     if (width > 1200) return 5;
//     if (width > 800) return 3;
//     return 2;
//   }

//   Widget buildImageCarousel(BuildContext context) {
//     return Column(
//       children: [
//         AspectRatio(
//           aspectRatio: 16 / 9,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: CarouselSlider(
//               options: CarouselOptions(
//                 viewportFraction: 1.0,
//                 autoPlay: true,
//                 autoPlayInterval: const Duration(seconds: 4),
//                 autoPlayAnimationDuration: const Duration(milliseconds: 700),
//                 enableInfiniteScroll: true,
//                 onPageChanged: (idx, reason) {
//                   setState(() => _currentCarousel = idx);
//                 },
//               ),
//               items: carouselImages.map((path) {
//                 return Image.network(
//                   path,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(carouselImages.length, (i) {
//             final selected = _currentCarousel == i;
//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 250),
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               height: 8,
//               width: selected ? 18 : 8,
//               decoration: BoxDecoration(
//                 color: selected ? Colors.black87 : Colors.black26,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }

//   Widget buildProductGrid(
//     List<Map<String, dynamic>> items,
//     BuildContext context,
//   ) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       padding: const EdgeInsets.all(12),
//       itemCount: items.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: getCrossAxisCount(context),
//         mainAxisSpacing: 12,
//         crossAxisSpacing: 12,
//         childAspectRatio: MediaQuery.of(context).size.width > 800 ? 0.72 : 0.68,
//       ),
//       itemBuilder: (context, index) {
//         final product = items[index];
//         return Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 6,
//                 color: Colors.grey.shade300,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   AspectRatio(
//                     aspectRatio: 1,
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.vertical(
//                         top: Radius.circular(16),
//                       ),
//                       child: Image.network(product['image'], fit: BoxFit.cover),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           product['name'],
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           "৳${product['price']}",
//                           style: const TextStyle(
//                             color: Colors.green,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               if (product.containsKey('discount'))
//                 Positioned(
//                   top: 8,
//                   left: 8,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 6,
//                       vertical: 2,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.redAccent,
//                       borderRadius: BorderRadius.circular(6),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 4,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Text(
//                       product['discount'],
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget buildPromoBannerSlider(BuildContext context) {
//     return Column(
//       children: [
//         CarouselSlider(
//           options: CarouselOptions(
//             height: MediaQuery.of(context).size.width > 800 ? 250 : 180,
//             viewportFraction: 1.0,
//             autoPlay: true,
//             autoPlayInterval: const Duration(seconds: 4),
//             onPageChanged: (index, reason) {
//               setState(() {
//                 _currentPromo = index;
//               });
//             },
//           ),
//           items: promotionalHighlights.map((item) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: AspectRatio(
//                 aspectRatio: 16 / 5,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       Image.network(item['image'], fit: BoxFit.cover),
//                       Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Colors.black.withOpacity(0.55),
//                               Colors.transparent,
//                             ],
//                             begin: Alignment.centerLeft,
//                             end: Alignment.centerRight,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: ConstrainedBox(
//                             constraints: const BoxConstraints(maxWidth: 420),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   "🎯 Promotional Highlights",
//                                   style: TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   item['name'],
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 const SizedBox(height: 6),
//                                 Text(
//                                   "Starting at ৳${item['price']}",
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.white,
//                                     foregroundColor: Colors.black87,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 16,
//                                       vertical: 10,
//                                     ),
//                                   ),
//                                   onPressed: () {},
//                                   child: const Text("Shop Now"),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//         const SizedBox(height: 8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(promotionalHighlights.length, (index) {
//             final selected = _currentPromo == index;
//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 250),
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               height: 8,
//               width: selected ? 18 : 8,
//               decoration: BoxDecoration(
//                 color: selected ? Colors.black87 : Colors.black26,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.only(top: 16, bottom: 32),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: buildImageCarousel(context),
//             ),
//             const SizedBox(height: 16),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 "🔥 Product Offers",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             buildProductGrid(productOffers, context),
//             const SizedBox(height: 8),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 "⭐ Popular Products",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             buildProductGrid(popularProducts, context),
//             const SizedBox(height: 8),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 "🎯 Promotional Highlights",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             buildPromoBannerSlider(context),
//           ],
//         ),
//       ),
//     );
//   }
// }


//modify by me

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _currentCarousel = 0;
  int _currentPromo = 0;

  final List<String> carouselImages = [
    '/images/pharmacy.jpg',
    '/images/pharmacy1.jpeg',
    '/images/stock.jpg',
  ];

  final List<Map<String, dynamic>> productOffers = [
    {
      'name': 'Aletrol',
      'price': '2,499',
      'image': '/images/medicine.webp',
      'discount': '20% OFF',
    },
    {
      'name': 'Rolack',
      'price': '7,999',
      'image': '/images/rolac.webp',
      'discount': '50% OFF',
    },
    {
      'name': 'Dressers',
      'price': '1,799',
      'image': '/images/telfast.jpg',
      'discount': '10% OFF',
    },
  ];

  final List<Map<String, dynamic>> popularProducts = [
    {
      'name': 'Insulin',
      'price': '25,999',
      'image': '/images/bigstock.jpg',
    },
    {
      'name': 'Bosutinib',
      'price': '65,999',
      'image': '/images/bosutinib.webp',
    },
    {
      'name': 'Omeprazole',
      'price': '42,999',
      'image': '/images/Omeprazole.jpg',
    },
  ];

  final List<Map<String, dynamic>> promotionalHighlights = [
   
    {
      'name': 'Mental Health',
      'price': 89900,
      'image': '/images/stock-vector.jpg',
    },
    {
      'name': 'Cancer Medicine',
      'price': 2449,
      'image': '/images/cancer-2.webp',
    },
  ];

  int getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1200) return 5;
    if (width > 800) return 3;
    return 2;
  }

  Widget buildImageCarousel() {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                onPageChanged: (index, reason) {
                  setState(() => _currentCarousel = index);
                },
              ),
              items: carouselImages.map((path) {
                return Image.asset(
                  path,
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(carouselImages.length, (index) {
            final selected = _currentCarousel == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: selected ? 18 : 8,
              decoration: BoxDecoration(
                color: selected ? Colors.deepPurple : Colors.grey[400],
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget buildProductGrid(List<Map<String, dynamic>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getCrossAxisCount(context),
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final product = items[index];
        return Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(product['image'],
                        fit: BoxFit.cover, width: double.infinity),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 4),
                      Text("৳${product['price']}",
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ],
                  ),
                ),
                if (product.containsKey('discount'))
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(product['discount'],
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12)),
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPromoBannerSlider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1.0,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() => _currentPromo = index);
            },
          ),
          items: promotionalHighlights.map((item) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(item['image'], fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['name'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text("Starting at ৳${item['price']}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white),
                          child: const Text("buyNow"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(promotionalHighlights.length, (index) {
            final selected = _currentPromo == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: selected ? 18 : 8,
              decoration: BoxDecoration(
                color: selected ? Colors.deepPurple : Colors.grey[400],
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: buildImageCarousel(),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("🔥 Medicine Offers",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            buildProductGrid(productOffers),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("⭐ Popular Medicine",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            buildProductGrid(popularProducts),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("🎯 Promotional Highlights",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            buildPromoBannerSlider(),
          ],
        ),
      ),
    );
  }
}




