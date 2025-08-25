import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingPages = [
    {
      'title': 'Welcome to Habilty - Your Personal Habit Tracker!',
      'description':
          'Take control of your habits and transform your life with Habilty. Let\'s get started on your journey to success!',
      'image': 'assets/images/photo.png',
    },
    {
      'title': 'Explore Habitly Features for Your Journey!',
      'description':
          'With intuitive habit creation and insightful progress tracking, Habitly makes it easy to stay focused, motivated, and accountable.',
      'image': 'assets/images/photo.png',
    },
    {
      'title': 'Unlock Your Potential with Habitly Now!',
      'description':
          'Achieve your goals with Habitly\'s suite of features. Start your habit journey today and unlock your potential!',
      'image': 'assets/images/photo.png',
    },
  ];

  void _nextPage() {
    if (currentPage < onboardingPages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Aller à la page principale
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) {
                setState(() => currentPage = index);
              },
              itemCount: onboardingPages.length,
              itemBuilder: (context, index) {
                final page = onboardingPages[index];
                return Column(
                  children: [
                    // Partie supérieure avec l'image et le fond incurvé
                    Expanded(
                      child: ClipPath(
                        clipper: BottomCurveClipper(),
                        child: Container(
                          color: Colors.deepPurple,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Image.asset(
                                page['image']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Partie inférieure avec texte, progression et boutons
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              page['title']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              page['description']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                height: 1.5,
                              ),
                            ),

                            // Barre de progression
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                onboardingPages.length,
                                (i) => Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: i == currentPage
                                        ? Colors.deepPurple
                                        : Colors.grey.shade300,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),

                            // Boutons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (currentPage < onboardingPages.length - 1)
                                  OutlinedButton(
                                    onPressed: () => _controller.jumpToPage(
                                      onboardingPages.length - 1,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                        255,
                                        244,
                                        234,
                                        234,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                    ),
                                    child: const Text(
                                      'Skip',
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                  ),
                                ElevatedButton(
                                  onPressed: _nextPage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurpleAccent,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: Text(
                                    currentPage == onboardingPages.length - 1
                                        ? 'Start'
                                        : 'Continue',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Clipper pour la courbe en bas de l'image
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
