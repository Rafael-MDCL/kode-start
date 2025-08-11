import 'package:dio/dio.dart';
import '../models/characters_info.dart';
import '../models/episode_info.dart';

class CharactersResult {
  final List<Character> characters;
  final bool hasNext;

  CharactersResult({required this.characters, required this.hasNext});
}

class CharactersRepository {
  static final CharactersRepository _instance = CharactersRepository._internal();
  factory CharactersRepository() => _instance;
  
  late final Dio _dio;

  CharactersRepository._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
  }

  Future<CharactersResult> fetchCharacters({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/character',
        queryParameters: {'page': page},
      );
      
      final List<dynamic> results = response.data['results'];
      final characters = results.map((json) => Character.fromJson(json)).toList();
      final hasNext = response.data['info']['next'] != null;
      
      return CharactersResult(characters: characters, hasNext: hasNext);
    } catch (e) {
      throw Exception('Failed to load characters: $e');
    }
  }

  Future<Episode> fetchEpisode(String episodeUrl) async {
    try {
      final response = await _dio.get(episodeUrl);
      return Episode.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load episode: $e');
    }
  }

  Future<String> fetchFirstEpisodeName(List<String> episodeUrls) async {
    if (episodeUrls.isEmpty) return '';
    
    try {
      final episode = await fetchEpisode(episodeUrls.first);
      return episode.name;
    } catch (e) {
      return '';
    }
  }

  // Busca personagens por nome
  Future<CharactersResult> searchCharacters(String query, {int page = 1}) async {
    try {
      final response = await _dio.get(
        '/character',
        queryParameters: {
          'name': query,
          'page': page,
        },
      );
      
      final List<dynamic> results = response.data['results'];
      final characters = results.map((json) => Character.fromJson(json)).toList();
      final hasNext = response.data['info']['next'] != null;
      
      return CharactersResult(characters: characters, hasNext: hasNext);
    } catch (e) {
      // Se não encontrar resultados, retorna lista vazia
      return CharactersResult(characters: [], hasNext: false);
    }
  }
}
