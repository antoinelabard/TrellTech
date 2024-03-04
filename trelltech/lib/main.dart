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
  String selectedWorkspace = 'Boards'; // Default category

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(selectedWorkspace),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
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
                // Implement the action for the Boards menu option
                setState(() {
                  selectedWorkspace = 'Boards';
                });
                Navigator.pop(context);
              },
            ),
            ExpansionTile(
              title: Text('Workspaces'),
              children: [
                ListTile(
                  leading: Icon(Icons.groups),
                  title: Text('Workspace 1'),
                  onTap: () {
                    // Implement the action for Workspace 1
                    setState(() {
                      selectedWorkspace = 'Workspace 1';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.groups),
                  title: Text('Workspace 2'),
                  onTap: () {
                    // Implement the action for Workspace 2
                    setState(() {
                      selectedWorkspace = 'Workspace 2';
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: WorkspaceCategories(selectedWorkspace),
    );
  }
}

class WorkspaceCategories extends StatelessWidget {
  final String selectedCategory;

  WorkspaceCategories(this.selectedCategory);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 1, // Set itemCount to 1 to force a single build
      itemBuilder: (context, index) {
        return _buildCategoryContent(selectedCategory);
      },
    );
  }

  Widget _buildCategoryContent(String category) {
    if (category == 'Boards') {
      return Column(
        children: [
          WorkspaceCategory('Workspace 1', ['Board 1', 'Board 2', 'Board 3']),
          WorkspaceCategory('Workspace 2', ['Board 4', 'Board 5']),
          // Add more categories as needed
        ],
      );
    } else if (category == 'Workspace 1') {
      return WorkspaceCategory('Workspace 1', ['Board 1', 'Board 2', 'Board 3']);
    } else if (category == 'Workspace 2') {
      return WorkspaceCategory('Workspace 2', ['Board 4', 'Board 5']);
    } else {
      // Return a default or empty widget for unknown categories
      return Container();
    }
  }
}


class WorkspaceCategory extends StatelessWidget {
  final String categoryName;
  final List<String> boards;

  WorkspaceCategory(this.categoryName, this.boards);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(categoryName, style: TextStyle(fontSize: 18)),
        children: boards.map((board) {
          return ListTile(
            title: Text(board),
            onTap: () {
              // Implement the action for the selected board
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}
