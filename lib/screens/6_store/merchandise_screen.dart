import 'package:flutter/material.dart';

import 'product_details_screen.dart';
import 'wishlist_screen.dart';
import 'cart_screen.dart';

class MerchandiseScreen extends StatefulWidget {
  const MerchandiseScreen({super.key});

  @override
  State<MerchandiseScreen> createState() => _MerchandiseScreenState();
}

class _MerchandiseScreenState extends State<MerchandiseScreen> {
  String selectedCategory = 'All';
  String selectedSort = 'Popular';
  String searchText = '';

  final TextEditingController searchController = TextEditingController();

  final List<String> categories = [
    'All',
    'Anime',
    'Gaming',
    'Comics',
    'Sci-Fi',
  ];

  // Tracker for Wishlist & Cart items
  final Set<String> wishlistedProducts = {};
  final List<Map<String, dynamic>> cartItems = [];

  final List<Map<String, dynamic>> products = [
    {
      'id': '1',
      'name': 'Anime Hoodie',
      'price': 2499,
      'category': 'Anime',
      'image': 'assets/images/merchandise/anime_hoodie.png',
      'icon': Icons.checkroom_rounded,
    },
    {
      'id': '2',
      'name': 'Gaming T-Shirt',
      'price': 1499,
      'category': 'Gaming',
      'image': 'assets/images/merchandise/anime_shirt.png',
      'icon': Icons.sports_esports_rounded,
    },
    {
      'id': '3',
      'name': 'Comic Poster',
      'price': 799,
      'category': 'Comics',
      'image': 'assets/images/merchandise/anime_po.png',
      'icon': Icons.image_rounded,
    },
    {
      'id': '4',
      'name': 'Sci-Fi Figure',
      'price': 3499,
      'category': 'Sci-Fi',
      'image': 'assets/images/merchandise/anime_fig.png',
      'icon': Icons.auto_awesome_rounded,
    },
    {
      'id': '5',
      'name': 'Fandom Cap',
      'price': 999,
      'category': 'Anime',
      'image': 'assets/images/merchandise/fandom_ca.png',
      'icon': Icons.face_rounded,
    },
    {
      'id': '6',
      'name': 'Gaming Mug',
      'price': 1199,
      'category': 'Gaming',
      'image': 'assets/images/merchandise/gaming_mu.png',
      'icon': Icons.coffee_rounded,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> result = List.from(products);

    if (selectedCategory != 'All') {
      result = result
          .where((product) => product['category'] == selectedCategory)
          .toList();
    }

    if (searchText.trim().isNotEmpty) {
      result = result.where((product) {
        final name = product['name'].toString().toLowerCase();
        return name.contains(searchText.trim().toLowerCase());
      }).toList();
    }

    if (selectedSort == 'Low to High') {
      result.sort((a, b) => (a['price'] as int).compareTo(b['price'] as int));
    } else if (selectedSort == 'High to Low') {
      result.sort((a, b) => (b['price'] as int).compareTo(a['price'] as int));
    }

    return result;
  }

  void _toggleWishlist(String productName) {
    setState(() {
      if (wishlistedProducts.contains(productName)) {
        wishlistedProducts.remove(productName);
        _showSnackBar('$productName removed from wishlist', isError: true);
      } else {
        wishlistedProducts.add(productName);
        _showSnackBar('$productName added to wishlist! ❤️');
      }
    });
  }

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      cartItems.add(product);
    });
    _showSnackBar('${product['name']} added to cart! 🛒');
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: isError ? const Color(0xFFDC2626) : const Color(0xFF8B5CF6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
        title: const Text(
          'Merchandise',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Wishlist Action Button
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WishlistScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.white,
                ),
              ),
              if (wishlistedProducts.isNotEmpty)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEC4899),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),

          // Cart Action Button with Badge
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
              if (cartItems.isNotEmpty)
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
                      '${cartItems.length}',
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

      body: Column(
        children: [
          // ================= FANDOM BANNER =================
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFF8B5CF6).withOpacity(0.45),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8B5CF6).withOpacity(0.20),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: AspectRatio(
                aspectRatio: 3.2,
                child: Image.asset(
                  'assets/images/merchandise/fandom_collection.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF7C3AED),
                            Color(0xFF06B6D4),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'FANDOM COLLECTION',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // ================= SEARCH =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search merchandise...',
                hintStyle: const TextStyle(color: Color(0xFF8585A5)),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF06B6D4),
                ),
                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear_rounded,
                      color: Color(0xFF8585A5)),
                  onPressed: () {
                    searchController.clear();
                    setState(() {
                      searchText = '';
                    });
                  },
                )
                    : null,
                filled: true,
                fillColor: const Color(0xFF0D0D2B),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF292955)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF06B6D4)),
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // ================= CATEGORIES =================
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    selectedColor: const Color(0xFF8B5CF6),
                    backgroundColor: const Color(0xFF151542),
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFF8B5CF6)
                          : const Color(0xFF292955),
                    ),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFFB8B8D9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 14),

          // ================= COUNT + SORT =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '${filteredProducts.length} Items Found',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  color: const Color(0xFF151542),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: Color(0xFF292955)),
                  ),
                  onSelected: (value) {
                    setState(() {
                      selectedSort = value;
                    });
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'Popular',
                      child: Text('Popular', style: TextStyle(color: Colors.white)),
                    ),
                    PopupMenuItem(
                      value: 'Low to High',
                      child: Text('Price: Low to High', style: TextStyle(color: Colors.white)),
                    ),
                    PopupMenuItem(
                      value: 'High to Low',
                      child: Text('Price: High to Low', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151542),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF292955)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.sort_rounded,
                          color: Color(0xFF06B6D4),
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          selectedSort,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ================= PRODUCT GRID =================
          Expanded(
            child: filteredProducts.isEmpty
                ? _buildEmptyState()
                : LayoutBuilder(
              builder: (context, constraints) {
                // Adapt grid count for wide screens/tablets dynamically
                int crossAxisCount = constraints.maxWidth > 900
                    ? 4
                    : constraints.maxWidth > 600
                    ? 3
                    : 2;

                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  itemCount: filteredProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    final isLiked =
                    wishlistedProducts.contains(product['name']);

                    return _ProductCard(
                      name: product['name'],
                      price: product['price'],
                      category: product['category'],
                      image: product['image'],
                      isWishlisted: isLiked,
                      onWishlistToggle: () =>
                          _toggleWishlist(product['name']),
                      onAddToCart: () => _addToCart(product),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(
                              productName: product['name'],
                              price: product['price'],
                              category: product['category'],
                              icon: product['icon'],
                              image: product['image'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 60,
            color: const Color(0xFF8B5CF6).withOpacity(0.5),
          ),
          const SizedBox(height: 12),
          const Text(
            'No merchandise found',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Try searching for another keyword or category',
            style: TextStyle(
              color: Color(0xFFB8B8D9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PRODUCT CARD WIDGET
// ============================================================

class _ProductCard extends StatelessWidget {
  final String name;
  final int price;
  final String category;
  final String image;
  final bool isWishlisted;
  final VoidCallback onWishlistToggle;
  final VoidCallback onAddToCart;
  final VoidCallback onTap;

  const _ProductCard({
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    required this.isWishlisted,
    required this.onWishlistToggle,
    required this.onAddToCart,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D2B),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF8B5CF6).withOpacity(0.18),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF35136B),
                                  Color(0xFF101B4D),
                                  Color(0xFF063B63),
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: Color(0xFF06B6D4),
                                size: 40,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onWishlistToggle,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF05051A).withOpacity(0.80),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isWishlisted
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: isWishlisted
                              ? const Color(0xFFEC4899)
                              : Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product Information & Quick Actions
            Padding(
              padding: const EdgeInsets.all(12),
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
                  const SizedBox(height: 3),
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rs. $price',
                        style: const TextStyle(
                          color: Color(0xFFEC4899),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: onAddToCart,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5CF6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}