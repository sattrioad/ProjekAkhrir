import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrencyConversionScreen extends StatefulWidget {
  @override
  _CurrencyConversionScreenState createState() =>
      _CurrencyConversionScreenState();
}

class _CurrencyConversionScreenState extends State<CurrencyConversionScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _convertedAmount = "";
  String _fromCurrency = "IDR";
  String _toCurrency = "USD";

  // Currency exchange rates (as of hypothetical date)
  final Map<String, double> exchangeRates = {
    "IDR": 15000,
    "USD": 1,
    "EUR": 0.93,
    "JPY": 141.1,
    "GBP": 0.77,
    "AUD": 1.55,
    "CAD": 1.37,
    "CHF": 0.93,
    "INR": 83.5,
    "MYR": 4.6,
  };

  double convertCurrency(double amount) {
    return amount / exchangeRates[_fromCurrency]! * exchangeRates[_toCurrency]!;
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
                  'Currency Converter',
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
                      // Amount Input
                      TextField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          labelText: 'Enter Amount',
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
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}'))
                        ],
                      ),
                      SizedBox(height: 20),

                      // From Currency Dropdown
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
                                  value: _fromCurrency,
                                  dropdownColor: Color(0xFF424242),
                                  style: TextStyle(color: Colors.white),
                                  onChanged: (value) {
                                    setState(() {
                                      _fromCurrency = value!;
                                    });
                                  },
                                  items: exchangeRates.keys
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
                                  value: _toCurrency,
                                  dropdownColor: Color(0xFF424242),
                                  style: TextStyle(color: Colors.white),
                                  onChanged: (value) {
                                    setState(() {
                                      _toCurrency = value!;
                                    });
                                  },
                                  items: exchangeRates.keys
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
                          final amount =
                              double.tryParse(_amountController.text);
                          if (amount != null) {
                            setState(() {
                              // Limit to 2 decimal places
                              _convertedAmount =
                                  '${convertCurrency(amount).toStringAsFixed(2)} $_toCurrency';
                            });
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
                        child: Text('Convert', style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(height: 20),

                      // Converted Amount
                      Text(
                        _convertedAmount.isNotEmpty
                            ? 'Converted Amount: $_convertedAmount'
                            : 'Enter amount to convert.',
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
