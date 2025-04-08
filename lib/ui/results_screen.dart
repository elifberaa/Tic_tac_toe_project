import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Rota argümanlarını güvenli bir şekilde al
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final String result = arguments is String ? arguments : "Bilinmeyen Sonuç"; // Argüman yoksa veya yanlış türdeyse

    IconData resultIcon;
    Color resultColor;

    if (result.startsWith("Kazanan")) {
      resultIcon = Icons.emoji_events; // Kupa ikonu
      resultColor = Colors.amber;
    } else if (result == "Berabere!") {
      resultIcon = Icons.handshake; // El sıkışma ikonu
      resultColor = Colors.blueGrey;
    } else {
      resultIcon = Icons.question_mark; // Soru işareti
      resultColor = Colors.grey;
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Oyun Sonucu"),
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.pink[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(resultIcon, size: 100, color: resultColor),
            const SizedBox(height: 30.0),
            Text(
              result,
              style: const TextStyle(
                fontSize: 40.0, // Biraz küçültüldü
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50.0),
            ElevatedButton.icon(
              icon: const Icon(Icons.replay), // Tekrar oynatma ikonu
              label: const Text("Tekrar Oyna"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(
                  fontSize: 20.0, // Biraz küçültüldü
                  fontWeight: FontWeight.bold,
                ),
                shape: const StadiumBorder(), // Yuvarlak kenarlar
                elevation: 5, // Hafif gölge
              ),
              onPressed: () {
                // Oyun ekranına geri dön ve yeni bir oyun başlat
                Navigator.pushReplacementNamed(context, '/game');
              },
            ),
            const SizedBox(height: 60.0), // Increased space before the new buttons
            Text(
              'Bu oyunu beğendiniz mi?',
              style: TextStyle(
                 fontSize: 16.0,
                 color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.favorite_border, color: Colors.redAccent, size: 18),
                  label: const Text("Teşekkür Et"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(color: Colors.redAccent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Teşekkürleriniz Elif Beraa Çığrıkçı\'ya iletildi! ❤️'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
                const SizedBox(width: 20.0),
                OutlinedButton.icon(
                  icon: const Icon(Icons.volunteer_activism, color: Colors.deepPurple, size: 18), // Using a relevant icon
                  label: const Text("Dua Et"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    side: const BorderSide(color: Colors.deepPurple),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Dualarınız Elif Beraa Çığrıkçı\'ya ulaştı! 🙏 Teşekkürler!'),
                        backgroundColor: Colors.lightBlue,
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
} 