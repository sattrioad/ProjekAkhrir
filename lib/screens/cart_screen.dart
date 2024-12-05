import 'package:flutter/material.dart';
import 'checkout_screen.dart';
import '../models/cart.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  CartScreen({required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _removeFromCart(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Colors.white,
            surface: Color(0xFF424242),
          ),
        ),
        child: AlertDialog(
          backgroundColor: Color(0xFF424242),
          title: Text('Delete Item', style: TextStyle(color: Colors.white)),
          content: Text(
            'Are you sure you want to remove this item from your cart?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.white70)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.cartItems.removeWhere((item) => item.id == id);
                });
                Navigator.of(ctx).pop();
              },
              child: Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount =
        widget.cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

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
                child: Text(
                  'Your Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Cart Content
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: widget.cartItems.isEmpty
                      ? Center(
                          child: Text(
                            'Your cart is empty',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(8),
                          itemCount: widget.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = widget.cartItems[index];
                            return Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    child: Image.network(
                                      item.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  item.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Rp ${item.price} x ${item.quantity}',
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white70,
                                  ),
                                  onPressed: () =>
                                      _removeFromCart(context, item.id),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),

              // Bottom Bar
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Rp ${totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: widget.cartItems.isEmpty
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(
                                      cartItems: widget.cartItems,
                                    ),
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          disabledBackgroundColor:
                              Colors.white.withOpacity(0.05),
                        ),
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
