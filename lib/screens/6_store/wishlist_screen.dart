import 'package:flutter/material.dart';
import 'cart_screen.dart';

class WishlistScreen extends StatefulWidget {
  final List<Map<String, String>>? wishlist;

  const WishlistScreen({
    super.key,
    this.wishlist,
  });

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late List<Map<String, dynamic>> products;
  int cartItemCount = 0;

  final List<Map<String, dynamic>> defaultProducts = [
    {
      'id': '1',
      'name': 'Anime Hoodie',
      'price': '2499',
      'category': 'Anime',
      'image': 'assets/images/merchandise/anime_hoodie.png',
      'icon': Icons.checkroom_rounded,
    },
    {
      'id': '2',
      'name': 'Gaming T-Shirt',
      'price': '1499',
      'category': 'Gaming',
      'image': 'assets/images/merchandise/anime_shirt.png',
      'icon': Icons.sports_esports_rounded,
    },
    {
      'id': '3',
      'name': 'Comic Poster',
      'price': '799',
      'category': 'Comics',
      'image': 'assets/images/merchandise/anime_po.png',
      'icon': Icons.image_rounded,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize list from passed parameter or fallback to default list
    if (widget.wishlist != null && widget.wishlist!.isNotEmpty) {
      products = widget.wishlist!.map((item) {
        return {
          'id': DateTime.now().millisecondsSinceEpoch.toString() +
              item['title'].hashCode.toString(),
          'name': item['title'] ?? 'Merchandise Item',
          'price': item['price'] ?? '999',
          'category': 'Merch',
          'image': 'assets/images/merchandise/anime_hoodie.png',
          'icon': Icons.favorite_rounded,
        };
      }).toList();
    } else {
      products = List.from(defaultProducts);
    }
  }

  void _removeItem(int index) {
    final removedProduct = products[index];

    setState(() {
      products.removeAt(index);
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${removedProduct['name']} removed from wishlist',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF151542),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: const Color(0xFF06B6D4),
          onPressed: () {
            setState(() {
              products.insert(index, removedProduct);
            });
          },
        ),
      ),
    );
  }

  void _clearAllWishlist() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0D0D2B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFF292955)),
        ),
        title: const Text(
          'Clear Wishlist?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to remove all saved items from your wishlist?',
          style: TextStyle(color: Color(0xFFB8B8D9)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF8585A5)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEC4899),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              setState(() {
                products.clear();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Wishlist cleared'),
                  backgroundColor: const Color(0xFF151542),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            child: const Text('Clear All', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      cartItemCount++;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Added ${product['name']} to Cart!',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF06B6D4),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05051A),

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: const Color(0xFF05051A),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'My Wishlist',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (products.isNotEmpty) ...[
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF8B5CF6).withOpacity(0.4),
                  ),
                ),
                child: Text(
                  '${products.length} Items',
                  style: const TextStyle(
                    color: Color(0xFF06B6D4),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            IconButton(
              tooltip: 'Clear Wishlist',
              onPressed: _clearAllWishlist,
              icon: const Icon(
                Icons.delete_sweep_rounded,
                color: Color(0xFFEC4899),
              ),
            ),
          ],

          // Cart Quick Action Button
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CartScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                ),
              ),
              if (cartItemCount > 0)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF06B6D4),
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartItemCount',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),

      // ================= BODY =================
      body: SafeArea(
        child: products.isEmpty
            ? _emptyWishlist()
            : LayoutBuilder(
          builder: (context, constraints) {
            // Tablet/Desktop Grid Adaptation
            if (constraints.maxWidth > 700) {
              return GridView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: products.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.2,
                ),
                itemBuilder: (context, index) {
                  return _buildCardWrapper(index);
                },
              );
            }

            // Mobile Single-Column ListView
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildCardWrapper(index);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCardWrapper(int index) {
    final product = products[index];

    return Dismissible(
      key: Key(product['id'] ?? product['name']),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _removeItem(index);
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: const Color(0xFFEC4899).withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFEC4899).withOpacity(0.5),
          ),
        ),
        child: const Icon(
          Icons.delete_forever_rounded,
          color: Color(0xFFEC4899),
          size: 30,
        ),
      ),
      child: _WishlistCard(
        name: product['name'],
        price: product['price'].toString(),
        category: product['category'],
        image: product['image'],
        icon: product['icon'],
        onRemove: () => _removeItem(index),
        onAdd: () => _addToCart(product),
      ),
    );
  }

  Widget _emptyWishlist() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEC4899).withOpacity(0.12),
                border: Border.all(
                  color: const Color(0xFFEC4899).withOpacity(0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEC4899).withOpacity(0.15),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 65,
                color: Color(0xFFEC4899),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Your Wishlist is Empty',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Save your favorite fandom merchandise items here for later.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFB8B8D9),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: const Color(0xFF8B5CF6).withOpacity(0.5),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Explore Merchandise',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// WISHLIST CARD WIDGET
// ============================================================

class _WishlistCard extends StatelessWidget {
  final String name;
  final String price;
  final String category;
  final String image;
  final IconData icon;
  final VoidCallback onRemove;
  final VoidCallback onAdd;

  const _WishlistCard({
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    required this.icon,
    required this.onRemove,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D2B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF8B5CF6).withOpacity(0.18),
        ),
      ),
      child: Row(
        children: [
          // Product Image Container
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              width: 95,
              height: 105,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF7C3AED).withOpacity(0.35),
                          const Color(0xFFEC4899).withOpacity(0.22),
                          const Color(0xFF06B6D4).withOpacity(0.20),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        size: 38,
                        color: const Color(0xFF06B6D4),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Details Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF06B6D4),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  price.startsWith('\$') || price.startsWith('Rs')
                      ? price
                      : 'Rs. $price',
                  style: const TextStyle(
                    color: Color(0xFFEC4899),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 36,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B5CF6),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: onAdd,
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 16,
                          ),
                          label: const Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: onRemove,
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Color(0xFFEC4899),
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}