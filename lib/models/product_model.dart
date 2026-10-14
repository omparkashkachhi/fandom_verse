class Product {
  final String id;
  final String title;
  final double price;
  final String category;
  final String imageUrl;
  final String description;
  bool isWishlisted;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.description,
    this.isWishlisted = false,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}