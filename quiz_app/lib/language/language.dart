class Language {
  final int id;
  final String name;
  final String countryCode;

  Language(this.id, this.name, this.countryCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, 'English', 'en'),
      Language(2, 'Türkçe', 'tr'),
    ];
  }
}
