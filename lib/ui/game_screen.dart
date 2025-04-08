import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ui/theme/color.dart';
import 'package:tic_tac_toe/utils/game_logic.dart';
import 'package:url_launcher/url_launcher.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool gameOver = false;
  String lastValue = "X";
  int turn = 0;
  List<int> scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
  Game game = Game();

  final String player1 = "Oyuncu 1";
  final String player2 = "Oyuncu 2";

  final List<Map<String, dynamic>> _drawerLinks = [
    {'title': 'Yeni Oyun', 'icon': Icons.play_arrow, 'action': 'new_game'},
    {'title': 'Skorlar', 'icon': Icons.score, 'action': 'scores'},
    {
      'title': 'GitHub Repo',
      'icon': Icons.code,
      'url': 'https://github.com/elifberaa/xoxProjesi-main',
      'action': 'url',
    },
  ];

  final String ownerName = "Elif Beraa Çığrıkçı";
  final String githubProfileUrl = "https://github.com/elifberaa";

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    game.board = Game.initGameBoard();
    gameOver = false;
    lastValue = "X";
    turn = 0;
    scoreBoard = List.filled(8, 0);
  }

  void _resetGame() {
    setState(() {
      _initializeGame();
    });
  }

  void _handleTap(int index) {
    if (gameOver || game.board![index] != "") return;

    setState(() {
      game.board![index] = lastValue;
      turn++;
      gameOver = game.winnerCheck(lastValue, index, scoreBoard, 3);

      String gameResult;
      if (gameOver) {
        gameResult = "Kazanan: $lastValue";
        _navigateToResults(gameResult);
      } else if (turn == 9) {
        gameResult = "Berabere!";
        gameOver = true;
        _navigateToResults(gameResult);
      } else {
        lastValue = (lastValue == "X") ? "O" : "X";
      }
    });
  }

  void _navigateToResults(String gameResult) {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/results', arguments: gameResult);
      }
    });
  }

  Future<String> _getLogoImage() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return 'https://api.dicebear.com/7.x/bottts/png?seed=xoxo&size=128';
    } catch (e) {
      print("Logo yüklenirken hata: $e");
      return 'https://via.placeholder.com/128.png?text=Logo';
    }
  }

  Future<void> _launchURL(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('URL açılamıyor: $urlString')),
         );
      }
    } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('URL açılırken hata: $e')),
       );
    }
  }

  void _handleDrawerAction(String action, String? url) {
    Navigator.pop(context);
    if (action == 'new_game') {
      _resetGame();
    } else if (action == 'scores') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Skorlar özelliği yakında eklenecek!')),
      );
    } else if (action == 'url' && url != null) {
      _launchURL(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("XOX Oyunu"),
        centerTitle: true,
        backgroundColor: MainColor.primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      drawer: _buildDrawer(),
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTurnIndicator(),
            const SizedBox(height: 30),
            _buildGameBoard(boardWidth),
            const SizedBox(height: 50.0),
            _buildResetButton(boardWidth),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTurnIndicator() {
    return Text(
      gameOver ? (turn == 9 ? "Oyun Bitti: Berabere!" : "Oyun Bitti: Kazanan $lastValue") : "Sırada: $lastValue",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 36,
        fontWeight: FontWeight.w600,
        shadows: [
           Shadow(
             blurRadius: 4.0,
             color: Colors.black38,
             offset: Offset(2.0, 2.0),
           ),
         ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildGameBoard(double boardWidth) {
    return SizedBox(
      width: boardWidth,
      height: boardWidth,
      child: GridView.builder(
          itemCount: Game.boardLength,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Game.boardLength ~/ 3,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, index) {
            return _buildGridTile(index);
          }),
    );
  }

  Widget _buildGridTile(int index) {
    return InkWell(
      onTap: () => _handleTap(index),
      child: Container(
        decoration: BoxDecoration(
           color: MainColor.secondaryColor.withOpacity(0.9),
           borderRadius: BorderRadius.circular(12.0),
           border: Border.all(width: 2, color: Colors.white54),
           boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset(1.0, 1.0),
              )
           ]
        ),
        child: Center(
          child: Text(
            game.board![index],
            style: TextStyle(
              color: game.board![index] == "X"
                  ? MainColor.accentColor
                  : Colors.white,
              fontSize: 60.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetButton(double boardWidth) {
     return SizedBox(
            width: boardWidth * 0.65,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: MainColor.accentColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(25),
                   side: const BorderSide(width: 1, color: Colors.white70)
                ),
                textStyle: const TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 20.0,
                ),
                elevation: 3,
              ),
              icon: const Icon(Icons.refresh, size: 24),
              onPressed: _resetGame,
              label: const Text("YENİDEN BAŞLA"),
            ),
          );
  }

  Widget _buildDrawer() {
     return Drawer(
        backgroundColor: Colors.grey[100],
        child: Column(
          children: [
            _buildDrawerHeader(),
            _buildOwnerInfo(),
            const Divider(height: 1, thickness: 1),
            _buildPlayerInfo(),
            const Divider(height: 1, thickness: 1),
            _buildDrawerLinksList(),
            const Spacer(),
            Padding(
               padding: const EdgeInsets.all(16.0),
               child: Text(
                 'Versiyon: 1.0.0',
                 style: TextStyle(color: Colors.grey[600], fontSize: 12),
               ),
             ),
          ],
        ),
      );
  }

  Widget _buildDrawerHeader() {
     return UserAccountsDrawerHeader(
              accountName: const Text(
                "XOX Oyunu",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
              ),
              accountEmail: const Text(
                "Flutter ile Geliştirildi",
                 style: TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "XOX",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: MainColor.primaryColor),
                ),
              ),
              decoration: BoxDecoration(
                 color: MainColor.primaryColor,
              ),
             otherAccountsPictures: [
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white54),
                  onPressed: () {
                     Navigator.pop(context);
                     ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ayarlar yakında!')),
                      );
                  },
                  tooltip: 'Ayarlar',
                )
             ],
            );
  }

  Widget _buildOwnerInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Proje Sahibi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.person_outline, color: MainColor.primaryColor, size: 20),
              const SizedBox(width: 12),
              Text(
                 ownerName,
                 style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () => _launchURL(githubProfileUrl),
            child: Row(
              children: [
                Icon(Icons.link, color: MainColor.primaryColor, size: 20),
                const SizedBox(width: 12),
                const Text(
                  "GitHub Profili",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.open_in_new, color: Colors.blue, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerInfo() {
      return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("Oyuncular", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[700])),
                   const SizedBox(height: 8),
                   Padding(
                     padding: const EdgeInsets.only(left: 8.0),
                     child: Text("Oyuncu 1 (X): ${game.board?.where((e) => e == 'X').length ?? 0} hamle"),
                   ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Oyuncu 2 (O): ${game.board?.where((e) => e == 'O').length ?? 0} hamle"),
                  ),
                ],
              ),
            );
  }

  Widget _buildDrawerLinksList() {
     return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                shrinkWrap: true,
                itemCount: _drawerLinks.length,
                itemBuilder: (context, index) {
                  final item = _drawerLinks[index];
                  return ListTile(
                    leading: Icon(item['icon'], color: MainColor.primaryColor),
                    title: Text(item['title'], style: const TextStyle(fontSize: 15)),
                    onTap: () => _handleDrawerAction(item['action'], item['url']),
                    dense: true,
                  );
                },
              );
  }
}
