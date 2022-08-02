import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/language/language.dart';
import 'package:quiz_app/language/language_constants.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/page/quiz_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiz_app/utility.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = FirebaseFirestore.instance.collection('quizes').doc();

  late FirebaseFirestore firebaseFirestore;

  List<QuestionData> quizList = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    changeLoading();
    firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection('quizes').get().then(
      (value) {
        for (var i in value.docs) {
          QuestionData data = QuestionData(quizData: i.data());
          quizList.add(data);
        }
      },
    );
    changeLoading();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Utility.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              final quizMap = <String, dynamic>{
                'title': 'Game characters 2',
                'list': [
                  {
                    'question': 'Sam Fisher',
                    '0': 'Splinter Cell',
                    '1': 'Counter Strike ',
                    '2': 'Witcher 3',
                    '3': 'Resident Evil',
                    'answer': 0,
                  },
                  {
                    'question': 'Arthur Morgan',
                    '0': 'Mortal Kombat X',
                    '1': 'GTA Vice City',
                    '2': 'Read Dead Redemption 2',
                    '3': 'Last of Us',
                    'answer': 2,
                  },
                  {
                    'question': 'Jill Valentine',
                    '0': 'Mafia 3',
                    '1': 'Ghostrunner',
                    '2': 'Marvels Spider-Man',
                    '3': 'Resident Evil',
                    'answer': 3,
                  },
                  {
                    'question': 'Ezio Auditore',
                    '0': 'Serious Sam',
                    '1': 'Assassins Creed',
                    '2': 'Halo',
                    '3': 'Hitma 2',
                    'answer': 1,
                  },
                  {
                    'question': 'Agent 47',
                    '0': 'GTA IV',
                    '1': 'Splinter Cell',
                    '2': 'Last of Us Part 1',
                    '3': 'Hitman 3',
                    'answer': 3,
                  },
                  {
                    'question': 'Ryu Hayabusa',
                    '0': 'Ninja Gaiden',
                    '1': 'Street Fighter',
                    '2': 'Life is Strange',
                    '3': 'Mortal Kombat',
                    'answer': 0,
                  },
                  {
                    'question': 'Captain Price',
                    '0': 'Call of Duty: Modern Warfare',
                    '1': 'Assassins Creed: Black Flag',
                    '2': 'Sea of Thieves',
                    '3': 'Mass Effect 3',
                    'answer': 0,
                  },
                ],
                'id': db.id,
              };

              db.set(quizMap).then(
                    (value) => print('added'),
                  );
            },
            icon: Icon(Icons.add),
          ),
          elevation: 0,
          title: Text(translation(context).homePageWelcome),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            Center(
              child: DropdownButton(
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Text(e.name),
                        ),
                      )
                      .toList(),
                  onChanged: (Language? language) async {
                    Locale locale =
                        await setLocale(language?.countryCode ?? 'en');
                    // ignore: use_build_context_synchronously
                    MyApp.setLocale(context, locale);
                  }),
            )
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemCount: quizList.length,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: QuizContainer(
                    data: quizList[index],
                  ),
                ),
              ));
  }
}

class QuizContainer extends StatelessWidget {
  const QuizContainer({
    Key? key,
    required this.data,
  }) : super(key: key);

  final QuestionData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => QuizPage(
                questionList: data.getQuestionList(),
              ),
            ),
            (route) => false);
      },
      child: Ink(
        decoration: BoxDecoration(
          gradient: Utility.progressBarGradient,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.getQuizTitle(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.getQuestionList().length.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
