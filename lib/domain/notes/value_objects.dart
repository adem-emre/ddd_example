import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:ddd_example/domain/core/value_transformers.dart';
import 'package:ddd_example/domain/core/value_validators.dart';
import 'package:kt_dart/collection.dart';

import '../core/failures.dart';
import '../core/value_objects.dart';

class NoteBody extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 1000;

  const NoteBody._(
    this.value,
  );

  factory NoteBody(String input) {
    return NoteBody._(validateMaxStringLength(input, maxLength)
        .flatMap(validateStringNotEmpty));
  }
}

class TodoName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 30;

  const TodoName._(
    this.value,
  );

  factory TodoName(String input) {
    return TodoName._(validateMaxStringLength(input, maxLength)
        .flatMap(validateStringNotEmpty)
        .flatMap(validateSingleLine));
  }
}

class NoteColor extends ValueObject<Color> {
  static const predefinedColors = [
    Color(0xfffafafa), // canvas
    Color(0xfffa8072), // salmon
    Color(0xfffedc56), // mustard
    Color(0xffd0f0c0), // tea
    Color(0xfffca3b7), // flamingo
    Color(0xff997950), // tortilla
    Color(0xfffffdd0), // cream
  ];

  @override
  final Either<ValueFailure<Color>, Color> value;

  const NoteColor._(
    this.value,
  );

  factory NoteColor(Color input) {
    return NoteColor._(right(makeColorOpaque(input)));
  }
}

class List3<T> extends ValueObject<KtList<T>> {
  @override
  final Either<ValueFailure<KtList<T>>, KtList<T>> value;

  static const maxLength = 3;

  const List3._(
    this.value,
  );

  factory List3(KtList<T> input) {
    return List3._(validateMaxListLength(input, maxLength));
  }

  int get length{
    return value.getOrElse(() => emptyList()).size;
  }

  bool get isFull{
    return length == maxLength;
  }
}
