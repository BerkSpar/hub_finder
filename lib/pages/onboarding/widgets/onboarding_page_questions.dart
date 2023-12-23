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
    "Mobile App Development",
    "Web Development",
    "Data Science",
    "DevOps",
    "UX/UI Design",
    "Game Development",
    "Quality Assurance",
    "Machine Learning",
    "Cybersecurity",
    "Frontend Development",
    "Backend Development",
    "Cloud Computing",
    "Internet of Things",
    "Blockchain",
    "Augmented Reality",
    "Virtual Reality",
    "Full Stack Development",
    "Embedded Systems",
    "Artificial Intelligence",
    "Robotics",
    "Graphic Design",
    "User Interface Design",
    "User Experience Design",
    "Motion Design",
    "Web Design",
  ];

  List<String> selectedTags = [];

  bool get _canSubmit => selectedTags.isNotEmpty;

  void _submit() {
    widget.controller.config.didOnboarding = true;
    widget.controller.next();
  }

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
                "Discover your expertise",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Let us know your preferred technologies and workspaces for a tailored experience",
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
                            textAlign: TextAlign.center,
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
                onPressed: _canSubmit ? _submit : null,
                child: Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
