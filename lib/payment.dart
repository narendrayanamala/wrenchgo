
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String selectedPaymentMethod = 'UPI';

  final double serviceCharges = 400.00;
  final double platformFee = 50.00;
  final double taxes = 72.00;

  double get totalAmount {
    return serviceCharges + platformFee + taxes;
  }

  void confirmPayment() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Payment of ₹${totalAmount.toStringAsFixed(2)} using '
          '$selectedPaymentMethod',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEF4FF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _mechanicCard(),

              const SizedBox(height: 25),

              _billDetails(),

              const SizedBox(height: 25),

              _paymentMethods(),

              const SizedBox(height: 25),

              _confirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mechanicCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: const Color(0xFFE0EAFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.person,
              size: 60,
              color: Color(0xFF2563EB),
            ),
          ),

          const SizedBox(width: 18),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rahul Kumar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Vehicle Not starting',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _billDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bill Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _billRow(
                'Service Charges',
                serviceCharges,
              ),
              const SizedBox(height: 15),
              _billRow(
                'Platform Fee',
                platformFee,
              ),
              const SizedBox(height: 15),
              _billRow(
                'Taxes & GST',
                taxes,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '₹${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color(0xFF1D4ED8),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: Color(0xFF137400),
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Your payment is secure and encrypted',
                        style: TextStyle(
                          color: Color(0xFF137400),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _billRow(String title, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        Text(
          '₹${amount.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _paymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 12),

        _paymentMethodCard(
          title: 'UPI',
          icon: Icons.account_balance,
        ),

        const SizedBox(height: 10),

        _paymentMethodCard(
          title: 'Credit/Debit Card',
          icon: Icons.credit_card,
        ),

        const SizedBox(height: 10),

        _paymentMethodCard(
          title: 'Cash',
          icon: Icons.money,
        ),
      ],
    );
  }

  Widget _paymentMethodCard({
    required String title,
    required IconData icon,
  }) {
    bool isSelected = selectedPaymentMethod == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = title;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE2E8F0)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3564D1)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 62,
              height: 60,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF2563EB),
                size: 28,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: isSelected
                  ? const Color(0xFF3564D1)
                  : Colors.grey,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }

  Widget _confirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: confirmPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4400FF),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Confirm Payment',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
