import 'package:eye_clinic/models/client.dart';
import 'package:eye_clinic/ui/widgets/client_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 2. Dummy Data
  final List<Client> _allClients = [
    Client(
      id: '1',
      name: 'محمد علي',
      phone: '07701234567',
      lastVisit: "2025-12-10",
      lensesType: "عدسات لاصقة",
      age: 26,
    ),
    Client(
      id: '2',
      name: 'Zahra Ahmed',
      phone: '07809876543',
      lastVisit: "2025-12-10",
      lensesType: 'عدسات فلتر بلوكات مخصصة للاجهزة الاكلترونية',
      age: 26,
    ),
    Client(
      id: '3',
      name: 'يوسف كريم',
      phone: '07505551234',
      lastVisit: "2025-12-10",
      lensesType: 'بايفوكل مع فاصل',
      age: 26,
    ),
    Client(
      id: '4',
      name: 'Fatima Omar',
      phone: '07712223333',
      lastVisit: "2025-12-10",
      lensesType: 'عدسات فوتوكري بلوكات',
      age: 26,
    ),
    Client(
      id: '4',
      name: 'Fatima Omar',
      phone: '07712223333',
      lastVisit: "2025-12-10",
      lensesType: 'عدسات فوتوكري بلوكات',
      age: 26,
    ),
    Client(
      id: '2',
      name: 'Zahra Ahmed',
      phone: '07809876543',
      lastVisit: "2025-12-10",
      lensesType: 'عدسات فلتر بلوكات مخصصة للاجهزة الاكلترونية',
      age: 26,
    ),
    Client(
      id: '3',
      name: 'يوسف كريم',
      phone: '07505551234',
      lastVisit: "2025-12-10",
      lensesType: 'بايفوكل مع فاصل',
      age: 26,
    ),
    Client(
      id: '4',
      name: 'Fatima Omar',
      phone: '07712223333',
      lastVisit: "2025-12-10",
      lensesType: 'عدسات فوتوكري بلوكات',
      age: 26,
    ),
    Client(
      id: '4',
      name: 'Fatima Omar',
      phone: '07712223333',
      lastVisit: "2025-12-10",
      lensesType: 'عدسات فوتوكري بلوكات',
      age: 26,
    ),
  ];

  List<Client> _filteredClients = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredClients = _allClients;
  }

  void _runFilter(String enteredKeyword) {
    List<Client> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allClients;
    } else {
      results = _allClients
          .where(
            (client) =>
                client.name.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ) ||
                client.phone.contains(enteredKeyword),
          )
          .toList();
    }

    setState(() {
      _filteredClients = results;
    });
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
                            Icon(
                              Icons.remove_red_eye_rounded,
                              size: isWideScreen ? 60 : 40,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 10),
                            if (isWideScreen)
                              const Text(
                                "Clarity Vision",
                                style: TextStyle(
                                  fontSize: 20,
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
                                    _NavTile(
                                      icon: Icons.people_outline_rounded,
                                      title: "المراجعين",
                                      isActive: true,
                                      isCompact: !isWideScreen,
                                    ),
                                    _NavTile(
                                      icon: Icons.group_add_outlined,
                                      title: "اضافة مراجع",
                                      isActive: false,
                                      isCompact: !isWideScreen,
                                    ),
                                    _NavTile(
                                      icon: Icons.settings_outlined,
                                      title: "الاعدادات",
                                      isActive: false,
                                      isCompact: !isWideScreen,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // --- FOOTER SECTION (Always at bottom) ---
                            const Divider(),
                            if (isWideScreen)
                              const ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 15,
                                ),
                                title: Text(
                                  "Dr. Al-Doctor",
                                  style: TextStyle(fontSize: 14),
                                ),
                                subtitle: Text(
                                  "Ophthalmologist",
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                            else
                              const Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 15,
                                ),
                              ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      // 4. Main Content Area
                      Expanded(
                        child: Column(
                          children: [
                            // Top Header
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 30,
                              ),
                              color: Colors.white,
                              child: Row(
                                children: [
                                  // 1. Wrap the text Column in Expanded so it allows shrinking
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "المراجعين",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                          // 2. Add these lines to handle text shrinking/overflow
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        const SizedBox(height: 5),

                                        // Hide subtitle on very small screens
                                        if (isWideScreen)
                                          Text(
                                            "العدد الكلي للمراجعين ${_allClients.length}",
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 16,
                                            ),
                                            // 2. Add these lines to handle text shrinking/overflow
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                      ],
                                    ),
                                  ),

                                  // Responsive Spacer or fixed gap
                                  if (isWideScreen)
                                    const Spacer()
                                  else
                                    const SizedBox(width: 10),

                                  // Flexible Search Bar
                                  Expanded(
                                    flex: isWideScreen
                                        ? 0
                                        : 2, // Increased flex to 2 on small screens to give search bar more room
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 420,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      child: TextField(
                                        controller: _searchController,
                                        onChanged: _runFilter,
                                        decoration: InputDecoration(
                                          hintText: isWideScreen
                                              ? "ابحث عن المراجعين ..."
                                              : "بحث...",
                                          prefixIcon: const Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),

                                  // Button (Icon only on small screens)
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    label: isWideScreen
                                        ? const Text(
                                            "اضافة مراجع",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )
                                        : const SizedBox.shrink(), // Hide text on small screens
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isMediumScreen ? 20 : 10,
                                        vertical: 18,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // The List
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: _filteredClients.isEmpty
                                    ? Center(
                                        child: Text(
                                          "لا يوجد مراجعين",
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 18,
                                          ),
                                        ),
                                      )
                                    : ListView.separated(
                                        itemCount: _filteredClients.length,
                                        separatorBuilder: (ctx, index) =>
                                            const SizedBox(height: 15),
                                        itemBuilder: (ctx, index) {
                                          return ClientCard(
                                            client: _filteredClients[index],
                                          );
                                        },
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

// Updated NavTile to handle Compact Mode
class _NavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final bool isCompact; // New parameter

  const _NavTile({
    required this.icon,
    required this.title,
    required this.isActive,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context) {
    // If sidebar is collapsed (compact), show a centered icon only
    if (isCompact) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[500],
          ),
          tooltip: title, // Show text on hover
        ),
      );
    }

    // Normal full width tile
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: isActive
          ? BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Colors.grey[500],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[600],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
