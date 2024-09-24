// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:e_tmsc_app/shared/enums/question_type.dart';
import 'package:flutter/material.dart';

class TestModel {
  final int testId;
  final int employeeTestId;
  final String? title;
  final String? description;
  final String? fullname;
  final num? scoreChoice;
  final num? scoreEssay;
  final int? totalMarks;
  final int? timeLimit;
  final int? pause;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? expired;
  final List<QuestionModel> questions;
  bool status;
  TestModel({
    required this.testId,
    required this.employeeTestId,
    this.title,
    this.description,
    this.scoreChoice,
    this.scoreEssay,
    this.totalMarks,
    this.timeLimit,
    this.startTime,
    this.endTime,
    this.fullname,
    this.createdAt,
    this.updatedAt,
    this.expired,
    this.pause,
    required this.questions,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'testId': testId,
      'employeeTestId': employeeTestId,
      'title': title,
      'description': description,
      'scoreChoice': scoreChoice,
      'scoreEssay': scoreEssay,
      'totalMarks': totalMarks,
      'timeLimit': timeLimit,
      'startTime': startTime?.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      testId: map['testId'] as int,
      employeeTestId: map['employeeTestId'] as int,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      scoreChoice:
          map['scoreChoice'] != null ? map['scoreChoice'] as num : null,
      scoreEssay: map['scoreEssay'] != null ? map['scoreEssay'] as num : null,
      totalMarks: map['totalMarks'] != null ? map['totalMarks'] as int : null,
      timeLimit: map['timeLimit'] != null ? map['timeLimit'] as int : null,
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int)
          : null,
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int)
          : null,
      pause: map['pause'],
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      expired: map['expired'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expired'] as int)
          : null,
      questions: map['questions'] != null
          ? List<QuestionModel>.from(
              map['questions'].map((x) => QuestionModel.fromMap(x)),
            )
          : [],
      status: map['status'] != null ? map['status'] as bool : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TestModel.fromJson(String source) =>
      TestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  isExpired() {
    if (expired == null) {
      return true;
    } else {
      if (expired!.isBefore(DateTime.now())) {
        return true;
      }
    }
    return status;
  }
}

class AnswerModel {
  final int answerId;
  final String answerText;
  final bool? isCorrect;
  bool isSelected;

  AnswerModel({
    required this.answerId,
    required this.answerText,
    this.isCorrect,
    required this.isSelected,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'answerId': answerId,
      'answerText': answerText,
      'isCorrect': isCorrect,
    };
  }

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      answerId: map['answerId'] as int,
      answerText: map['answerText'] as String,
      isCorrect: map['isCorrect'] != null
          ? (map['isCorrect'] == 0 ? false : true)
          : null,
      isSelected: false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerModel.fromJson(String source) =>
      AnswerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class QuestionModel {
  final int questionId;
  final String questionText;
  final int marks;
  final QuestionType type;
  final String? url;
  final TextEditingController inputAnswer;
  final List<AnswerModel> answers;
  QuestionModel({
    required this.questionId,
    required this.questionText,
    required this.marks,
    required this.type,
    required this.inputAnswer,
    this.url,
    required this.answers,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questionId': questionId,
      'questionText': questionText,
      'marks': marks,
      'type': type.parseId(),
      'answers': answers.map((x) => x.toMap()).toList(),
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      questionId: map['questionId'] as int,
      questionText: map['questionText'] as String,
      marks: map['marks'] as int,
      type: QuestionType.toEnum(map['type']),
      url: map['url'],
      answers: List<AnswerModel>.from(
        map['answers'].map<AnswerModel>((x) => AnswerModel.fromMap(x)),
      ),
      inputAnswer: TextEditingController(),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
