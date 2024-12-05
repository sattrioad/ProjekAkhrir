import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = '';
  int _userAge = 0;
  String _userInstagram = '';
  bool _isDarkMode = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    var userBox = Hive.box('userBox');
    setState(() {
      _userName = userBox.get('username', defaultValue: 'John Doe');
      _userAge = userBox.get('age', defaultValue: 25);
      _userInstagram = userBox.get('instagram', defaultValue: '@username');
      _isDarkMode = userBox.get('isDarkMode', defaultValue: true);
    });
  }

  void _showEditProfileModal() {
    final TextEditingController nameController =
        TextEditingController(text: _userName);

    final TextEditingController ageController =
        TextEditingController(text: _userAge.toString());
    final TextEditingController instagramController =
        TextEditingController(text: _userInstagram);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _isDarkMode ? Color(0xFF424242) : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Profil',
                style: TextStyle(
                  color: _isDarkMode ? Colors.white : Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  labelStyle: TextStyle(
                      color: _isDarkMode ? Colors.white70 : Colors.black87),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: _isDarkMode ? Colors.white30 : Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: _isDarkMode ? Colors.white : Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style:
                    TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
              ),
              SizedBox(height: 20),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Umur',
                  labelStyle: TextStyle(
                      color: _isDarkMode ? Colors.white70 : Colors.black87),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: _isDarkMode ? Colors.white30 : Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: _isDarkMode ? Colors.white : Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style:
                    TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
              ),
              SizedBox(height: 20),
              TextField(
                controller: instagramController,
                decoration: InputDecoration(
                  labelText: 'Instagram',
                  labelStyle: TextStyle(
                      color: _isDarkMode ? Colors.white70 : Colors.black87),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: _isDarkMode ? Colors.white30 : Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: _isDarkMode ? Colors.white : Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style:
                    TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  var userBox = Hive.box('userBox');
                  userBox.put('username', nameController.text);

                  userBox.put('age', int.tryParse(ageController.text) ?? 0);
                  userBox.put('instagram', instagramController.text);

                  setState(() {
                    _userName = nameController.text;

                    _userAge = int.tryParse(ageController.text) ?? 0;
                    _userInstagram = instagramController.text;
                  });

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: _isDarkMode ? Colors.white : Colors.black,
                  backgroundColor: _isDarkMode
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black.withOpacity(0.1),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Simpan', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSettingsModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isDarkMode ? Color(0xFF424242) : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pengaturan',
              style: TextStyle(
                color: _isDarkMode ? Colors.white : Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text(
                'Mode Gelap',
                style:
                    TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
              ),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                  var userBox = Hive.box('userBox');
                  userBox.put('isDarkMode', value);
                });
                Navigator.pop(context);
              },
              activeColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _isDarkMode
                ? [
                    Color(0xFF212121),
                    Color(0xFF424242),
                    Color(0xFF616161),
                  ]
                : [
                    Colors.white,
                    Colors.grey[100]!,
                    Colors.grey[200]!,
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: (_isDarkMode ? Colors.white : Colors.black)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: (_isDarkMode ? Colors.white : Colors.black)
                          .withOpacity(0.2),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpg'),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  (_isDarkMode ? Colors.white : Colors.black)
                                      .withOpacity(0.7),
                              child: IconButton(
                                icon: Icon(Icons.edit,
                                    size: 20,
                                    color: _isDarkMode
                                        ? Colors.black
                                        : Colors.white),
                                onPressed: _showEditProfileModal,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          _userName,
                          style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$_userAge tahun',
                          style: TextStyle(
                            color:
                                _isDarkMode ? Colors.white70 : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _userInstagram,
                          style: TextStyle(
                            color:
                                _isDarkMode ? Colors.white70 : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 30),
                        _buildProfileSection(
                          icon: Icons.person_outline,
                          title: 'Edit Profil',
                          onTap: _showEditProfileModal,
                        ),
                        _buildProfileSection(
                          icon: Icons.settings_outlined,
                          title: 'Pengaturan',
                          onTap: _showSettingsModal,
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                _isDarkMode ? Colors.white : Colors.black,
                            backgroundColor:
                                (_isDarkMode ? Colors.white : Colors.black)
                                    .withOpacity(0.2),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Logout', style: TextStyle(fontSize: 16)),
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

  Widget _buildProfileSection({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: (_isDarkMode ? Colors.white : Colors.black).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon,
            color: _isDarkMode ? Colors.white : Colors.black, size: 24),
        title: Text(
          title,
          style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black, fontSize: 16),
        ),
        trailing: Icon(Icons.arrow_forward_ios,
            color: _isDarkMode ? Colors.white70 : Colors.black54, size: 20),
        onTap: onTap,
      ),
    );
  }
}
