import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/product_model.dart';
import 'cart_screen.dart';
import 'merchandise_screen.dart';
import 'product_details_screen.dart';
import 'widgets/product_card.dart';
import 'wishlist_screen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String selectedCategory = 'All';
  bool showSearch = false;
  String searchQuery = '';

  final TextEditingController searchController = TextEditingController();

  final List<String> categories = const [
    'All',
    'Figures',
    'Apparel',
    'Collectibles',
    'Digital',
  ];

  final List<Product> products = [
    Product(
      id: 'p1',
      title: 'Galaxy Hoodie',
      price: 29.99,
      category: 'Apparel',
      imageUrl: 'assets/images/merchandise/Galaxy_HoodiePro.jpg',
      description: 'Premium quality neon galaxy print hoodie for fans.',
    ),
    Product(
      id: 'p2',
      title: 'Mystic Poster',
      price: 12.99,
      category: 'Collectibles',
      imageUrl: 'assets/images/merchandise/Mystic_PosterProm).jpg',
      description: 'High-definition neon aesthetic wall art poster.',
    ),
    Product(
      id: 'p3',
      title: 'Pixel Controller',
      price: 39.99,
      category: 'Digital',
      imageUrl: 'assets/images/merchandise/Pixel_ControllerPro.jpg',
      description: 'Custom themed wireless controller for gamers.',
    ),
    Product(
      id: 'p4',
      title: 'Comic Journal',
      price: 16.99,
      category: 'Collectibles',
      imageUrl: 'assets/images/merchandise/Comic_Journal.jpg',
      description: 'Vintage hardcover collector edition comic journal.',
    ),
  ];

  final List<CartItem> cartItems = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _addToCart(Product product) {
    setState(() {
      final index =
      cartItems.indexWhere((item) => item.product.id == product.id);
      if (index >= 0) {
        cartItems[index].quantity++;
      } else {
        cartItems.add(CartItem(product: product));
      }
    });

    _showSnackBar('${product.title} added to Cart! 🛒');
  }

  void _toggleWishlist(Product product) {
    setState(() {
      product.isWishlisted = !product.isWishlisted;
    });

    final message = product.isWishlisted
        ? '${product.title} added to wishlist! ❤️'
        : '${product.title} removed from wishlist';

    _showSnackBar(message, isError: !product.isWishlisted);
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor:
        isError ? const Color(0xFFDC2626) : const Color(0xFF8B5CF6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((p) {
      final matchCat =
          selectedCategory == 'All' || p.category == selectedCategory;
      final matchSearch =
      p.title.toLowerCase().contains(searchQuery.trim().toLowerCase());
      return matchCat && matchSearch;
    }).toList();

    int cartItemCount = cartItems.fold(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      backgroundColor: AppColors.background,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Fandom Store',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          // Search Toggle Button
          IconButton(
            onPressed: () {
              setState(() {
                showSearch = !showSearch;
                if (!showSearch) {
                  searchQuery = '';
                  searchController.clear();
                }
              });
            },
            icon: Icon(
              showSearch ? Icons.close_rounded : Icons.search_rounded,
              color: Colors.white,
            ),
          ),

          // Wishlist Action Button
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
                  Icons.shopping_cart_outlined,
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
                      color: Color(0xFFEC4899),
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartItemCount',
                      style: const TextStyle(
                        color: Colors.white,
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

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 2;
            if (constraints.maxWidth > 900) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 600) {
              crossAxisCount = 3;
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= SEARCH BAR =================
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 250),
                    crossFadeState: showSearch
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: const SizedBox.shrink(),
                    secondChild: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: searchController,
                        style:
                        const TextStyle(color: Colors.white, fontSize: 14),
                        onChanged: (val) => setState(() => searchQuery = val),
                        decoration: InputDecoration(
                          hintText: 'Search merchandise...',
                          hintStyle: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: Colors.cyan,
                          ),
                          suffixIcon: searchQuery.isNotEmpty
                              ? IconButton(
                            icon: const Icon(
                              Icons.clear_rounded,
                              color: AppColors.textSecondary,
                            ),
                            onPressed: () {
                              searchController.clear();
                              setState(() => searchQuery = '');
                            },
                          )
                              : null,
                          filled: true,
                          fillColor: AppColors.cardBg,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.white12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.white12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.cyan),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ================= CATEGORIES PILLS =================
                  SizedBox(
                    height: 38,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selectedCategory == category;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => selectedCategory = category),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withOpacity(0.3)
                                  : AppColors.cardBg,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color:
                                isSelected ? Colors.cyan : Colors.white12,
                                width: 1.2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                  fontSize: 12,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= EXCLUSIVE MERCH BANNER =================
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MerchandiseScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyan.withOpacity(0.08),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.storefront_rounded,
                            color: Colors.cyan,
                            size: 28,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Exclusive Merch',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Official fandom collections & gear',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.cyan,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= PRODUCT GRID =================
                  filteredProducts.isEmpty
                      ? Container(
                    height: 180,
                    alignment: Alignment.center,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          color: AppColors.textSecondary,
                          size: 40,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'No products found',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                      : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailsScreen(
                                productName: product.title,
                                price: product.price.toInt(),
                                category: product.category,
                                icon: Icons.shopping_bag_rounded,
                                image: product.imageUrl,
                              ),
                            ),
                          );
                        },
                        onWishlistTap: () => _toggleWishlist(product),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}