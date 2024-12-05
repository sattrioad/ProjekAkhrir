import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  // Daftar quotes stoikisme
  final List<String> stoicQuotes = [
    '"Kita tidak bisa mengontrol peristiwa, hanya reaksi kita."',
    '"Kebahagiaan bergantung pada perspektif kita, bukan keadaan eksternal."',
    '"Ketahuilah bahwa kesulitan adalah jalan menuju kekuatan."',
    '"Pikiran adalah kekuatan terbesar yang kita miliki."',
    '"Tenang di tengah badai adalah kekuatan sejati."',
    '"Tidak ada yang terjadi pada kita, semuanya terjadi untuk kita."',
    '"Keberanian adalah ketika melawan ketakutan internal kita."',
    '"Hidup singkat, maka gunakan sebaik mungkin."',
    '"Kendali diri adalah kebebasan sejati."',
    '"Apa yang membuat kita menderita? Pikiran kita sendiri."'
  ];

  String _currentQuote = '';

  @override
  void initState() {
    super.initState();
    // Pilih quote acak saat halaman dimuat
    _currentQuote = _getRandomQuote();
  }

  String _getRandomQuote() {
    return stoicQuotes[DateTime.now().millisecond % stoicQuotes.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF212121),
              Color(0xFF424242),
              Color(0xFF616161),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Feedback',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Main Content
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Quote Stoikisme
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentQuote = _getRandomQuote();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  _currentQuote,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '- Filosofi Stoikisme',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Form Feedback
                        TextField(
                          controller: _feedbackController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Berikan Feedback Anda',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white30),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 20),

                        // Tombol Kirim Feedback
                        ElevatedButton(
                          onPressed: () {
                            // Logika kirim feedback
                            if (_feedbackController.text.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Feedback terkirim. Terima kasih!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              _feedbackController.clear();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Feedback tidak boleh kosong'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Kirim Feedback',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
