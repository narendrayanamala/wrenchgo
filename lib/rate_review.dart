
import 'package:flutter/material.dart';

class RateReviews extends StatefulWidget {
  const RateReviews({super.key});

  @override
  State<RateReviews> createState() => _RateReviewsState();
}

class _RateReviewsState extends State<RateReviews> {
  int selectedRating = 0;

  final TextEditingController reviewController =
      TextEditingController();

  final List<String> feedbackOptions = [
    'On-time Arrival',
    'Behaviour',
    'Quality of work',
    'Value for money',
  ];

  final Set<String> selectedFeedback = {};

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  void submitReview() {
    if (selectedRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a rating'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Review submitted successfully'),
      ),
    );
  }

  void toggleFeedback(String option) {
    setState(() {
      if (selectedFeedback.contains(option)) {
        selectedFeedback.remove(option);
      } else {
        selectedFeedback.add(option);
      }
    });
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
          'Rate & Reviews',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Color(0xFF2563EB),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 30,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),

              _completionCard(),

              const SizedBox(height: 15),

              _mechanicCard(),

              const SizedBox(height: 15),

              _ratingCard(),

              const SizedBox(height: 15),

              _reviewCard(),

              const SizedBox(height: 15),

              _feedbackCard(),

              const SizedBox(height: 20),

              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _completionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEBFFD6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.check_circle,
              color: Color(0xFF33E03F),
              size: 35,
            ),
          ),

          const SizedBox(width: 15),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service completed!',
                  style: TextStyle(
                    color: Color(0xFF33A852),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Thank you for using WrenchGo. '
                  'Please rate your experience with our mechanic.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mechanicCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEE8),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 63,
            height: 63,
            decoration: BoxDecoration(
              color: const Color(0xFFE0EAFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.person,
              size: 40,
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
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 7),

                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '4.8 (120)',
                      style: TextStyle(
                        color: Color(0xFF1F2937),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6),

                Row(
                  children: [
                    Icon(
                      Icons.workspace_premium,
                      color: Color(0xFF2563EB),
                      size: 17,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '8+ years Experienced',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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

  Widget _ratingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FFCC),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'How would you rate your experience?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) {
                int rating = index + 1;

                return IconButton(
                  onPressed: () {
                    setState(() {
                      selectedRating = rating;
                    });
                  },
                  icon: Icon(
                    rating <= selectedRating
                        ? Icons.star
                        : Icons.star_border,
                    size: 42,
                    color: Colors.orange,
                  ),
                );
              },
            ),
          ),

          if (selectedRating > 0) ...[
            const SizedBox(height: 5),
            Text(
              _ratingText(),
              style: const TextStyle(
                color: Color(0xFF33A852),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _ratingText() {
    switch (selectedRating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Great';
      case 5:
        return 'Excellent';
      default:
        return '';
    }
  }

  Widget _reviewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Write Your Review ',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: '(optional)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Share your experience with this mechanic',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: reviewController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Write your review here...',
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color(0xFFE2E8F0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _feedbackCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'What you Like the most ',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: '(optional)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: feedbackOptions.map(
              (option) {
                return _feedbackChip(option);
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _feedbackChip(String option) {
    bool isSelected = selectedFeedback.contains(option);

    return GestureDetector(
      onTap: () {
        toggleFeedback(option);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFC6FFA0)
              : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF33A852)
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              size: 16,
              color: const Color(0xFF2563EB),
            ),
            const SizedBox(width: 5),
            Text(
              option,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: submitReview,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF33E03F),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: const Text(
          'Submit Review',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
