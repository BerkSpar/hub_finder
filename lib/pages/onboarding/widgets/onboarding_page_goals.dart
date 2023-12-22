import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/shared/core/app_colors.dart';
import 'package:hub_finder/shared/models/user_goal.dart';

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
                    final item = UserGoal.all[index];

                    return Observer(builder: (context) {
                      final isSelected =
                          controller.selectedGoals.contains(item);

                      return ListTile(
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isSelected ? darkColor : Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // TODO: Verificar se no celular não ocorro erro
                          child: Icon(
                            item.icon,
                            color: isSelected ? Colors.white : darkColor,
                          ),
                        ),
                        title: Text(item.title),
                        subtitle: Text(item.subtitle),
                        onTap: () => controller.selectGoal(item),
                        trailing: IconButton(
                          icon: Icon(Icons.add_circle, color: Colors.grey),
                          onPressed: () => controller.selectGoal(item),
                        ),
                      );
                    });
                  },
                  itemCount: UserGoal.all.length,
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
