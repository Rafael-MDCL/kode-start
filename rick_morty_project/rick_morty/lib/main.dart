import 'package:flutter/material.dart';
import 'package:rick_morty/widgets/app_bar_widget.dart';
import 'package:rick_morty/themes/app_colors.dart';
import 'package:rick_morty/screens/character_detail_screen.dart';
import 'package:rick_morty/models/characters_info.dart';
import 'package:rick_morty/repositories/characters_repository.dart';
import 'widgets/characters_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty App',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ).copyWith(
          surface: AppColors.background,
          background: AppColors.background,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  final CharactersRepository _repository = CharactersRepository();
  List<Character> characters = [];
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    fetchCharacters();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= 
          _scrollController.position.maxScrollExtent - 200 && 
          !isLoading && hasMore) {
        fetchCharacters();
      }
    });
  }

  Future<void> fetchCharacters() async {
    if (isLoading) return;
    
    setState(() => isLoading = true);
    
    try {
      final result = await _repository.fetchCharacters(page: page);
      setState(() {
        characters.addAll(result.characters);
        page++;
        hasMore = result.hasNext;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: characters.isEmpty && isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.cards,
              ),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: characters.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < characters.length) {
                  final character = characters[index];
                  return CharacterCard(
                    character: character,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CharacterDetailScreen(character: character),
                        ),
                      );
                    },
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.cards,
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }
}
