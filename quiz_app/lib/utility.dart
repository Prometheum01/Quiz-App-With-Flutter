import 'package:flutter/material.dart';
import 'package:quiz_app/model/question_model.dart';

class Utility {
  static List<QuestionMap> quizList = [
    QuestionMap(
      quizTitle: 'Question First',
      questionList: [
        Question(
            question: 'Carrots and Apples',
            answer1: 'Havuçlar ve elmalar',
            answer2: 'Karpuzlar ve kavunlar',
            answer3: 'Biberler ve elmalar',
            answer4: 'Karpuzlar ve erikler',
            correctAnswerIndex: 0),
        Question(
            question: 'What is your name?',
            answer1: 'Nerelisin?',
            answer2: 'Mesleğin ne?',
            answer3: 'Adın ne?',
            answer4: 'Kaç yaşındasın?',
            correctAnswerIndex: 2),
        Question(
            question: 'Computer',
            answer1: 'Satranç',
            answer2: 'Bilgisayar',
            answer3: 'Telefon',
            answer4: 'Bisiklet',
            correctAnswerIndex: 1),
        Question(
            question: 'Chess',
            answer1: 'Bilgisayar',
            answer2: 'Araba',
            answer3: 'Telefon',
            answer4: 'Satranç',
            correctAnswerIndex: 3),
      ],
    ),
    QuestionMap(
      quizTitle: 'Question Second',
      questionList: [
        Question(
            question: 'Glasses and Pencil',
            answer1: 'Gözlükler ve kalem',
            answer2: 'Karpuzlar ve kavunlar',
            answer3: 'Ayılar ve armutlar',
            answer4: 'Karpuzlar ve erikler',
            correctAnswerIndex: 0),
        Question(
            question: 'What is your name?',
            answer1: '2Nerelisin?',
            answer2: '2Mesleğin ne?',
            answer3: '2Adın ne?',
            answer4: '2Kaç yaşındasın?',
            correctAnswerIndex: 2),
        Question(
            question: 'Computer',
            answer1: '2Satranç',
            answer2: '2Bilgisayar',
            answer3: '2Telefon',
            answer4: '2Bisiklet',
            correctAnswerIndex: 1),
        Question(
            question: 'Chess',
            answer1: '2Bilgisayar',
            answer2: '2Araba',
            answer3: '2Telefon',
            answer4: '2Satranç',
            correctAnswerIndex: 3),
      ],
    ),
    QuestionMap(
      quizTitle: 'Question Third',
      questionList: [
        Question(
            question: 'Book and Eraser',
            answer1: 'Kitap ve silgi',
            answer2: 'Karpuzlar ve kavunlar',
            answer3: 'Biberler ve elmalar',
            answer4: 'Karpuzlar ve erikler',
            correctAnswerIndex: 0),
        Question(
            question: 'What is your name?',
            answer1: '3Nerelisin?',
            answer2: '3Mesleğin ne?',
            answer3: '3Adın ne?',
            answer4: '3Kaç yaşındasın?',
            correctAnswerIndex: 2),
        Question(
            question: 'Computer',
            answer1: '3Satranç',
            answer2: '3Bilgisayar',
            answer3: '3Telefon',
            answer4: '3Bisiklet',
            correctAnswerIndex: 1),
        Question(
            question: 'Chess',
            answer1: '3Bilgisayar',
            answer2: '3Araba',
            answer3: '3Telefon',
            answer4: '3Satranç',
            correctAnswerIndex: 3),
      ],
    ),
  ];

  //Texts-----------------------------------------------------------------------------------------------
  static const title = 'RESULT PAGE';
  static const emptyText = 'Empty';
  static const correctText = 'Correct';
  static const wrongText = 'Wrong';
  static const nullText = 'Null';
  static const skipText = 'Skip';
  static const secondText = 'sec';
  //Texts-----------------------------------------------------------------------------------------------

  //Sizes-----------------------------------------------------------------------------------------------
  static const prgoressBarHeightFactor = 0.05;
  static const choiceWidgetSmallCircleSizeFactor = 0.1;
  //Sizes-----------------------------------------------------------------------------------------------

  //Colors-----------------------------------------------------------------------------------------------
  static const backgroundColor = Color(0xFF252C4A);
  static const progressBarBackgroundColor = Color(0xFF3F4768);
  static const progressBarBorderColor = Color(0xFF3F4768);
  static const choiceBorderColor = Color(0xFFC1C1C1);
  static const correctColor = Colors.green;
  static const wrongColor = Colors.red;
  static const emptytColor = Colors.blue;
  static const correctBacgroundColorWithoutOpacity = Color(0xFF6AC259);
  static const wrongBacgroundColorWithoutOpacity = Color(0xFFE92E30);
  static const emptyBacgroundColorWithoutOpacity = Color(0xFF59A8C2);
  //Colors-----------------------------------------------------------------------------------------------

  //Gradients-----------------------------------------------------------------------------------------------
  static const progressBarGradient = LinearGradient(colors: [
    Color(0xFF46A0AE),
    Color(0xFF00FFCB),
  ]);
  static const resultPageContainerCorrectGradient = LinearGradient(colors: [
    Color.fromARGB(255, 138, 235, 129),
    Color.fromARGB(255, 16, 177, 78),
  ]);
  static const resultPageContainerWrongGradient = LinearGradient(colors: [
    Color(0xFFEA384D),
    Color(0xFFD31027),
  ]);
  static const resultPageContainerEmptyGradient = LinearGradient(colors: [
    Color(0xFF859398),
    Color(0xFF283048),
  ]);
  static const resultPageContainerNullGradient = LinearGradient(colors: [
    Color(0xFFFFFFFF),
    Color(0xFFFFEFBA),
  ]);

  //Gradients-----------------------------------------------------------------------------------------------

  //Durations-----------------------------------------------------------------------------------------------
  static const questionDuration = Duration(seconds: 15);
  static const questionDurationSeconds = 15;
  static const waitDuration = Duration(seconds: 1);
  //Durations-----------------------------------------------------------------------------------------------

  //Paddings-----------------------------------------------------------------------------------------------
  static const listViewSeperatedPadding = Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
  );
  static const resultPageContainerTextPadding =
      EdgeInsets.symmetric(vertical: 18);
  static const choiceWidgetMainPadding = EdgeInsets.symmetric(vertical: 8);
  static const choiceWidgetRowPadding = EdgeInsets.all(8.0);
  static const progressBarRowPadding = EdgeInsets.symmetric(horizontal: 8);
  static const questionsPadding = EdgeInsets.all(16.0);
  static const whiteBackgroundMainPadding =
      EdgeInsets.symmetric(horizontal: 12, vertical: 16);
  //Paddings-----------------------------------------------------------------------------------------------

  //Decorations-----------------------------------------------------------------------------------------------
  static BoxDecoration choiceWidgetSmallCricleDecoration = BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: Utility.choiceBorderColor),
  );
  static BoxDecoration progressBarMainDecoration = BoxDecoration(
    border: Border.all(
      width: 3,
      color: progressBarBackgroundColor,
    ),
    borderRadius: BorderRadius.circular(50),
  );
  static BoxDecoration progressBarDecorationWithGradient = BoxDecoration(
    gradient: progressBarGradient,
    borderRadius: BorderRadius.circular(50),
  );
  static const whiteRoundedBackgrounDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(16),
    ),
  );
  static const choiceWidgetShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(16),
    ),
  );
  //Decorations-----------------------------------------------------------------------------------------------

  //Radius-----------------------------------------------------------------------------------------------
  static const resultPageContainerRadius = BorderRadius.all(
    Radius.circular(16),
  );
  //Radius-----------------------------------------------------------------------------------------------

  //Icons-----------------------------------------------------------------------------------------------
  static const timeLapseIcon = Icon(
    Icons.timelapse_outlined,
    color: Colors.white,
  );
  //Icons-----------------------------------------------------------------------------------------------

}
