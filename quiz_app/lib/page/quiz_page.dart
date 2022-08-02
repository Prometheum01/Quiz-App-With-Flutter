import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/language/language_constants.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/provider/question_provider.dart';
import 'package:quiz_app/utility.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, required this.questionList}) : super(key: key);

  final List questionList;

  @override
  State<QuizPage> createState() => _QuizPage();
}

class _QuizPage extends State<QuizPage> with TickerProviderStateMixin {
  late AnimationController _animationControllerProgress;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    changeLoading();
    final provider = Provider.of<QuestionProvider>(context, listen: false);
    provider.loadQuestions(widget.questionList);
    provider.reloadEverything();
    _animationControllerProgress = AnimationController(
      vsync: this,
      duration: Utility.questionDuration,
    );

    provider.setAnimationController(_animationControllerProgress, context);
    changeLoading();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final getterQuizProvider = Provider.of<QuestionProvider>(context);
    return AbsorbPointer(
      absorbing: getterQuizProvider.isPause,
      child: Scaffold(
        appBar: quizPageAppBar(context),
        backgroundColor: Utility.backgroundColor,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: Utility.whiteBackgroundMainPadding,
                child: Column(
                  children: [
                    progressBar(getterQuizProvider, context),
                    Expanded(
                      child: Padding(
                        padding: Utility.questionsPadding,
                        child: Container(
                          decoration: Utility.whiteRoundedBackgrounDecoration,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: Utility.questionsPadding,
                            child: Column(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: QuestionWidget(),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: ChoiceWidget(
                                    choice: getterQuizProvider
                                        .getQuestions[getterQuizProvider
                                            .currentQuestionIndex]
                                        .answer1,
                                    myIndex: 0,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: ChoiceWidget(
                                    choice: getterQuizProvider
                                        .getQuestions[getterQuizProvider
                                            .currentQuestionIndex]
                                        .answer2,
                                    myIndex: 1,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: ChoiceWidget(
                                    choice: getterQuizProvider
                                        .getQuestions[getterQuizProvider
                                            .currentQuestionIndex]
                                        .answer3,
                                    myIndex: 2,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: ChoiceWidget(
                                    choice: getterQuizProvider
                                        .getQuestions[getterQuizProvider
                                            .currentQuestionIndex]
                                        .answer4,
                                    myIndex: 3,
                                  ),
                                ),
                              ],
                            ),
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

  Container progressBar(QuestionProvider getterProvider, BuildContext context) {
    return Container(
      width: double.infinity,
      height:
          MediaQuery.of(context).size.height * Utility.prgoressBarHeightFactor,
      decoration: Utility.progressBarMainDecoration,
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedBuilder(
                animation: getterProvider.animationController,
                builder: (context, child) {
                  return Container(
                      width: getterProvider.animationController.value *
                          constraints.maxWidth,
                      decoration: Utility.progressBarDecorationWithGradient);
                },
              );
            },
          ),
          Positioned.fill(
            child: Padding(
              padding: Utility.progressBarRowPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${getterProvider.seconds} ${translation(context).secondText}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.white),
                  ),
                  Utility.timeLapseIcon,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar quizPageAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        TextButton(
          onPressed: () async {
            final provdier =
                Provider.of<QuestionProvider>(context, listen: false);
            await provdier.stopAnimation();
            provdier.changeQuestionField(context);
          },
          child: Text(
            translation(context).skipText,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getterProvider = Provider.of<QuestionProvider>(context);
    return AnimatedOpacity(
      opacity: getterProvider.isPause ? 0 : 1,
      duration: Utility.waitDuration,
      child: Text(
        textAlign: TextAlign.center,
        getterProvider
            .getQuestions[getterProvider.currentQuestionIndex].question,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class ChoiceWidget extends StatelessWidget {
  const ChoiceWidget({
    Key? key,
    required this.choice,
    required this.myIndex,
  }) : super(key: key);

  final String choice;
  final int myIndex;

  @override
  Widget build(BuildContext context) {
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    final questionGetterProvider = Provider.of<QuestionProvider>(
      context,
    );
    return Padding(
      padding: Utility.choiceWidgetMainPadding,
      child: AnimatedOpacity(
        opacity: questionGetterProvider.isPause ? 0 : 1,
        duration: Utility.waitDuration,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: questionGetterProvider.returnBackgrounColor(
                buttonIndex: myIndex,
                questionIndex: questionGetterProvider.currentQuestionIndex,
                isPause: questionGetterProvider.isPause),
            shape: Utility.choiceWidgetShape,
            side: BorderSide(
              color: questionGetterProvider.returnBorderColor(
                  buttonIndex: myIndex,
                  questionIndex: questionGetterProvider.currentQuestionIndex,
                  isPause: questionGetterProvider.isPause),
            ),
          ),
          onPressed: () async {
            questionProvider.clickButtonToSelect(
                myIndex, questionGetterProvider.currentQuestionIndex);
            await questionProvider.stopAnimation();
            // ignore: use_build_context_synchronously
            questionProvider.changeQuestionField(context);
            questionProvider.changeAnswerStatus(0);
          },
          child: Padding(
            padding: Utility.choiceWidgetRowPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  maxLines: 2,
                  choice,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontSize: 16,
                        color: Utility.choiceBorderColor,
                      ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width *
                        Utility.choiceWidgetSmallCircleSizeFactor,
                    height: MediaQuery.of(context).size.width *
                        Utility.choiceWidgetSmallCircleSizeFactor,
                    decoration: Utility.choiceWidgetSmallCricleDecoration)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
