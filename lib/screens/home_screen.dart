import 'package:flutter/material.dart';
import 'package:tokosepatu/screens/currency_conversion_screen.dart';
import 'package:tokosepatu/screens/time_conversion_screen.dart';
import 'package:tokosepatu/screens/profile_screen.dart';
import 'package:tokosepatu/screens/feedback_screen.dart';
import 'cart_screen.dart';
import '../models/cart.dart';
import 'package:tokosepatu/models/shoe.dart';
import 'package:tokosepatu/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Shoe> _shoes = [];
  List<CartItem> cartItems = [];
  int _selectedIndex = 2; // Default to Home

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _fetchShoes() async {
    final shoes = await ApiService.fetchShoes();
    setState(() {
      _shoes = shoes;
    });
  }

  void _addToCart(String id, String name, String price, String imageUrl) {
    setState(() {
      final existingItem = cartItems.indexWhere((item) => item.id == id);
      if (existingItem >= 0) {
        cartItems[existingItem].quantity++;
      } else {
        cartItems.add(
            CartItem(id: id, name: name, price: price, imageUrl: imageUrl));
      }
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$name added to cart!')));
  }

  @override
  void initState() {
    super.initState();
    _fetchShoes();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      CurrencyConversionScreen(),
      TimeConversionScreen(),
      _buildHomeScreen(),
      FeedbackScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF212121),
              Color(0xFF424242),
              Color(0xFF616161),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Custom App Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shoe Store',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CartScreen(cartItems: cartItems)),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: _screens[_selectedIndex],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF424242),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade500,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on), label: 'Currency'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Time'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.feedback), label: 'Feedback'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHomeScreen() {
    return _shoes.isEmpty
        ? Center(child: CircularProgressIndicator(color: Colors.white))
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: _shoes.length,
              itemBuilder: (context, index) {
                final shoe = _shoes[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16.0)),
                          child: Image.network(
                            shoe.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          shoe.name,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Price: Rp ${shoe.price}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => _addToCart(
                              shoe.id, shoe.name, shoe.price, shoe.imageUrl),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
