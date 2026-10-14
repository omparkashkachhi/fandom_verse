import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/trivia_data.dart';
import '../../models/content_models.dart';

class TriviaScreen extends StatefulWidget {
  const TriviaScreen({super.key});

  @override
  State<TriviaScreen> createState() => _TriviaScreenState();
}

class _TriviaScreenState extends State<TriviaScreen> {
  int currentIndex = 0;
  String? selectedOption;
  bool isAnswered = false;
  int score = 0;

  TriviaItem get currentQuestion {
    return triviaQuestions[currentIndex];
  }

  void handleOptionSelect(String option) {
    if (isAnswered) return;

    setState(() {
      selectedOption = option;
      isAnswered = true;
      if (option == currentQuestion.answer) {
        score++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentIndex < triviaQuestions.length - 1) {
        currentIndex++;
        selectedOption = null;
        isAnswered = false;
      } else {
        _showScoreDialog();
      }
    });
  }

  void resetQuiz() {
    setState(() {
      currentIndex = 0;
      selectedOption = null;
      isAnswered = false;
      score = 0;
    });
  }

  void _showScoreDialog() {
    final double percentage = (score / triviaQuestions.length) * 100;
    String badgeTitle = 'Fandom Novice';
    IconData badgeIcon = Icons.stars_rounded;
    Color badgeColor = Colors.orangeAccent;

    if (percentage >= 80) {
      badgeTitle = 'Ultimate Fan Master!';
      badgeIcon = Icons.emoji_events;
      badgeColor = Colors.amber;
    } else if (percentage >= 50) {
      badgeTitle = 'Fandom Enthusiast';
      badgeIcon = Icons.military_tech;
      badgeColor = AppColors.cyan;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        title: const Text(
          'Quiz Completed!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(badgeIcon, size: 60, color: badgeColor),
            const SizedBox(height: 10),
            Text(
              badgeTitle,
              style: TextStyle(
                color: badgeColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Your Score: $score / ${triviaQuestions.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${percentage.toStringAsFixed(0)}% Accuracy',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                resetQuiz();
              },
              child: const Text(
                'Play Again',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (triviaQuestions.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title: const Text(
            'Fandom Trivia',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: const Center(
          child: Text(
            'No trivia questions available.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    final question = currentQuestion;
    final progress = (currentIndex + 1) / triviaQuestions.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Fandom Trivia',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            tooltip: 'Restart Quiz',
            onPressed: resetQuiz,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Progress Bar Indicator
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: AppColors.cardBg,
                  color: AppColors.cyan,
                ),
              ),
              const SizedBox(height: 16),

              // SCROLLABLE CONTENT AREA
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // CATEGORY & SCORE ROW
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              question.category,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            'Score: $score',
                            style: const TextStyle(
                              color: AppColors.cyan,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // QUESTION COUNTER
                      Text(
                        'Question ${currentIndex + 1} of ${triviaQuestions.length}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // QUESTION CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: AppColors.cardBg,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.08),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.quiz_rounded,
                              size: 40,
                              color: AppColors.cyan,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              question.question,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                question.difficulty.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.cyan,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // OPTIONS LIST
                      ...question.options.map((option) {
                        Color optionBg = AppColors.cardBg;
                        Color borderColor = Colors.white10;

                        if (isAnswered) {
                          if (option == question.answer) {
                            optionBg = Colors.green.withOpacity(0.25);
                            borderColor = Colors.green;
                          } else if (option == selectedOption) {
                            optionBg = Colors.red.withOpacity(0.25);
                            borderColor = Colors.redAccent;
                          }
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () => handleOptionSelect(option),
                            borderRadius: BorderRadius.circular(16),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: optionBg,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  if (isAnswered &&
                                      option == question.answer)
                                    const Icon(Icons.check_circle_rounded,
                                        color: Colors.green)
                                  else if (isAnswered &&
                                      option == selectedOption)
                                    const Icon(Icons.cancel_rounded,
                                        color: Colors.redAccent),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),

              // BOTTOM NEXT BUTTON
              if (isAnswered)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      currentIndex < triviaQuestions.length - 1
                          ? 'Next Question'
                          : 'See Results',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}