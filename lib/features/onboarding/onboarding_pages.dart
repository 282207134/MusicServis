import 'package:flutter/material.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/core/theme.dart';
import 'package:music_servis/shared/widgets.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static const _titles = [
    'Millions of tracks',
    'Playlists for any mood',
    'New music every day',
    'Ability to download',
    'High sound quality',
  ];

  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: _titles.length,
            onPageChanged: (value) => setState(() => _index = value),
            itemBuilder: (context, index) => Image.asset(
              'assets/images/onboarding_${index + 1}.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const DecoratedBox(
                decoration: BoxDecoration(gradient: appGradient),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 36),
                  child: Column(
                    children: [
                      const Spacer(),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 180),
                        child: Text(
                          _titles[_index],
                          key: ValueKey(_index),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            height: 1.2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      PageDots(
                        index: _index,
                        count: _titles.length,
                        light: true,
                      ),
                      const SizedBox(height: 76),
                      GradientButton(
                        label: "I'M A NEW USER",
                        height: 60,
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRoutes.welcome),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: OutlinedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, AppRoutes.login),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white70),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'I HAVE AN ACCOUNT',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              letterSpacing: .4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
