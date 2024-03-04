import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Set the key to the scaffold
      appBar: AppBar(
        title: Text('Boards'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Use the scaffold key to open the drawer
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.yellow,
                      ),
                      SizedBox(height: 10),
                      Flexible(
                          child: Column(
                            children: [
                              Text(
                                '@username',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                              Text(
                                'adresse.email@example.coml',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              )
                            ],
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ListTile(
              title: Text('Boards'),
              onTap: () {
                // Implement the action for the first menu option
                Navigator.pop(context);
              },
            ),
            ExpansionTile(title: Text('Workspaces'),
            children: [
              ListTile(
                title: Text('Workspace 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile()
            ],
            )
            // Add other menu options as needed
          ],
        ),
      ),
      body: Center(
        child: Text('Contenu principal de votre application'),
      ),
    );
  }
}