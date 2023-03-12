// import 'dart:convert';

// class ApiResponse<T extends Object> {
//   final ApiResponseInfo info;
//   final List<T> results;

//   ApiResponse({
//     required this.info,
//     required this.results,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'info': info.toMap(),
//       'results': results.map((x) => x.toMap()).toList(),
//     };
//   }

//   factory ApiResponse.fromMap(Map<String, dynamic> map) {
//     return ApiResponse<T>(
//       info: ApiResponseInfo.fromMap(map['info']),
//       results: List<T>.from(map['results']?.map((x) => T.fromMap(x))),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ApiResponse.fromJson(String source) => ApiResponse.fromMap(json.decode(source));
// }

// class ApiResponseInfo {
//   final int count;
//   final int pages;
//   final String next;
//   final String prev;

//   ApiResponseInfo({
//     required this.count,
//     required this.pages,
//     required this.next,
//     required this.prev,
//   });

//   factory ApiResponseInfo.fromMap(Map<String, dynamic> map) {
//     return ApiResponseInfo(
//       count: map['count']?.toInt() ?? 0,
//       pages: map['pages']?.toInt() ?? 0,
//       next: map['next'] ?? '',
//       prev: map['prev'] ?? '',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'count': count,
//       'pages': pages,
//       'next': next,
//       'prev': prev,
//     };
//   }

//   String toJson() => json.encode(toMap());

//   factory ApiResponseInfo.fromJson(String source) => ApiResponseInfo.fromMap(json.decode(source));
// }
