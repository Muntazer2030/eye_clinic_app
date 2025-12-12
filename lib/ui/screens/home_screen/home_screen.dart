import 'package:eye_clinic/models/client.dart';
import 'package:eye_clinic/services/json_db_service.dart';
import 'package:eye_clinic/ui/screens/pages/adding_clinet_page.dart';
import 'package:eye_clinic/ui/screens/pages/clinets_page.dart';
import 'package:eye_clinic/ui/screens/pages/settings_page.dart';
import 'package:eye_clinic/ui/widgets/nav_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  JsonDbService dbService = JsonDbService();

  int selected = 0;

  // 2. Dummy Data
  List<Client> allClients = [];
  List<String> lensesTypes = [];
  Future<void> initializeDb() async {
    await dbService.init();

    // Try to read the 'clients' key from the file
    var data =await dbService.read('clients');
    var lensesData =await dbService.read('lenses_types');
    if (data != null) {
      List<dynamic> jsonList = data;
      allClients = jsonList.map((json) => Client.fromJson(json)).toList();
      setState(() {
        allClients = allClients;
      });
    }
    if (lensesData != null) {
      setState(() {
        lensesTypes = List<String>.from(lensesData);
      });
    }
  }
   void _handleAddedClient() {
     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("تمت إضافة المراجع بنجاح", style: TextStyle(fontFamily: 'Arial')),
          backgroundColor: Colors.green,
        ),
      );
  }
  /// Helper to save the current list to the DB
  Future<void> _saveClientsToDb() async {
    // Convert List<Client> -> List<Map>
    List<Map<String, dynamic>> jsonList = allClients
        .map((c) => c.toJson())
        .toList();

    // Write to file
    await dbService.write('clients', jsonList);
  }

  Future<void> _saveLensesTypesToDb() async {
    await dbService.write('lenses_types', lensesTypes);
  }

  @override
  void initState() {
    initializeDb();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // 1. LayoutBuilder detects window resize
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Define breakpoints
          bool isWideScreen = constraints.maxWidth > 900;
          bool isMediumScreen = constraints.maxWidth > 700;

          bool isTooSmallScreen =
              constraints.maxWidth < 450 || constraints.maxHeight < 300;

          return isTooSmallScreen
              ? Container()
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      // 3. Side Navigation Bar (Fixed for Height Resize)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: isWideScreen ? 250 : 70,
                        color: Colors.white,
                        child: Column(
                          children: [
                            // --- HEADER SECTION ---
                            const SizedBox(height: 30),
                            Image.asset(
                              'assets/images/logo.png', // your image path
                              width: isWideScreen ? 140 : 70,
                              height: isWideScreen ? 140 : 70,
                              fit: BoxFit.contain,
                            ),

                            const SizedBox(height: 10),
                            if (isWideScreen)
                              const Text(
                                "عوينات الفائز",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                              ),
                            const SizedBox(height: 40),

                            // --- MIDDLE SECTION (Scrollable) ---
                            // 1. Expanded takes up all remaining empty space (replacing Spacer)
                            // 2. SingleChildScrollView ensures no overflow if height is small
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    NavTile(
                                      icon: Icons.people_outline_rounded,
                                      title: "المراجعين",
                                      isActive: selected == 0,
                                      isCompact: !isWideScreen,
                                      onTap: () {
                                        setState(() {
                                          selected = 0;
                                        });
                                      },
                                    ),
                                    NavTile(
                                      icon: Icons.group_add_outlined,
                                      title: "اضافة مراجع",
                                      isActive: selected == 1,
                                      isCompact: !isWideScreen,
                                      onTap: () {
                                        setState(() {
                                          selected = 1;
                                        });
                                      },
                                    ),
                                    NavTile(
                                      icon: Icons.settings_outlined,
                                      title: "الاعدادات",
                                      isActive: selected == 2,
                                      isCompact: !isWideScreen,
                                      onTap: () {
                                        setState(() {
                                          selected = 2;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Builder(
                        builder: (context) {
                          if (selected == 0) {
                            return ClinetsPage(
                              isWideScreen: isWideScreen,
                              isMediumScreen: isMediumScreen,
                              allClients: allClients.reversed.toList(),
                              onAddClient: () {
                                setState(() {
                                  selected = 1;
                                });
                              },
                            );
                          } else if (selected == 1) {
                            return AddingClinetPage(
                              isWideScreen: isWideScreen,
                              isMediumScreen: isMediumScreen,
                              allClients: allClients,
                              lensesTypes: lensesTypes,
                              onAddClient: (client) {
                                setState(() {
                                  selected = 0;
                                  allClients.add(client);
                                });
                                _saveClientsToDb();
                                _handleAddedClient();
                              },
                            );
                          } else {
                            return SettingsPage(
                              isWideScreen: isWideScreen,
                              isMediumScreen: isMediumScreen,
                              onAddLensType: (lensType) {
                                setState(() {
                                  lensesTypes.add(lensType);
                                });
                                _saveLensesTypesToDb();
                              },
                              onDeleteAllData: () {
                                setState(() {
                                  allClients.clear();
                                  lensesTypes.clear();
                                });
                                dbService.clear();
                              },
                              onDeleteLensType: (lensType) {
                                setState(() {
                                  lensesTypes.remove(lensType);
                                });
                              },
                              currentLensTypes: lensesTypes,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
