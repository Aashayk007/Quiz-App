import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:quiz_app/ending_page.dart';

import 'ending_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Paris', 'London', 'Berlin', 'Rome'],
      'correctAnswer': 'Paris',
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Mars', 'Venus', 'Jupiter', 'Mercury'],
      'correctAnswer': 'Mars',
    },
    {
      'question': 'What is the largest organ in the human body?',
      'options': ['Liver', 'Heart', 'Lungs', 'Skin'],
      'correctAnswer': 'Skin',
    },
    // Add more questions here
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  int secondsRemaining = 20;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          timer.cancel();
          goToNextQuestion();
        }
      });
    });
  }

  void checkAnswer(String selectedAnswer) {
    String correctAnswer = questions[currentQuestionIndex]['correctAnswer'];

    if (selectedAnswer == correctAnswer) {
      setState(() {
        score++;
      });
    }

    goToNextQuestion();
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        secondsRemaining = 20;
      });
      startTimer();
    } else {
      timer.cancel();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EndingPage(
            score: score,
            totalQuestions: questions.length,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz App',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Colors.grey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  questions[currentQuestionIndex]['question'],
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Time remaining: $secondsRemaining seconds',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                ...questions[currentQuestionIndex]['options']
                    .map((option) => ElevatedButton(
                          onPressed: () => checkAnswer(option),
                          child: Text(
                            option,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal,
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
