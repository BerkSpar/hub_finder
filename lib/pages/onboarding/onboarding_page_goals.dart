import 'package:flutter/material.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';

class OnboardingPageGoals extends StatelessWidget {
  final OnboardingController controller;

  const OnboardingPageGoals({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text(
                "What is your goals?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "It helps to improve your app experience",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      title: Text("Projetos Pessoais"),
                      subtitle: Text("Foco em projetos pessoais"),
                      trailing: IconButton(
                        icon: Icon(Icons.add_circle, color: Colors.grey),
                        onPressed: () {},
                      ),
                    );
                  },
                  itemCount: 3,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.next,
                child: Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
