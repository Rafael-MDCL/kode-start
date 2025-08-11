import '../models/characters_info.dart';

class CharacterMainInfo {
  final String name;
  final String image;
  final String species;
  final String gender;
  final String status;
  final String origin;
  final String lastLocation;
  final String firstEpisode;

  CharacterMainInfo({
    required this.name,
    required this.image,
    required this.species,
    required this.gender,
    required this.status,
    required this.origin,
    required this.lastLocation,
    required this.firstEpisode,
  });

  // Factory para criar a partir de Character e nome do primeiro episódio
  factory CharacterMainInfo.fromCharacter(
    Character character, 
    String firstEpisodeName,
  ) {
    return CharacterMainInfo(
      name: character.name,
      image: character.image,
      species: character.species,
      gender: character.gender,
      status: character.status,
      origin: character.origin.name,
      lastLocation: character.lastLocation.name,
      firstEpisode: firstEpisodeName,
    );
  }
}