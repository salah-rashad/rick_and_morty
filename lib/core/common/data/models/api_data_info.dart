import 'dart:convert';

import 'package:equatable/equatable.dart';

class ApiData<T> extends Equatable {
  final ApiDataInfo info;
  final List<T> results;
  
  const ApiData({
    required this.info,
    required this.results,
  });

  @override
  List<Object> get props => [info, results];
}

class ApiDataInfo {
  final int count;
  final int pages;
  final String next;
  final String prev;

  ApiDataInfo({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'pages': pages,
      'next': next,
      'prev': prev,
    };
  }

  factory ApiDataInfo.fromMap(Map<String, dynamic> map) {
    return ApiDataInfo(
      count: map['count']?.toInt() ?? 0,
      pages: map['pages']?.toInt() ?? 0,
      next: map['next'] ?? '',
      prev: map['prev'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiDataInfo.fromJson(String source) =>
      ApiDataInfo.fromMap(json.decode(source));
}
