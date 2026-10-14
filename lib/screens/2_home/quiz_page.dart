import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  int score = 0;
  int? selectedAnswer;
  bool isSubmitted = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Which movie is known for the quote "I am Iron Man"?',
      'options': [
        'Avengers: Endgame',
        'Iron Man',
        'Thor',
        'Black Panther',
      ],
      'answer': 1,
    },
    {
      'question': 'Which anime character is known for using a Death Note?',
      'options': [
        'Naruto',
        'Luffy',
        'Light Yagami',
        'Gojo',
      ],
      'answer': 2,
    },
    {
      'question': 'Which instrument has black and white keys?',
      'options': [
        'Guitar',
        'Piano',
        'Drums',
        'Violin',
      ],
      'answer': 1,
    },
    {
      'question': 'Which game is known for building with blocks?',
      'options': [
        'Minecraft',
        'FIFA',
        'PUBG',
        'Valorant',
      ],
      'answer': 0,
    },
    {
      'question': 'What do we call a group of fans of something?',
      'options': [
        'Community',
        'Audience',
        'Fandom',
        'Team',
      ],
      'answer': 2,
    },
  ];

  void selectAnswer(int index) {
    if (isSubmitted) return; // Prevent selection after submission

    setState(() {
      selectedAnswer = index;
      isSubmitted = true;
      if (selectedAnswer == questions[currentQuestion]['answer']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (selectedAnswer == null) return;

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
        isSubmitted = false;
      });
    } else {
      setState(() {
        currentQuestion = questions.length; // Triggers Result Screen
      });
    }
  }

  void restartQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      selectedAnswer = null;
      isSubmitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool quizFinished = currentQuestion >= questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFF070A1C),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fandom_background.png'),
            fit: BoxFit.cover,
            onError: null,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.65),
          ),
          child: SafeArea(
            child: quizFinished
                ? _buildResultScreen()
                : _buildQuizScreen(),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizScreen() {
    final question = questions[currentQuestion];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOP BAR
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xFF111637),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF7054D7),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              const Text(
                'Fandom Quiz',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // QUIZ ICON
          Center(
            child: Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFB54CFF),
                    Color(0xFF5865F2),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withOpacity(0.45),
                    blurRadius: 25,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: const Icon(
                Icons.quiz_rounded,
                color: Colors.white,
                size: 38,
              ),
            ),
          ),

          const SizedBox(height: 18),

          const Center(
            child: Text(
              'Test Your Fandom!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Center(
            child: Text(
              'Question ${currentQuestion + 1} of ${questions.length}',
              style: const TextStyle(
                color: Color(0xFFB8B9D4),
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(height: 18),

          // PROGRESS BAR
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: (currentQuestion + 1) / questions.length,
              minHeight: 8,
              backgroundColor: const Color(0xFF25294A),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF9C5CFF),
              ),
            ),
          ),

          const SizedBox(height: 25),

          // QUESTION CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFF10152F).withOpacity(0.92),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFF7655D9),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7655D9).withOpacity(0.18),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Text(
              question['question'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 22),

          // OPTIONS
          ...List.generate(
            question['options'].length,
                (index) {
              return _answerButton(
                index,
                question['options'][index],
                question['answer'],
              );
            },
          ),

          const SizedBox(height: 15),

          // NEXT BUTTON
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: selectedAnswer == null ? null : nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                disabledBackgroundColor: const Color(0xFF292C4A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                currentQuestion == questions.length - 1
                    ? 'Finish Quiz'
                    : 'Next Question',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _answerButton(int index, String text, int correctAnswer) {
    final bool isSelected = selectedAnswer == index;
    final bool isCorrect = index == correctAnswer;

    Color borderColor = const Color(0xFF353963);
    Color bgColor = const Color(0xFF111632).withOpacity(0.92);
    Widget? trailingIcon;

    if (isSubmitted) {
      if (isCorrect) {
        borderColor = const Color(0xFF10B981); // Green
        bgColor = const Color(0xFF10B981).withOpacity(0.20);
        trailingIcon = const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981));
      } else if (isSelected && !isCorrect) {
        borderColor = const Color(0xFFEF4444); // Red
        bgColor = const Color(0xFFEF4444).withOpacity(0.20);
        trailingIcon = const Icon(Icons.cancel_rounded, color: Color(0xFFEF4444));
      }
    } else if (isSelected) {
      borderColor = const Color(0xFFB45CFF);
      bgColor = const Color(0xFF754CDE).withOpacity(0.30);
      trailingIcon = const Icon(Icons.check_circle_rounded, color: Color(0xFFB45CFF));
    }

    return GestureDetector(
      onTap: () => selectAnswer(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
            width: (isSelected || (isSubmitted && isCorrect)) ? 1.8 : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: const Color(0xFF9C5CFF).withOpacity(0.25),
              blurRadius: 15,
            ),
          ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSubmitted
                    ? (isCorrect
                    ? const Color(0xFF10B981)
                    : (isSelected ? const Color(0xFFEF4444) : const Color(0xFF292D4D)))
                    : (isSelected ? const Color(0xFF9C5CFF) : const Color(0xFF292D4D)),
              ),
              child: Text(
                String.fromCharCode(65 + index),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            if (trailingIcon != null) trailingIcon,
          ],
        ),
      ),
    );
  }

  Widget _buildResultScreen() {
    final double percentage = (score / questions.length) * 100;
    String badgeTitle = 'Casual Fan';
    Color badgeColor = const Color(0xFF36D9FF);

    if (percentage == 100) {
      badgeTitle = 'Fandom Legend!';
      badgeColor = const Color(0xFFFFD700);
    } else if (percentage >= 60) {
      badgeTitle = 'Super Fan!';
      badgeColor = const Color(0xFFFF4FD8);
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    badgeColor,
                    const Color(0xFF7655FF),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: badgeColor.withOpacity(0.45),
                    blurRadius: 35,
                  ),
                ],
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                color: Colors.white,
                size: 58,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              badgeTitle,
              style: TextStyle(
                color: badgeColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Your fandom knowledge has been calculated!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFB8B9D4),
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 28),

            // SCORE CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF111632).withOpacity(0.95),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFF7655D9),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'YOUR SCORE',
                    style: TextStyle(
                      color: Color(0xFFB8B9D4),
                      fontSize: 13,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$score / ${questions.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _resultStat('Accuracy', '${percentage.toInt()}%', const Color(0xFFB54CFF)),
                      Container(height: 30, width: 1, color: Colors.white24),
                      _resultStat('Correct', '$score', const Color(0xFF10B981)),
                      Container(height: 30, width: 1, color: Colors.white24),
                      _resultStat('Wrong', '${questions.length - score}', const Color(0xFFEF4444)),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: restartQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  'Play Again',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Back to Dashboard',
                style: TextStyle(
                  color: Color(0xFFB45CFF),
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}