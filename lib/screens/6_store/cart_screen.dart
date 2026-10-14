import 'package:flutter/material.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promoController = TextEditingController();

  final List<CartProduct> products = [
    CartProduct(
      id: 'p1',
      name: 'Anime Hoodie',
      price: 2499,
      category: 'Anime',
      quantity: 1,
      image: 'assets/images/merchandise/anime_hoodie.png',
      icon: Icons.checkroom_rounded,
    ),
    CartProduct(
      id: 'p2',
      name: 'Gaming T-Shirt',
      price: 1499,
      category: 'Gaming',
      quantity: 2,
      image: 'assets/images/merchandise/anime_shirt.png',
      icon: Icons.sports_esports_rounded,
    ),
    CartProduct(
      id: 'p3',
      name: 'Comic Poster',
      price: 799,
      category: 'Comics',
      quantity: 1,
      image: 'assets/images/merchandise/anime_po.png',
      icon: Icons.image_rounded,
    ),
    CartProduct(
      id: 'p4',
      name: 'Sci-Fi Figure',
      price: 3499,
      category: 'Sci-Fi',
      quantity: 1,
      image: 'assets/images/merchandise/anime_fig.png',
      icon: Icons.mouse_rounded,
    ),
  ];

  double discountPercentage = 0.0;
  String? appliedCoupon;
  bool isApplyingCoupon = false;

  int get subtotal {
    return products.fold(
      0,
          (sum, product) => sum + product.price * product.quantity,
    );
  }

  int get deliveryFee {
    if (subtotal == 0 || subtotal >= 5000) return 0;
    return 250; // Standard delivery charge
  }

  double get discountAmount {
    return subtotal * discountPercentage;
  }

  int get grandTotal {
    final total = (subtotal - discountAmount) + deliveryFee;
    return total < 0 ? 0 : total.round();
  }

  void increase(int index) {
    setState(() {
      products[index].quantity++;
    });
  }

  void decrease(int index) {
    setState(() {
      if (products[index].quantity > 1) {
        products[index].quantity--;
      } else {
        _confirmRemove(index);
      }
    });
  }

  void remove(int index) {
    final removedItem = products[index];
    setState(() {
      products.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF0D0D2B),
        content: Text(
          'Removed ${removedItem.name}',
          style: const TextStyle(color: Colors.white),
        ),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: const Color(0xFF06B6D4),
          onPressed: () {
            setState(() {
              products.insert(index, removedItem);
            });
          },
        ),
      ),
    );
  }

  void _confirmRemove(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0D0D2B),
        title: const Text(
          'Remove Item?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Do you want to remove ${products[index].name} from your cart?',
          style: const TextStyle(color: Color(0xFFB8B8D9)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEC4899),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              remove(index);
            },
            child: const Text('Remove', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _clearCart() {
    if (products.isEmpty) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0D0D2B),
        title: const Text(
          'Clear Cart?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to remove all items from your cart?',
          style: TextStyle(color: Color(0xFFB8B8D9)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEC4899),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                products.clear();
                appliedCoupon = null;
                discountPercentage = 0.0;
                _promoController.clear();
              });
            },
            child: const Text('Clear All', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _applyCoupon() {
    final code = _promoController.text.trim().toUpperCase();
    if (code.isEmpty) return;

    FocusScope.of(context).unfocus();
    setState(() => isApplyingCoupon = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => isApplyingCoupon = false);

      if (code == 'FANDOM10' || code == 'APTECH10') {
        setState(() {
          discountPercentage = 0.10; // 10% Off
          appliedCoupon = code;
        });
        _showToast('Coupon applied! 10% Discount unlocked 🎉', isSuccess: true);
      } else if (code == 'HERO20') {
        setState(() {
          discountPercentage = 0.20; // 20% Off
          appliedCoupon = code;
        });
        _showToast('Mega Coupon applied! 20% Discount unlocked ⚡', isSuccess: true);
      } else {
        _showToast('Invalid Coupon Code! Try FANDOM10', isSuccess: false);
      }
    });
  }

  void _removeCoupon() {
    setState(() {
      appliedCoupon = null;
      discountPercentage = 0.0;
      _promoController.clear();
    });
    _showToast('Coupon removed', isSuccess: false);
  }

  void _showToast(String msg, {required bool isSuccess}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isSuccess ? const Color(0xFF059669) : const Color(0xFFDC2626),
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05051A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF05051A),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (products.isNotEmpty) ...[
            TextButton(
              onPressed: _clearCart,
              child: const Text(
                'Clear All',
                style: TextStyle(
                  color: Color(0xFFEC4899),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 4),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF06B6D4).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
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
            ),
          ],
        ],
      ),
      body: products.isEmpty
          ? _emptyCart()
          : SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Wide Screen Layout (Tablets / Desktop)
            if (constraints.maxWidth > 700) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return _buildDismissibleItem(index);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: _billSummary(isMobile: false),
                    ),
                  ),
                ],
              );
            }

            // Mobile Screen Layout
            return Column(
              children: [
                // Free Shipping Progress Tracker
                _freeShippingBar(),

                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return _buildDismissibleItem(index);
                    },
                  ),
                ),
                _billSummary(isMobile: true),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDismissibleItem(int index) {
    final product = products[index];
    return Dismissible(
      key: Key(product.id + product.name),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFDC2626).withOpacity(0.85),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 28),
            SizedBox(width: 8),
            Text(
              'Remove',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (_) => remove(index),
      child: _CartItem(
        product: product,
        onIncrease: () => increase(index),
        onDecrease: () => decrease(index),
        onRemove: () => remove(index),
      ),
    );
  }

  Widget _freeShippingBar() {
    final progress = (subtotal / 5000).clamp(0.0, 1.0);
    final remaining = 5000 - subtotal;

    return Container(
      width: double.infinity,
      color: const Color(0xFF0D0D2B),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                remaining <= 0 ? Icons.local_shipping_rounded : Icons.local_shipping_outlined,
                color: remaining <= 0 ? const Color(0xFF10B981) : const Color(0xFF06B6D4),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                remaining <= 0
                    ? '🎉 You unlocked FREE Delivery!'
                    : 'Add Rs. $remaining more for FREE Delivery',
                style: TextStyle(
                  color: remaining <= 0 ? const Color(0xFF10B981) : Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: const Color(0xFF151542),
              color: remaining <= 0 ? const Color(0xFF10B981) : const Color(0xFF06B6D4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _billSummary({required bool isMobile}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D2B),
        borderRadius: isMobile
            ? const BorderRadius.vertical(top: Radius.circular(25))
            : BorderRadius.circular(20),
        border: isMobile
            ? const Border(top: BorderSide(color: Color(0xFF292955)))
            : Border.all(color: const Color(0xFF292955)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // PROMO CODE FIELD
          if (appliedCoupon == null)
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 42,
                    child: TextField(
                      controller: _promoController,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        hintText: 'Promo Code (Try FANDOM10)',
                        hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                        filled: true,
                        fillColor: const Color(0xFF151542),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 42,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF06B6D4),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: isApplyingCoupon ? null : _applyCoupon,
                    child: isApplyingCoupon
                        ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    )
                        : const Text(
                      'Apply',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF10B981).withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.stars_rounded, color: Color(0xFF10B981), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Coupon "$appliedCoupon" Applied',
                    style: const TextStyle(
                      color: Color(0xFF10B981),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _removeCoupon,
                    child: const Icon(Icons.close_rounded, color: Colors.white70, size: 18),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 16),

          // PRICING BREAKDOWN
          _PriceRow(
            title: 'Subtotal',
            value: 'Rs. $subtotal',
          ),
          const SizedBox(height: 10),

          if (discountAmount > 0) ...[
            _PriceRow(
              title: 'Discount (${(discountPercentage * 100).toInt()}%)',
              value: '- Rs. ${discountAmount.round()}',
              isDiscount: true,
            ),
            const SizedBox(height: 10),
          ],

          _PriceRow(
            title: 'Delivery Charge',
            value: deliveryFee == 0 ? 'FREE' : 'Rs. $deliveryFee',
            isHighlight: deliveryFee == 0,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(
              color: Color(0xFF292955),
            ),
          ),

          _PriceRow(
            title: 'Total Payable',
            value: 'Rs. $grandTotal',
            total: true,
          ),

          const SizedBox(height: 18),

          // CHECKOUT BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 4,
                shadowColor: const Color(0xFF8B5CF6).withOpacity(0.5),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutScreen(
                      // Pass real calculated dynamic data if your CheckoutScreen accepts
                      // cartProducts: products,
                      // totalAmount: grandTotal,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart_checkout_rounded),
              label: Text(
                'Checkout (Rs. $grandTotal)',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyCart() {
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
                color: const Color(0xFF06B6D4).withOpacity(0.12),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 65,
                color: Color(0xFF06B6D4),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Your Cart is Empty',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add some fandom merchandise to your cart to get started.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFB8B8D9),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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

class CartProduct {
  final String id;
  final String name;
  final int price;
  final String category;
  int quantity;
  final String image;
  final IconData icon;

  CartProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.quantity,
    required this.image,
    required this.icon,
  });
}

class _CartItem extends StatelessWidget {
  final CartProduct product;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const _CartItem({
    required this.product,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
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
          color: const Color(0xFF8B5CF6).withOpacity(0.17),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // PRODUCT IMAGE CONTAINER
          Container(
            width: 85,
            height: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF7C3AED).withOpacity(0.3),
                  const Color(0xFFEC4899).withOpacity(0.2),
                  const Color(0xFF06B6D4).withOpacity(0.18),
                ],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                product.image,
                width: 85,
                height: 95,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    product.icon,
                    size: 38,
                    color: const Color(0xFF06B6D4),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 13),

          // PRODUCT INFO & CONTROLS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.category.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF06B6D4),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Rs. ${product.price * product.quantity}',
                  style: const TextStyle(
                    color: Color(0xFFEC4899),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // QUANTITY CONTROL PILL
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF151542),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: onDecrease,
                            borderRadius: BorderRadius.circular(8),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.remove_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '${product.quantity}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: onIncrease,
                            borderRadius: BorderRadius.circular(8),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.add_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // DELETE BUTTON
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
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

class _PriceRow extends StatelessWidget {
  final String title;
  final String value;
  final bool total;
  final bool isDiscount;
  final bool isHighlight;

  const _PriceRow({
    required this.title,
    required this.value,
    this.total = false,
    this.isDiscount = false,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    Color getValueColor() {
      if (total) return const Color(0xFF06B6D4);
      if (isDiscount) return const Color(0xFF10B981);
      if (isHighlight) return const Color(0xFF10B981);
      return Colors.white;
    }

    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: total ? Colors.white : const Color(0xFFB8B8D9),
            fontSize: total ? 16 : 13,
            fontWeight: total ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: getValueColor(),
            fontSize: total ? 17 : 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}