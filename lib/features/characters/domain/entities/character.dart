import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final List<String> episode;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.episode,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      status,
      species,
      type,
      gender,
      image,
      episode,
    ];
  }
}
