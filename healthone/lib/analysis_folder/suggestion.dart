class Suggestion {
  final String functionOne;
  final String functionTwo;
  final String suggestion;

  Suggestion({
    required this.functionOne,
    required this.functionTwo,
    required this.suggestion,
  });

  factory Suggestion.fromMap(Map suggestionMap){
    return Suggestion(
      functionOne: suggestionMap['functionOne'],
      functionTwo: suggestionMap['functionTwo'],
      suggestion: suggestionMap['suggestion'],
    );
  }
}