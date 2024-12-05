import 'package:flutter/material.dart';

class TimeConversionScreen extends StatefulWidget {
  @override
  _TimeConversionScreenState createState() => _TimeConversionScreenState();
}

class _TimeConversionScreenState extends State<TimeConversionScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _fromZone = "WIB";
  String _toZone = "WIT";
  String _convertedTime = "";

  Map<String, int> timezoneOffsets = {
    "WIB": 7,
    "WIT": 9,
    "WITA": 8,
    "London": 0
  };

  TimeOfDay convertTime(TimeOfDay time, String fromZone, String toZone) {
    int offset = timezoneOffsets[fromZone]! - timezoneOffsets[toZone]!;
    int newHour = (time.hour + offset) % 24;

    return TimeOfDay(hour: newHour, minute: time.minute);
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
                  'Time Converter',
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Time Picker
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: _selectedTime,
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.dark().copyWith(
                                  colorScheme: ColorScheme.dark(
                                    primary: Colors.white,
                                    surface: Color(0xFF424242),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (time != null) {
                            setState(() {
                              _selectedTime = time;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.access_time, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                _selectedTime.format(context),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // From and To Zone Dropdowns
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _fromZone,
                                  dropdownColor: Color(0xFF424242),
                                  style: TextStyle(color: Colors.white),
                                  onChanged: (value) {
                                    setState(() {
                                      _fromZone = value!;
                                    });
                                  },
                                  items: timezoneOffsets.keys
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.swap_horiz, color: Colors.white),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _toZone,
                                  dropdownColor: Color(0xFF424242),
                                  style: TextStyle(color: Colors.white),
                                  onChanged: (value) {
                                    setState(() {
                                      _toZone = value!;
                                    });
                                  },
                                  items: timezoneOffsets.keys
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Convert Button
                      ElevatedButton(
                        onPressed: () {
                          final converted =
                              convertTime(_selectedTime, _fromZone, _toZone);
                          setState(() {
                            _convertedTime =
                                'Converted Time: ${converted.format(context)} $_toZone';
                          });
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
                        child: Text('Convert Time',
                            style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(height: 20),

                      // Converted Time
                      Text(
                        _convertedTime.isNotEmpty
                            ? _convertedTime
                            : 'Select a time to convert.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
