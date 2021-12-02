import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';


@JsonSerializable()
class Option {
  String value;
  String detail;
  bool correct;

  Option({
    this.value = '',
    this.detail = '',
    this.correct = false
  });

  // Factory
  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
  // toJson method
  Map<String, dynamic> toJson() => _$OptionToJson(this);
}


@JsonSerializable()
class Question {
  String text;
  List<Option> options;

  Question({
    this.text = '',
    this.options = const []
  });

  // Factory
  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
  // toJson method
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}


@JsonSerializable()
class Quiz {
  String id;
  String title;
  String description;
  String video;
  String topic;
  List<Question> questions;

  Quiz({
    this.id = '',
    this.title = '',
    this.description = '',
    this.video = '',
    this.topic = '',
    this.questions = const []
  });

  // Factory
  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  // toJson method
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}


@JsonSerializable()
class Topic {
  final String id;
  final String title;
  final String description;
  final String img;
  final List<Quiz> quizzes;

  // Constructor - with default values instead of null (null safety)
  Topic({
    this.id = '',
    this.title = '',
    this.description = '',
    this.img = 'default.png',
    this.quizzes = const []
  });

  // Factory
  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  // toJson method
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}


@JsonSerializable()
class Report {
  String uid;
  int total;
  Map topics;

  Report({
    this.uid = '',
    this.total = 0,
    this.topics = const {}
  });

  // Factory
  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
  // toJson method
  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
