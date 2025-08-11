import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../models/characters_info.dart';
import '../repositories/characters_repository.dart';
import '../dtos/characters_main_info.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  final CharactersRepository _repository = CharactersRepository();
  CharacterMainInfo? characterMainInfo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCharacterMainInfo();
  }

  Future<void> _loadCharacterMainInfo() async {
    try {
      final firstEpisodeName = await _repository.fetchFirstEpisodeName(
        widget.character.episodeUrls,
      );

      final mainInfo = CharacterMainInfo.fromCharacter(
        widget.character,
        firstEpisodeName,
      );

      setState(() {
        characterMainInfo = mainInfo;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          widget.character.name,
          style: TextStyle(
            color: AppColors.text,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.cards,
              ),
            )
          : characterMainInfo == null
              ? Center(
                  child: Text(
                    'Error loading character details',
                    style: TextStyle(
                      color: AppColors.text,
                      fontFamily: 'Lato',
                    ),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.cards,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              child: Image.network(
                                characterMainInfo!.image,
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    characterMainInfo!.name.toUpperCase(),
                                    style: TextStyle(
                                      color: AppColors.text,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: _getStatusTextColor(characterMainInfo!.status),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.text,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        characterMainInfo!.status,
                                        style: TextStyle(
                                          color: AppColors.text,
                                          fontSize: 16,
                                          fontFamily: 'Lato',
                                        ),
                                      ),
                                      Text(
                                        ' - ',
                                        style: TextStyle(
                                          color: AppColors.text,
                                          fontSize: 16,
                                          fontFamily: 'Lato',
                                        ),
                                      ),
                                      Text(
                                        characterMainInfo!.species,
                                        style: TextStyle(
                                          color: AppColors.text,
                                          fontSize: 16,
                                          fontFamily: 'Lato',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  
                                  _buildInfoRow('Gender:', characterMainInfo!.gender),
                                  const SizedBox(height: 8),
                                  
                                  _buildInfoRow('Origin:', characterMainInfo!.origin),
                                  const SizedBox(height: 8),
                                  
                                  _buildInfoRow('Last Known Location:', characterMainInfo!.lastLocation),
                                  const SizedBox(height: 8),
                                  
                                  _buildInfoRow('First Appearance:', characterMainInfo!.firstEpisode),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isStatus = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Lato',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: isStatus ? _getStatusTextColor(value) : AppColors.text,
              fontSize: 16,
              fontFamily: 'Lato',
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return AppColors.statusAlive;
      case 'dead':
        return AppColors.statusDead;
      case 'unknown':
        return AppColors.statusUnknown;
      default:
        return AppColors.text;
    }
  }


}
