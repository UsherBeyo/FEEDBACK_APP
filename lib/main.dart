import 'package:flutter/material.dart';

void main() {
  runApp(const FeedbackApp());
}

class FeedbackApp extends StatelessWidget {
  const FeedbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Feedback System',
      home: const FeedbackPage(),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final feedbackController = TextEditingController();

  int rating = 0;
  String category = 'App Experience';

  final categories = [
    'App Experience',
    'Design',
    'Performance',
    'Bug Report',
    'Suggestion',
  ];

  final blueColor = const Color(0xFF2F6BFF);
  final yellowColor = const Color(0xFFFFB800);
  final backgroundColor = const Color(0xFFF4F6FB);
  final lightBlueColor = const Color(0xFFEAF0FF);

  void submitFeedback() {
    if (rating == 0) {
      showMessage('Please select a star rating.');
      return;
    }

    if (formKey.currentState!.validate()) {
      showSuccessDialog();
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: lightBlueColor,
                child: Icon(
                  Icons.check_rounded,
                  size: 42,
                  color: blueColor,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Feedback Sent',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Thank you for sharing your thoughts. Your feedback helps us improve the app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    clearForm();
                  },
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    feedbackController.clear();

    setState(() {
      rating = 0;
      category = 'App Experience';
    });
  }

  Widget starRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        starButton(1),
        starButton(2),
        starButton(3),
        starButton(4),
        starButton(5),
      ],
    );
  }

  Widget starButton(int number) {
    return IconButton(
      onPressed: () {
        setState(() {
          rating = number;
        });
      },
      icon: Icon(
        number <= rating ? Icons.star_rounded : Icons.star_border_rounded,
        size: 38,
        color: number <= rating ? yellowColor : Colors.grey.shade300,
      ),
    );
  }

  Widget categoryChoices() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        categoryButton('App Experience'),
        categoryButton('Design'),
        categoryButton('Performance'),
        categoryButton('Bug Report'),
        categoryButton('Suggestion'),
      ],
    );
  }

  Widget categoryButton(String text) {
    bool selected = category == text;

    return ChoiceChip(
      label: Text(text),
      selected: selected,
      selectedColor: lightBlueColor,
      backgroundColor: Colors.white,
      side: BorderSide(
        color: selected ? blueColor : Colors.grey.shade300,
      ),
      labelStyle: TextStyle(
        color: selected ? blueColor : Colors.black87,
        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onSelected: (value) {
        setState(() {
          category = text;
        });
      },
    );
  }

  InputDecoration inputStyle(String label, String hint, IconData icon) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: const Color(0xFFF7F8FA),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: blueColor,
          width: 1.4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
    );
  }

  Widget titleText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),

              child: Column(
                children: [
                  Container(
                    height: 74,
                    width: 74,
                    decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: blueColor.withOpacity(0.25),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.chat_bubble_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'How was your experience?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Share your feedback so we can make things better.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 28),

                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 30,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),

                    child: Form(
                      key: formKey,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleText('Your Rating'),

                          const SizedBox(height: 8),

                          starRating(),

                          Center(
                            child: Text(
                              rating == 0
                                  ? 'Tap a star to rate'
                                  : '$rating out of 5 stars',
                              style: TextStyle(
                                color: rating == 0
                                    ? Colors.black45
                                    : blueColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 26),

                          titleText('Feedback Type'),

                          const SizedBox(height: 12),

                          categoryChoices(),

                          const SizedBox(height: 24),

                          TextFormField(
                            controller: nameController,
                            decoration: inputStyle(
                              'Name',
                              'Optional',
                              Icons.person_outline_rounded,
                            ),
                          ),

                          const SizedBox(height: 14),

                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: inputStyle(
                              'Email',
                              'Optional',
                              Icons.email_outlined,
                            ),
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                if (!value.contains('@')) {
                                  return 'Please enter a valid email.';
                                }
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 14),

                          TextFormField(
                            controller: feedbackController,
                            maxLines: 5,
                            decoration: inputStyle(
                              'Your Feedback',
                              'Tell us what you think...',
                              Icons.edit_note_rounded,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please write your feedback.';
                              }

                              if (value.trim().length < 10) {
                                return 'Feedback must be at least 10 characters.';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 24),

                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(0, 54),
                                    side: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: clearForm,
                                  child: const Text(
                                    'Clear',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                flex: 2,
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    minimumSize: const Size(0, 54),
                                    backgroundColor: blueColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: submitFeedback,
                                  child: const Text(
                                    'Submit Feedback',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'No database connected yet. Feedback is currently front-end only.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}