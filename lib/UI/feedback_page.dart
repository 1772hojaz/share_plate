import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackPageController extends GetxController {
  // Controller logic for handling rating state
  var selectedRating = 0.obs;

  void updateRating(int rating) {
    selectedRating.value = rating;
  }
}

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final FeedbackPageController controller = Get.put(FeedbackPageController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Text
            const Text(
              'We Value Your Feedback',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 1.67,
                color: Color(0xFF1C1B1F),
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle Text
            const Text(
              'Please share your experience below.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF1C1B1F),
              ),
            ),
            const SizedBox(height: 16),

            // Feedback Input Box
            Container(
              width: 390,
              height: 235,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF1F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                maxLines: null,
                decoration: InputDecoration.collapsed(
                  hintText: 'Enter your feedback here...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Rate Your Experience Text
            const Text(
              'Rate Your Experience',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1C1B1F),
              ),
            ),
            const SizedBox(height: 8),

            // Rating Stars (Clickable and Responsive)
            Obx(() => Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    color: index < controller.selectedRating.value
                        ? Colors.amber
                        : Colors.grey,
                  ),
                  onPressed: () {
                    controller.updateRating(index + 1);
                  },
                );
              }),
            )),
            const Spacer(),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B140), // Button color
                ),
                onPressed: () {
                  // Handle submit action
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Submit text in white
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 95,
        width: double.infinity,
        color: const Color(0xFF00B140),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home, color: Colors.black),
                Text('Home', style: TextStyle(color: Colors.black)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.volunteer_activism, color: Colors.black),
                Text('Donate', style: TextStyle(color: Colors.black)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search, color: Colors.black),
                Text('Search', style: TextStyle(color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: FeedbackPage(), // Entry point to the FeedbackPage
  ));
}
