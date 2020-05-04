import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'camerascreen/camera_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstRoute(),
    );
  }
}

class FirstRoute extends StatefulWidget {
  @override
  FirstRouteState createState() => FirstRouteState();
}

class FirstRouteState extends State<FirstRoute> {
  static const platform = const MethodChannel('flutter.sugoi.channel');
  String _output = 'No output';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Click on Icon to open camera",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.teal[900],
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    color: Colors.white,
                    icon: Icon(Icons.camera, size: 40),
                    tooltip: "take a photo",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraScreen(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  onPressed: _commNative,
                  color: Color(0xFF607D8B),
                  child: Text(
                    'Communicate with Native',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(_output),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _commNative() async {
    String output;
    try {
      final String result = await platform.invokeMethod('sayHello');
      output = result;
    } on PlatformException catch (e) {
      output = "Failed to get message back '${e.message}'.";
    }

    setState(() {
      _output = output;
    });
  }
}
