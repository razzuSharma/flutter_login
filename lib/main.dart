import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _iconAnimation;
  late Animation<double> _iconDouble;
 

  @override
  void initState() {
    super.initState();
    _iconAnimation = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 600),
    );
    _iconDouble = new CurvedAnimation(
      parent: _iconAnimation,
      curve: Curves.bounceOut,
    );

    _iconDouble.addListener(() => {this.setState(() {})});
    _iconAnimation.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.yellow,
      body: new Stack(fit: StackFit.expand, children: <Widget>[
        new Image(
          image: AssetImage("assets/asset.jpeg"),
          fit: BoxFit.cover,
          // color: Colors.black87,
          colorBlendMode: BlendMode.darken,
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new FlutterLogo(
              size: _iconDouble.value * 100,
            ),
            new Form(
              key: _formKey,
              child: Theme(
                data: new ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.teal,
                  inputDecorationTheme: new InputDecorationTheme(
                    labelStyle: new TextStyle(),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(40.0),
                  child: new Column(
                    children: <Widget>[
                      new TextFormField(
                        decoration:
                            new InputDecoration(labelText: "Enter Email"),
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        validator: (labelText) {
                          if (labelText!.isEmpty) return 'Email is required';
                          final RegExp nameExp = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                          if (!nameExp.hasMatch(labelText)) {
                            return 'Please enter only applicable characters';
                          }
                        },
                      ),
                      new TextFormField(
                        decoration:
                            new InputDecoration(labelText: "Enter Password"),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        validator: (labelText) {
                          if (labelText!.isEmpty) return 'Name is required.';
                          final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
                          if (!nameExp.hasMatch(labelText)) {
                            return 'Please enter only alphabetical characters.';
                          }
                        },
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(40),
                      ),
                      new ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Validating and Sending Data......')));
                          }
                        },
                        child: Text('LOGIN'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
