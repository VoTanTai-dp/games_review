import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'games_grid.dart';
import 'games_manager.dart';

class GamesOverviewScreen extends StatefulWidget {
  const GamesOverviewScreen({super.key});

  @override
  State<GamesOverviewScreen> createState() => _GamesOverviewScreenState();
}

class _GamesOverviewScreenState extends State<GamesOverviewScreen> {
  String _selectedGameType = 'All'; // Mặc định hiển thị tất cả game
  late Future<void> _fetchGames;

  @override
  void initState() {
    super.initState();
    _fetchGames = context.read<GamesManager>().fetchGames();
  }

  void _filterGames(String newType) {
    setState(() {
      _selectedGameType = newType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games Overview',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: GameTypeFilter(onFilterChanged: _filterGames),
          ),
          FutureBuilder(
            future: _fetchGames,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: GamesGrid(selectedType: _selectedGameType),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}

class GameTypeFilter extends StatefulWidget {
  final Function(String) onFilterChanged;

  const GameTypeFilter({super.key, required this.onFilterChanged});

  @override
  State<GameTypeFilter> createState() => _GameTypeFilterState();
}

class _GameTypeFilterState extends State<GameTypeFilter> {
  String _selectedValue = 'All'; // Giá trị mặc định
  final List<String> _options = [
    'All',
    'Action',
    'Adventure',
    'Casual',
    'Indie',
    'RPG',
    'Simulation',
    'Sports',
    'Strategy'
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Color(0xFF31353F), // Màu nền
          borderRadius: BorderRadius.circular(20), // Bo góc
          border: Border.all(color: Colors.blueAccent, width: 1), // Màu viền
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 5, offset: Offset(0, 3))
          ], // Đổ bóng
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Kích thước vừa với nội dung
          children: [
            Text(
              "Game Type:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8), // Khoảng cách giữa chữ và dropdown
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedValue,
                icon: Icon(Icons.arrow_drop_down,
                    color: Colors.blue), // Icon màu xanh
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedValue = newValue;
                    });
                    widget.onFilterChanged(newValue);
                  }
                },
                items: _options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option, style: TextStyle(fontSize: 16)),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
