import 'package:flutter/material.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/shared/core/app_colors.dart';

class OnboardingPageQuestions extends StatefulWidget {
  final OnboardingController controller;

  const OnboardingPageQuestions({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<OnboardingPageQuestions> createState() =>
      _OnboardingPageQuestionsState();
}

class _OnboardingPageQuestionsState extends State<OnboardingPageQuestions> {
  List<String> tags = [
    'Mobile',
    'Web',
    'Data Science',
    'DevOps',
    'UX/UI',
    'Game Dev',
    'QA',
  ];

  List<String> selectedTags = [];

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
                "What is your history?",
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
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 2 / 1,
                  ),
                  itemBuilder: (context, index) {
                    final item = tags[index];
                    final isSelected = selectedTags.contains(tags[index]);

                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedTags.remove(item);
                          } else {
                            selectedTags.add(item);
                          }
                        });

                        widget.controller.config.tags = selectedTags;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? darkColor : Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.fromBorderSide(BorderSide(
                            color:
                                isSelected ? darkColor : Colors.grey.shade200,
                            width: 2,
                          )),
                        ),
                        child: Center(
                          child: Text(
                            item,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: tags.length,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  widget.controller.config.didOnboarding = true;
                  widget.controller.next();
                },
                child: Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}