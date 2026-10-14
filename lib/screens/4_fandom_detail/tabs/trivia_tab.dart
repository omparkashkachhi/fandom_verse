import 'package:flutter/material.dart';

class TriviaTab extends StatefulWidget {
  const TriviaTab({super.key});

  @override
  State<TriviaTab> createState() => _TriviaTabState();
}

class _TriviaTabState extends State<TriviaTab> {
  // Theme Color Palette
  static const Color darkCardBg = Color(0xFF0D0D2B);
  static const Color neonPink = Color(0xFFEC4899);
  static const Color neonCyan = Color(0xFF06B6D4);
  static const Color neonPurple = Color(0xFF8B5CF6);

  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;
  bool _isAnswered = false;

  final List<Map<String, dynamic>> _triviaQuestions = const [
    {
      'question': 'What is the main source of power for the Mystic Warriors?',
      'options': [
        'Solar Crystals',
        'Dark Energy Core',
        'Celestial Mana',
        'Void Artifacts'
      ],
      'correctIndex': 1,
      'explanation':
      'Dark Energy Core powers all shadow techniques and high-level magic spells in this universe.'
    },
    {
      'question': 'Who was the first leader of the Eclipse Order?',
      'options': ['Aron Shadowhart', 'Lord Malakor', 'Zephyr', 'Valerius'],
      'correctIndex': 0,
      'explanation':
      'Aron Shadowhart founded the order to protect ancient magical realms from void corruption.'
    },
    {
      'question': 'Which realm is known as the graveyard of forgotten spells?',
      'options': [
        'Nova Sector 7',
        'Void Realm',
        'Astral Sanctuary',
        'Ethereal Spire'
      ],
      'correctIndex': 1,
      'explanation':
      'The Void Realm holds lost artifacts and corrupted ancient spells.'
    },
  ];

  void _handleOptionSelect(int index) {
    if (_isAnswered) return;

    setState(() {
      _selectedAnswerIndex = index;
      _isAnswered = true;
      if (index == _triviaQuestions[_currentQuestionIndex]['correctIndex']) {
        _score += 10;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _triviaQuestions.length - 1) {
        _currentQuestionIndex++;
        _selectedAnswerIndex = null;
        _isAnswered = false;
      } else {
        _showQuizCompletedDialog();
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _selectedAnswerIndex = null;
      _isAnswered = false;
    });
  }

  void _showQuizCompletedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: darkCardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(color: neonCyan, width: 1),
          ),
          title: const Text(
            'Quiz Completed! 🏆',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.stars_rounded,
                color: Color(0xFFF59E0B),
                size: 60,
              ),
              const SizedBox(height: 12),
              Text(
                'You Earned $_score Fan Points!',
                style: const TextStyle(
                  color: neonCyan,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Great job testing your knowledge on this fandom universe.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: neonPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _resetQuiz();
                },
                child: const Text(
                  'Play Again',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _triviaQuestions[_currentQuestionIndex];
    final int correctIndex = currentQuestion['correctIndex'];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= HEADER SCORE BOARD =================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: darkCardBg,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: neonPurple.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${_currentQuestionIndex + 1} of ${_triviaQuestions.length}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.55),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Fandom Trivia Challenge',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: neonCyan.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: neonCyan.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: Color(0xFFF59E0B), size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '$_score PTS',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ================= QUESTION CARD =================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  neonPurple.withOpacity(0.2),
                  darkCardBg,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: Text(
              currentQuestion['question'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 18),

          // ================= OPTIONS LIST =================
          ...List.generate(
            (currentQuestion['options'] as List).length,
                (index) {
              final optionText = currentQuestion['options'][index];

              Color borderColor = Colors.white12;
              Color bgColor = darkCardBg;
              IconData? statusIcon;

              if (_isAnswered) {
                if (index == correctIndex) {
                  borderColor = const Color(0xFF10B981);
                  bgColor = const Color(0xFF10B981).withOpacity(0.15);
                  statusIcon = Icons.check_circle_rounded;
                } else if (index == _selectedAnswerIndex) {
                  borderColor = neonPink;
                  bgColor = neonPink.withOpacity(0.15);
                  statusIcon = Icons.cancel_rounded;
                }
              }

              return GestureDetector(
                onTap: () => _handleOptionSelect(index),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor, width: 1.2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          optionText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (statusIcon != null)
                        Icon(
                          statusIcon,
                          color: index == correctIndex
                              ? const Color(0xFF10B981)
                              : neonPink,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),

          // ================= EXPLANATION & NEXT BUTTON =================
          if (_isAnswered) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: neonCyan.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: neonCyan.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded,
                      color: neonCyan, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      currentQuestion['explanation'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: neonCyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _nextQuestion,
                child: Text(
                  _currentQuestionIndex == _triviaQuestions.length - 1
                      ? 'Finish Quiz 🎉'
                      : 'Next Question ➔',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}