import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? cartProducts;
  final int? customTotalAmount;

  const CheckoutScreen({
    super.key,
    this.cartProducts,
    this.customTotalAmount,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

enum PaymentMethod { easypaisa, jazzcash, bank, cod }

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool orderCompleted = false;
  bool isProcessing = false;
  PaymentMethod selectedPayment = PaymentMethod.easypaisa;

  final _formKey = GlobalKey<FormState>();

  // Text Controllers for Customer Info & Payment Details
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _bankNameController = TextEditingController();

  late List<Map<String, dynamic>> products;

  @override
  void initState() {
    super.initState();
    // Use passed products if available, otherwise default to initial list
    products = widget.cartProducts ?? [
      {
        'name': 'Anime Hoodie',
        'price': 2499,
        'quantity': 1,
        'icon': Icons.checkroom_rounded,
      },
      {
        'name': 'Gaming T-Shirt',
        'price': 1499,
        'quantity': 2,
        'icon': Icons.sports_esports_rounded,
      },
      {
        'name': 'Comic Poster',
        'price': 799,
        'quantity': 1,
        'icon': Icons.image_rounded,
      },
    ];
  }

  int get subtotal {
    return products.fold(
      0,
          (sum, product) {
        final price = (product['price'] as num).toInt();
        final qty = (product['quantity'] as num).toInt();
        return sum + (price * qty);
      },
    );
  }

  int get deliveryFee => 150; // Standard delivery fee in Rs.
  int get calculatedTotal => widget.customTotalAmount ?? (subtotal + deliveryFee);

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _accountNumberController.dispose();
    _bankNameController.dispose();
    super.dispose();
  }

  void _handleConfirmOrder() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        isProcessing = true;
      });

      // Simulate Payment Processing API call delay
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (!mounted) return;
        setState(() {
          isProcessing = false;
          orderCompleted = true;
        });
      });
    }
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
        title: Text(
          orderCompleted ? 'Order Summary' : 'Checkout',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: orderCompleted
          ? _successScreen()
          : SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isWide = constraints.maxWidth > 800;

            if (isWide) {
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _customerDetailsForm(),
                              const SizedBox(height: 20),
                              _paymentSelectionSection(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: SingleChildScrollView(
                          child: _orderSummaryCard(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _customerDetailsForm(),
                    const SizedBox(height: 22),
                    _paymentSelectionSection(),
                    const SizedBox(height: 22),
                    _orderSummaryCard(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Customer Form Section
  Widget _customerDetailsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _nameController,
          label: 'Full Name',
          icon: Icons.person_outline_rounded,
          validator: (val) =>
          val == null || val.trim().isEmpty ? 'Please enter name' : null,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildTextField(
                controller: _phoneController,
                label: 'Mobile Number',
                icon: Icons.phone_android_rounded,
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter phone';
                  }
                  if (val.length < 11) {
                    return 'Valid 11-digit number required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: _buildTextField(
                controller: _cityController,
                label: 'City',
                icon: Icons.location_city_rounded,
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Enter city'
                    : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _addressController,
          label: 'Complete Shipping Address',
          icon: Icons.location_on_outlined,
          maxLines: 2,
          validator: (val) => val == null || val.trim().isEmpty
              ? 'Please enter shipping address'
              : null,
        ),
      ],
    );
  }

  // Payment Selection Section
  Widget _paymentSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Options',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // EasyPaisa
        _buildPaymentOptionTile(
          method: PaymentMethod.easypaisa,
          title: 'Easypaisa',
          subtitle: 'Instant mobile account transfer',
          color: const Color(0xFF00A859),
          icon: Icons.account_balance_wallet_rounded,
        ),

        // JazzCash
        _buildPaymentOptionTile(
          method: PaymentMethod.jazzcash,
          title: 'JazzCash',
          subtitle: 'Pay via JazzCash mobile wallet',
          color: const Color(0xFFFF0000),
          icon: Icons.phonelink_ring_rounded,
        ),

        // Bank Transfer
        _buildPaymentOptionTile(
          method: PaymentMethod.bank,
          title: 'Bank Transfer',
          subtitle: 'Direct online banking transfer',
          color: const Color(0xFF06B6D4),
          icon: Icons.account_balance_rounded,
        ),

        // Cash on Delivery
        _buildPaymentOptionTile(
          method: PaymentMethod.cod,
          title: 'Cash on Delivery (COD)',
          subtitle: 'Pay cash when package arrives',
          color: const Color(0xFFF59E0B),
          icon: Icons.payments_rounded,
        ),

        const SizedBox(height: 14),

        // Dynamic Payment Details Fields
        if (selectedPayment != PaymentMethod.cod)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0D0D2B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedPayment == PaymentMethod.bank) ...[
                  const Text(
                    'Bank Account Details',
                    style: TextStyle(
                        color: Color(0xFF06B6D4), fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _bankNameController,
                    label: 'Bank Name (e.g., Meezan, HBL)',
                    icon: Icons.business_rounded,
                    validator: (val) => val == null || val.trim().isEmpty
                        ? 'Please enter bank name'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _accountNumberController,
                    label: 'Account / IBAN Number',
                    icon: Icons.numbers_rounded,
                    validator: (val) => val == null || val.trim().isEmpty
                        ? 'Please enter Account/IBAN number'
                        : null,
                  ),
                ] else ...[
                  Text(
                    '${selectedPayment == PaymentMethod.easypaisa ? 'Easypaisa' : 'JazzCash'} Account Number',
                    style: const TextStyle(
                        color: Color(0xFF06B6D4), fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _accountNumberController,
                    label: selectedPayment == PaymentMethod.easypaisa
                        ? '03XXXXXXXXX (Easypaisa Number)'
                        : '03XXXXXXXXX (JazzCash Number)',
                    icon: Icons.phone_iphone_rounded,
                    keyboardType: TextInputType.phone,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please enter account number';
                      }
                      if (val.length < 11) {
                        return 'Enter valid 11-digit account number';
                      }
                      return null;
                    },
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }

  // Payment Option Card Builder
  Widget _buildPaymentOptionTile({
    required PaymentMethod method,
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    bool isSelected = selectedPayment == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = method;
          _accountNumberController.clear();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D2B),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : const Color(0xFF292955),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFFB8B8D9),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Radio<PaymentMethod>(
              value: method,
              groupValue: selectedPayment,
              activeColor: color,
              onChanged: (PaymentMethod? value) {
                if (value != null) {
                  setState(() {
                    selectedPayment = value;
                    _accountNumberController.clear();
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Order Summary Card
  Widget _orderSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D2B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Items',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...products.map(
                (product) => _OrderItem(
              name: product['name'] ?? 'Merchandise',
              price: (product['price'] as num).toInt(),
              quantity: (product['quantity'] as num).toInt(),
              icon: product['icon'] ?? Icons.shopping_bag_outlined,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Color(0xFF292955)),
          ),
          _PriceRow(title: 'Subtotal', value: 'Rs. $subtotal'),
          const SizedBox(height: 8),
          _PriceRow(title: 'Delivery Fee', value: 'Rs. $deliveryFee'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Color(0xFF292955)),
          ),
          _PriceRow(
            title: 'Total Amount',
            value: 'Rs. $calculatedTotal',
            total: true,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 4,
                shadowColor: const Color(0xFF8B5CF6).withOpacity(0.5),
              ),
              onPressed: isProcessing ? null : _handleConfirmOrder,
              child: isProcessing
                  ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
                  : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline_rounded, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Place Order Now',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Textfield Helper
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFB8B8D9), fontSize: 13),
        prefixIcon: Icon(icon, color: const Color(0xFF06B6D4), size: 20),
        filled: true,
        fillColor: const Color(0xFF151542),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF292955)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF06B6D4)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFEC4899)),
        ),
      ),
    );
  }

  // Success Screen
  Widget _successScreen() {
    String paymentTitle = selectedPayment == PaymentMethod.easypaisa
        ? 'Easypaisa'
        : selectedPayment == PaymentMethod.jazzcash
        ? 'JazzCash'
        : selectedPayment == PaymentMethod.bank
        ? 'Bank Transfer'
        : 'Cash on Delivery';

    final orderId = 'FD-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF10B981).withOpacity(0.15),
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                size: 75,
                color: Color(0xFF10B981),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Order Placed Successfully!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Thank you ${_nameController.text.trim()}! Your order has been registered.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFFB8B8D9), fontSize: 13),
            ),
            const SizedBox(height: 20),

            // INVOICE RECEIPT CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0D0D2B),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Order ID:', style: TextStyle(color: Color(0xFFB8B8D9), fontSize: 12)),
                      Text(orderId, style: const TextStyle(color: Color(0xFF06B6D4), fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(color: Color(0xFF292955), height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Payment Method:', style: TextStyle(color: Color(0xFFB8B8D9), fontSize: 12)),
                      Text(paymentTitle, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  if (selectedPayment != PaymentMethod.cod) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Account Number:', style: TextStyle(color: Color(0xFFB8B8D9), fontSize: 12)),
                        Text(_accountNumberController.text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Deliver To:', style: TextStyle(color: Color(0xFFB8B8D9), fontSize: 12)),
                      Expanded(
                        child: Text(
                          '${_addressController.text.trim()}, ${_cityController.text.trim()}',
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Color(0xFF292955), height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Paid:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text('Rs. $calculatedTotal', style: const TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Merchandise', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  final String name;
  final int price;
  final int quantity;
  final IconData icon;

  const _OrderItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF151542),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF7C3AED).withOpacity(0.3),
                  const Color(0xFFEC4899).withOpacity(0.2),
                ],
              ),
            ),
            child: Icon(icon, color: const Color(0xFF06B6D4), size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(
                  'Qty: $quantity',
                  style: const TextStyle(color: Color(0xFF8D8DAA), fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            'Rs. ${price * quantity}',
            style: const TextStyle(
                color: Color(0xFF06B6D4), fontWeight: FontWeight.bold, fontSize: 13),
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

  const _PriceRow({
    required this.title,
    required this.value,
    this.total = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: total ? Colors.white : const Color(0xFFB8B8D9),
            fontWeight: total ? FontWeight.bold : FontWeight.w500,
            fontSize: total ? 16 : 13,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: total ? const Color(0xFF06B6D4) : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: total ? 17 : 13,
          ),
        ),
      ],
    );
  }
}