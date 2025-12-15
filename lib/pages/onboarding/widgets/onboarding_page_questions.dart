import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hub_finder/pages/onboarding/onboarding_controller.dart';
import 'package:hub_finder/pages/onboarding/widgets/onboarding_page_indicator.dart';
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
      appBar: AppBar(
        title: Image.asset('asset/images/logo_light.png', height: 32),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.code_rounded, color: Colors.purple, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    "Your Expertise",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 500))
                  .slideY(begin: -0.2, end: 0),
              const SizedBox(height: 8),
              Text(
                "Select technologies you're interested in",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 200),
                  ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  controller: gridController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2.5 / 1,
                  ),
                  itemBuilder: (context, index) {
                    final item = tags[index];
                    final isSelected = selectedTags.contains(tags[index]);

                    return _TechTag(
                      label: item,
                      isSelected: isSelected,
                      index: index,
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          if (isSelected) {
                            selectedTags.remove(item);
                          } else {
                            selectedTags.add(item);
                          }
                        });

                        widget.controller.config.tags = selectedTags;
                      },
                    );
                  },
                  itemCount: tags.length,
                ),
              ),
              const SizedBox(height: 12),
              const OnboardingPageIndicator(currentPage: 7),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _canSubmit ? _submit : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(selectedTags.isNotEmpty
                          ? "Almost Done (${selectedTags.length} selected)"
                          : "Select at least one"),
                      if (selectedTags.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  final String label;
  final bool isSelected;
  final int index;
  final VoidCallback onTap;

  const _TechTag({
    required this.label,
    required this.isSelected,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected ? darkColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? darkColor : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: darkColor.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSelected)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  Flexible(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey.shade700,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: const Duration(milliseconds: 400),
          delay: Duration(milliseconds: 30 * index),
        )
        .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
  }
}
