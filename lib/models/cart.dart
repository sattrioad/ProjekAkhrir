class CartItem {
  final String id;
  final String name;
  final String price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  double get totalPrice => double.parse(price) * quantity;
}
