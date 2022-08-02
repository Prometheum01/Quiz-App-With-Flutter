import 'package:flutter/material.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/page/result_page.dart';
import 'package:quiz_app/utility.dart';

class QuestionProvider extends ChangeNotifier {
  List<Question> _questionList = [];

  // ignore: prefer_final_fields
  List<int> _answerList = [];

  int selectedIndex = -1;

  int currentQuestionIndex = 0;
  // -1 : wrong, 0 : empty, 1 : correct
  int answerStatus = 0;

  late AnimationController animationController;

  // ignore: unused_field
  late Animation _progressAnimation;

  int seconds = Utility.questionDurationSeconds;

  bool isPause = false;

  bool isFinished = false;

  void loadQuestions(List list) {
    _questionList = [];
    for (var i in list) {
      Question question = Question(
          question: i['question'],
          answer1: i['0'],
          answer2: i['1'],
          answer3: i['2'],
          answer4: i['3'],
          correctAnswerIndex: i['answer']);
      _questionList.add(question);
    }
  }

  void reloadEverything() {
    isFinished = false;
    isPause = false;
    selectedIndex = -1;
    _answerList = [];
    answerStatus = 0;
    currentQuestionIndex = 0;
  }

  void setAnimationController(
      AnimationController controller, BuildContext context) {
    animationController = controller;

    _progressAnimation = Tween(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        seconds = Utility.questionDurationSeconds -
            (animationController.value * Utility.questionDurationSeconds)
                .toInt();
        if (isFinished) {
          animationController.stop();
        }
        notifyListeners();
      })
      ..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          changePause();
          await Future.delayed(
            Utility.waitDuration,
          );
          // ignore: use_build_context_synchronously
          changeQuestionField(context);
          if (!isFinished) {
            startAnimation();
          } else {
            // ignore: use_build_context_synchronously
            goResultPage(context);
          }
        }
      });
    animationController.forward();
  }

  void goResultPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const ResultPage(),
        ),
        (route) => false);
  }

  void startAnimation() {
    animationController.value = 0;
    animationController.forward();
    changePause();
  }

  Future<void> stopAnimation() async {
    animationController.stop();
    changePause();
    await Future.delayed(
      Utility.waitDuration,
    );
    startAnimation();
  }

  void changePause() {
    isPause = !isPause;
    notifyListeners();
  }

  List<Question> get getQuestions => _questionList;
  List<int> get getAnswerIndex => _answerList;

  Color returnBorderColor(
      {required int buttonIndex,
      required int questionIndex,
      required bool isPause}) {
    int correctIndex = _questionList[questionIndex].correctAnswerIndex;

    if (answerStatus == 0) {
      if (isPause) {
        if (correctIndex == buttonIndex) {
          return Utility.emptytColor;
        }
      }
      return Utility.choiceBorderColor;
    } else if (answerStatus == -1) {
      if (selectedIndex == buttonIndex) {
        return Utility.wrongColor;
      } else if (buttonIndex == correctIndex) {
        return Utility.correctColor;
      } else {
        return Utility.choiceBorderColor;
      }
    } else if (answerStatus == 1) {
      if (selectedIndex == buttonIndex) {
        return Utility.correctColor;
      } else {
        return Utility.choiceBorderColor;
      }
    } else {
      return Utility.choiceBorderColor;
    }
  }

  Color returnBackgrounColor(
      {required int buttonIndex,
      required int questionIndex,
      required bool isPause}) {
    int correctIndex = _questionList[questionIndex].correctAnswerIndex;
    if (answerStatus == 0 && isPause && (buttonIndex == correctIndex)) {
      return Utility.emptyBacgroundColorWithoutOpacity.withOpacity(0.1);
    } else if (answerStatus == -1) {
      if (selectedIndex == buttonIndex) {
        return Utility.wrongBacgroundColorWithoutOpacity.withOpacity(0.1);
      } else if (buttonIndex == correctIndex) {
        return Utility.correctBacgroundColorWithoutOpacity.withOpacity(0.1);
      }
    } else if (answerStatus == 1) {
      if (selectedIndex == buttonIndex) {
        return Utility.correctBacgroundColorWithoutOpacity.withOpacity(0.1);
      }
    }
    return Colors.white;
  }

  clickButtonToSelect(
    int buttonIndex,
    int questionIndex,
  ) {
    selectedIndex = buttonIndex;

    if (selectedIndex == _questionList[questionIndex].correctAnswerIndex) {
      answerStatus = 1;
    } else {
      answerStatus = -1;
    }
    notifyListeners();
  }

  void changeQuestionField(BuildContext context) {
    _answerList.add(answerStatus);
    if (currentQuestionIndex < _questionList.length - 1) {
      currentQuestionIndex = currentQuestionIndex + 1;
      notifyListeners();
    } else {
      isFinished = true;
      goResultPage(context);
      notifyListeners();
    }
  }

  void changeAnswerStatus(int x) {
    answerStatus = x;
    notifyListeners();
  }
}
