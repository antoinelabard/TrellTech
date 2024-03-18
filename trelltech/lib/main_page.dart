import 'package:flutter/material.dart';
import 'package:trelltech/data/Repository.dart';
import 'package:trelltech/data/entities/BoardEntity.dart';
import 'package:trelltech/data/entities/MemberEntity.dart';
import 'package:trelltech/data/entities/OrganizationEntity.dart';
import 'package:trelltech/board_page.dart';

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
  dynamic selectedWorkspace = 'Boards'; // Default category
  String? selectedOrganizationId;
  List<OrganizationEntity> organizationList = []; // Updated organization list
  List<BoardEntity> boardList = []; // Updated board list

  @override
  void initState() {
    super.initState();
    // Call the method to get joined organizations and their boards
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Replace 'userId' with the actual user ID
      MemberEntity currentUser = await Repository.Member.get("userId");

      // Get the joined organizations
      organizationList =
      await Repository.Organization.getJoinedOrganizations(currentUser);

      // Get the boards for each organization
      for (OrganizationEntity organization in organizationList) {
        List<BoardEntity> boards = await Repository.Organization.getBoards(
            organization);
        boardList.addAll(boards);
      }

      // Set default organization and workspace
      if (organizationList.isNotEmpty) {
        selectedWorkspace = "Boards";
      }

      setState(() {});
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

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
              children: List.generate(
                organizationList.length,
                    (index) =>
                    ListTile(
                      leading: Icon(Icons.group),
                      title: Text(organizationList[index].displayName ??
                          'Unknown Organization'),
                      onTap: () {
                        // Set the selectedWorkspace to the organization's displayName
                        setState(() {
                          selectedWorkspace =
                              organizationList[index].displayName;
                          selectedOrganizationId = organizationList[index].id;
                        });
                        Navigator.pop(context);
                      },
                    ),
              ),
            ),


          ],
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (selectedWorkspace == 'Boards') {
      // Afficher tous les workspaces dans des ExpansionTiles
      return ListView.builder(
        itemCount: organizationList.length,
        itemBuilder: (context, index) {
          OrganizationEntity organization = organizationList[index];

          // Filtrer les tableaux pour afficher uniquement ceux liés à l'espace de travail sélectionné
          List<BoardEntity> boardsForSelectedWorkspace = boardList
              .where((board) =>
          board.idOrganization == organization.id &&
              board.idOrganization != null)
              .toList();

          return ExpansionTile(
            title: Text(organization.displayName ?? 'Workspace inconnu'),
            children: [
              // Liste des tableaux pour le workspace sélectionné
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: boardsForSelectedWorkspace.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      boardsForSelectedWorkspace[index].name ??
                          'Tableau inconnu',
                    ),
                    onTap: () {
                      // Naviguer vers la page de détail du tableau
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BoardDetailPage(
                                boardName: boardsForSelectedWorkspace[index]
                                    .name ??
                                    'Tableau inconnu',
                              ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      // Afficher tous les tableaux
      return ListView.builder(
        itemCount: boardList.length,
        itemBuilder: (context, index) {
          BoardEntity board = boardList[index];
          return ListTile(
            title: Text(board.name ?? 'Tableau inconnu'),
            onTap: () {
              // Naviguer vers la page de détail du tableau
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BoardDetailPage(
                        boardName: board.name ?? 'Tableau inconnu',
                      ),
                ),
              );
            },
          );
        },
      );
    }
  }
}