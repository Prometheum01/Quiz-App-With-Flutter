class Question {
  String question;
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  int correctAnswerIndex;

  Question(
      {required this.question,
      required this.answer1,
      required this.answer2,
      required this.answer3,
      required this.answer4,
      required this.correctAnswerIndex});
}

class QuestionMap {
  String quizTitle;
  List<Question> questionList;

  QuestionMap({required this.quizTitle, required this.questionList});

  Map<String, dynamic> getMap() {
    return {
      'quizTitle': quizTitle,
      'questionList': questionList,
    };
  }
}

class QuestionData {
  Map<String, dynamic> quizData;

  QuestionData({required this.quizData});

  List getQuestionList() {
    return quizData['list'];
  }

  getQuizTitle() => quizData['title'];
  getQuizId() => quizData['id'];
}
