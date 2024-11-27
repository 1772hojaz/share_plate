import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Terms of Service',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Last updated date
            Text(
              'Last updated 4/08/2024',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Clause 1
            _buildClause(
              'Clause 1',
              'All food shared through the app must be safe for consumption, '
                  'prepared and stored following local health regulations. Users must ensure '
                  'that food is properly labeled with any allergens and is within its expiration date.',
            ),
            const SizedBox(height: 16),

            // Clause 2
            _buildClause(
              'Clause 2',
              'Respectful Exchange: Users agree to communicate respectfully '
                  'and honestly with each other regarding the quantity and quality of food being shared. '
                  'Any issues or concerns should be reported to the app support team promptly.',
            ),

            const SizedBox(height: 32),

            // Buttons - one below the other
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildButton('Agree & Continue', Colors.green, Colors.white, () {
                  // Navigate to the next page
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("You agreed to the terms")),
                  );
                }),
                const SizedBox(height: 16),
                _buildButton('Disagree', Colors.red, Colors.white, () {
                  // Handle disagree action
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("You disagreed with the terms")),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClause(String title, String content) {
    return Column(
      children: [
        // Green background for the clause title
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // White background for the clause content
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  Widget _buildButton(
      String text, Color backgroundColor, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}
