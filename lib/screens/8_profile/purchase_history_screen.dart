import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Extended Dummy Data for Purchase History
    final List<Map<String, String>> history = [
      {
        'orderId': '#FND-98234',
        'title': 'Anime Expo VIP Ticket',
        'date': '01 Aug 2026',
        'amount': '\$75.00',
        'status': 'Completed',
        'category': 'Ticket',
        'paymentMethod': 'Credit Card (**** 4242)',
      },
      {
        'orderId': '#FND-88210',
        'title': 'Cyberpunk Poster',
        'date': '15 Jul 2026',
        'amount': '\$25.00',
        'status': 'Delivered',
        'category': 'Merch',
        'paymentMethod': 'Google Pay',
      },
      {
        'orderId': '#FND-76129',
        'title': 'Gamer Badge Membership',
        'date': '10 Jun 2026',
        'amount': '\$12.99',
        'status': 'Completed',
        'category': 'Digital',
        'paymentMethod': 'Apple Pay',
      },
    ];

    // Calculate Total Spent
    final double totalSpent = history.fold(0.0, (sum, item) {
      final price = double.tryParse(item['amount']!.replaceAll('\$', '')) ?? 0.0;
      return sum + price;
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Purchase History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: history.isEmpty
          ? _buildEmptyState()
          : SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Spent Stats Card
            _buildSummaryCard(history.length, totalSpent),

            const SizedBox(height: 24),

            Text(
              'RECENT TRANSACTIONS',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 12),

            // History List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                return _buildHistoryCard(context, item);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Header Summary Card
  Widget _buildSummaryCard(int totalOrders, double totalSpent) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.cardBg,
            AppColors.primary.withValues(alpha: 0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Spent',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${totalSpent.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppColors.cyan,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            height: 40,
            width: 1,
            color: Colors.white12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Orders Placed',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$totalOrders Items',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Individual Order Item Card
  Widget _buildHistoryCard(BuildContext context, Map<String, String> item) {
    IconData categoryIcon = Icons.receipt_rounded;
    if (item['category'] == 'Ticket') categoryIcon = Icons.confirmation_number_rounded;
    if (item['category'] == 'Merch') categoryIcon = Icons.shopping_bag_rounded;
    if (item['category'] == 'Digital') categoryIcon = Icons.stars_rounded;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cyan.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(categoryIcon, color: AppColors.cyan, size: 22),
          ),
          title: Text(
            item['title']!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Text(
                  item['date']!,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    item['status']!,
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          trailing: Text(
            item['amount']!,
            style: const TextStyle(
              color: AppColors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          onTap: () => _showOrderDetailsBottomSheet(context, item),
        ),
      ),
    );
  }

  // Bottom Sheet for Order Details
  void _showOrderDetailsBottomSheet(BuildContext context, Map<String, String> item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Transaction Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildDetailRow('Order ID', item['orderId']!),
              _buildDetailRow('Item Name', item['title']!),
              _buildDetailRow('Date', item['date']!),
              _buildDetailRow('Payment Method', item['paymentMethod']!),
              _buildDetailRow('Status', item['status']!, isStatus: true),
              const Divider(color: Colors.white12, height: 24),
              _buildDetailRow('Total Amount', item['amount']!, isPrice: true),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  icon: const Icon(Icons.download_rounded, color: Colors.white, size: 18),
                  label: const Text(
                    'Download Receipt',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Downloading receipt...'),
                        backgroundColor: AppColors.cardBg,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isPrice = false, bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13)),
          Text(
            value,
            style: TextStyle(
              color: isPrice
                  ? AppColors.pink
                  : isStatus
                  ? Colors.greenAccent
                  : Colors.white,
              fontSize: isPrice ? 18 : 13,
              fontWeight: (isPrice || isStatus) ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // Empty State View
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.cardBg.withValues(alpha: 0.5),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white12),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              size: 64,
              color: AppColors.pink,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No Purchases Yet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your completed transactions will appear here.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}