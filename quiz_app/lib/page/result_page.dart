import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/language/language_constants.dart';
import 'package:quiz_app/page/home_page.dart';
import 'package:quiz_app/provider/question_provider.dart';
import 'package:quiz_app/utility.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<bool> answerValue = [];

  String getAnswerValue(int index) {
    final getterProvider = Provider.of<QuestionProvider>(context);

    switch (getterProvider.getAnswerIndex[index]) {
      case 0:
        return translation(context).emptyText;
      case 1:
        return translation(context).correctText;
      case -1:
        return translation(context).wrongText;
      default:
        return translation(context).nullText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final getterProvider = Provider.of<QuestionProvider>(context);
    return Scaffold(
      backgroundColor: Utility.backgroundColor,
      appBar: resultPageAppBar(),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => Utility.listViewSeperatedPadding,
        itemCount: getterProvider.getQuestions.length,
        itemBuilder: (context, index) {
          return ResultWidget(
            answer: getAnswerValue(index),
          );
        },
      ),
    );
  }

  AppBar resultPageAppBar() {
    return AppBar(
      centerTitle: true,
      actions: [
        Center(
          child: IconButton(
            splashRadius: 24,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                  (route) => false);
            },
            icon: const Icon(
              Icons.home_outlined,
            ),
          ),
        )
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(translation(context).resultPageTitle),
    );
  }
}

class ResultWidget extends StatelessWidget {
  const ResultWidget({
    Key? key,
    required this.answer,
  }) : super(key: key);

  final String answer;

  BoxDecoration organiseGradients(BuildContext context) {
    if (translation(context).emptyText == answer) {
      return const BoxDecoration(
        borderRadius: Utility.resultPageContainerRadius,
        gradient: Utility.resultPageContainerEmptyGradient,
      );
    } else if (translation(context).wrongText == answer) {
      return const BoxDecoration(
        borderRadius: Utility.resultPageContainerRadius,
        gradient: Utility.resultPageContainerWrongGradient,
      );
    } else if (translation(context).correctText == answer) {
      return const BoxDecoration(
        borderRadius: Utility.resultPageContainerRadius,
        gradient: Utility.resultPageContainerCorrectGradient,
      );
    } else {
      return const BoxDecoration(
        borderRadius: Utility.resultPageContainerRadius,
        gradient: Utility.resultPageContainerNullGradient,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: organiseGradients(context),
      child: Center(
        child: Padding(
          padding: Utility.resultPageContainerTextPadding,
          child: Text(
            answer,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white, fontSize: 32),
          ),
        ),
      ),
    );
  }
}
