import 'package:flutter/material.dart';
import 'dart:async';
import '../themes/app_colors.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;
  final Function() onClear;

  const SearchBarWidget({
    super.key,
    required this.onSearch,
    required this.onClear,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
      
      // Debounce: Espera 500ms após o usuário parar de digitar
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        if (_controller.text.trim().isNotEmpty) {
          widget.onSearch(_controller.text.trim());
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSubmitted(String value) {
    if (value.trim().isNotEmpty) {
      _debounce?.cancel(); // Cancela o debounce se o usuário pressionar Enter
      widget.onSearch(value.trim());
    }
  }

  void _onClear() {
    _controller.clear();
    _debounce?.cancel();
    widget.onClear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cards,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _controller,
        onSubmitted: _onSubmitted,
        style: TextStyle(
          color: AppColors.text,
          fontFamily: 'Lato',
        ),
        decoration: InputDecoration(
          hintText: 'Search characters...',
          hintStyle: TextStyle(
            color: AppColors.text.withOpacity(0.6),
            fontFamily: 'Lato',
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.text,
          ),
          suffixIcon: _hasText
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: AppColors.text,
                  ),
                  onPressed: _onClear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
