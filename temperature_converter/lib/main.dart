import 'package:flutter/material.dart';

void main() {
  runApp(TempConverter());
}

class TempConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Temperature Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//choosed category
String _unitChoosed = 'Celcius';
String _celcius = '0';
String _reaumur = '0';
String _fahrenheit = '0';
String _kelvin = '0';
String _rankine = '0';
bool _numberInputChecker = true;

List<DropdownMenuItem<String>> _getCategoryItem() {
  return <String>['Celcius', 'Fahrenheit', 'Reaumur', 'Kelvin', 'Rankine']
      .map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
        value: value,
        child: Center(
            child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 32),
        )));
  }).toList();
}

_convertTemperature(double temperature) {
  temperature = temperature == null ? 0 : temperature;
  if (_unitChoosed == 'Celcius') {
    _celcius = temperature == null ? '0' : temperature.toStringAsFixed(2);
    _kelvin = (temperature + 273.15).toStringAsFixed(2);
    _reaumur = (temperature * 0.8).toStringAsFixed(2);
    _fahrenheit = ((temperature * 1.8) + 32).toStringAsFixed(2);
    _rankine = (((temperature * 1.8) + 32) + 459.67).toStringAsFixed(2);
  }
  if (_unitChoosed == 'Fahrenheit') {
    _fahrenheit = temperature == null ? '0' : temperature.toStringAsFixed(2);
    _celcius = ((temperature - 32) / 1.8).toStringAsFixed(2);
    _kelvin = ((temperature + 459.67) / 1.8).toStringAsFixed(2);
    _rankine = (temperature + 459.67).toStringAsFixed(2);
    _reaumur = ((temperature - 32) / 2.25).toStringAsFixed(2);
  }
  if (_unitChoosed == 'Reaumur') {
    _reaumur = temperature == null ? '0' : temperature.toStringAsFixed(2);
    _celcius = (temperature * 1.25).toStringAsFixed(2);
    _kelvin = ((temperature * 1.25) + 273).toStringAsFixed(2);
    _fahrenheit = ((temperature * 2.25) + 32).toStringAsFixed(2);
    _rankine = (((temperature * 2.25) + 32) + 456.67).toStringAsFixed(2);
  }
  if (_unitChoosed == 'Kelvin') {
    _kelvin = temperature == null ? '0' : temperature.toStringAsFixed(2);
    _celcius = (temperature - 273.15).toStringAsFixed(2);
    _fahrenheit = ((temperature * 1.8) + 459.67).toStringAsFixed(2);
    _rankine = (temperature * 1.8).toStringAsFixed(2);
    _reaumur = ((temperature - 273.15) * 0.8).toStringAsFixed(2);
  }
  if (_unitChoosed == 'Rankine') {
    _rankine = temperature == null ? '0' : temperature.toStringAsFixed(2);
    _celcius = ((temperature - 32 - 459.67) / 1.8).toStringAsFixed(2);
    _kelvin = (temperature / 1.8).toStringAsFixed(2);
    _reaumur = ((temperature - 32 - 459.67) / 2.25).toStringAsFixed(2);
    _fahrenheit = (temperature - 459.67).toStringAsFixed(2);
  }
  debugPrint('temperature input $temperature');
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController inputController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: TextField(
                controller: inputController,
                keyboardType: TextInputType.number,
                style: Theme.of(context).textTheme.headline4,
                decoration: InputDecoration(
                  labelText: 'Temperature Value',
                  errorText: _numberInputChecker
                      ? null
                      : 'Temperature Value in Number',
                ),
                onChanged: (String value) {
                  final v = double.tryParse(value);
                  debugPrint('parsed value = $v');
                  if (v == null) {
                    setState(() => _numberInputChecker = false);
                  } else {
                    setState(() => _numberInputChecker = true);
                  }
                },
                onSubmitted:
                    _convertTemperature(double.tryParse(inputController.text)),
              ),
            ),
            DropdownButton<String>(
              isExpanded: true,
              icon: Icon(
                Icons.arrow_downward,
                color: Colors.black,
              ),
              iconSize: 32,
              value: _unitChoosed,
              items: _getCategoryItem(),
              onChanged: (String newValue) {
                setState(() {
                  _unitChoosed = newValue;
                  _convertTemperature(0);
                  inputController.clear();
                  _celcius = '0';
                  _reaumur = '0';
                  _fahrenheit = '0';
                  _kelvin = '0';
                  _rankine = '0';
                  debugPrint('categoryChoosed: $_unitChoosed');
                });
              },
            ),
            Text(
              'Celcius: $_celcius',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Fahrenheit: $_fahrenheit',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Reaumur: $_reaumur',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Kelvin: $_kelvin',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Rankine: $_rankine',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
