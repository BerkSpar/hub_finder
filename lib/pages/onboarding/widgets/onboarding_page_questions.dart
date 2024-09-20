import 'package:firebase_analytics/firebase_analytics.dart';
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
    "Web Development",
    "DevOps",
    "Data Science",
    "Mobile App Development",
    "Game Development",
    "Artificial Intelligence",
    "Cloud Computing",
    "Cybersecurity",
    "Backend Development",
    "Quality Assurance",
    "Machine Learning",
    "Augmented Reality",
    "UX/UI Design",
    "Internet of Things",
    "Blockchain",
    "Embedded Systems",
    "Virtual Reality",
    "Frontend Development",
    "Web Design",
    "Motion Design",
    "Robotics",
    "Full Stack Development",
    "Graphic Design",
  ];

  final gridController = ScrollController();

  List<String> selectedTags = [];

  bool get _canSubmit => selectedTags.isNotEmpty;

  void _submit() {
    widget.controller.config.didOnboarding = true;

    var params = widget.controller.config.toMap();
    params = params.map((key, value) => MapEntry(key, value.toString()));
    FirebaseAnalytics.instance.logTutorialComplete(parameters: params);

    widget.controller.next();
  }

  @override
  void initState() {
    super.initState();
    _animate();
  }

  void _animate() async {
    await Future.delayed(Durations.short3);

    gridController.animateTo(
      50,
      duration: Durations.long4,
      curve: Curves.easeIn,
    );

    await Future.delayed(Durations.long4);

    gridController.animateTo(
      0,
      duration: Durations.long4,
      curve: Curves.easeOut,
    );
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
                  controller: gridController,
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
