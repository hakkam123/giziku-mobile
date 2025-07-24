import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  final Widget? nextScreen;

  const OnboardingScreen({super.key, this.nextScreen});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _pages = [
    OnboardingItem(
      image: 'assets/hero1.png',
      svgImage: 'assets/hero1.svg',
      title: 'Know Your Nutrition',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed',
      buttonText: 'Get Started',
    ),
    OnboardingItem(
      image: 'assets/hero2.png',
      svgImage: 'assets/hero2.svg',
      title: 'Track Your Progress',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed',
      buttonText: 'Next',
    ),
    OnboardingItem(
      image: 'assets/hero3.png',
      svgImage: 'assets/hero3.svg',
      title: 'Achieve Your Goals',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed',
      buttonText: 'Start',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    print("_goToNextPage called, current page: $_currentPage, total pages: ${_pages.length}");
    if (_currentPage < _pages.length - 1) {
      print("Moving to next page");
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (widget.nextScreen != null) {
      print("On last page, navigating to main app screen: ${widget.nextScreen.runtimeType}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.nextScreen!),
      );
    } else {
      print("ERROR: nextScreen is null in onboarding, cannot navigate");
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // The actual PageView - NOT wrapped in AbsorbPointer
        PageView.builder(
          controller: _pageController,
          // Only use physics prevention, not AbsorbPointer
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemCount: _pages.length,
          itemBuilder: (context, index) {
            return OnboardingPage(
              item: _pages[index],
              onButtonPressed: _goToNextPage,
            );
          },
        ),
        
        // Positioned dots at the bottom
        Positioned(
          bottom: 240, // Position above the title section
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? const Color(0xFF2ECC71)
                      : Colors.grey.shade300,
                ),
              ),
            ),
          ),
        ),
        
        // Invisible overlay to block swipes but allow button presses
        Positioned.fill(
          child: GestureDetector(
            // This will consume horizontal swipes only
            onHorizontalDragStart: (_) {},
            onHorizontalDragUpdate: (_) {},
            onHorizontalDragEnd: (_) {},
            // Make it transparent so buttons can be clicked
            behavior: HitTestBehavior.translucent,
          ),
        ),
      ],
    ),
  );
}

}

class OnboardingItem {
  final String image;
  final String? svgImage;
  final String title;
  final String description;
  final String buttonText;

  OnboardingItem({
    required this.image,
    this.svgImage,
    required this.title,
    required this.description,
    required this.buttonText,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;
  final VoidCallback onButtonPressed;

  const OnboardingPage({
    super.key,
    required this.item,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50, // Light background color
      child: Column(
        children: [
          // Logo at top left
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 20.0),
              child: Image.asset(
                'assets/gizikulabel.png',
                height: 30,
                color: const Color(0xFF2ECC71),
              ),
            ),
          ),
          
          // Illustration
          Expanded(
            child: Center(
              child: item.svgImage != null
                  ? SvgPicture.asset(
                      item.svgImage!,
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      item.image,
                      fit: BoxFit.contain,
                    ),
            ),
          ),

          // Bottom part with white background
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2ECC71),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      item.buttonText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
