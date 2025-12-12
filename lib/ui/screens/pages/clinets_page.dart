import 'package:eye_clinic/models/client.dart';
import 'package:eye_clinic/ui/widgets/client_card.dart';
import 'package:flutter/material.dart';

class ClinetsPage extends StatefulWidget {
  final bool isWideScreen;
  final bool isMediumScreen;
  final List<Client> allClients;
  final VoidCallback onAddClient;
  const ClinetsPage({
    super.key,
    required this.isWideScreen,
    required this.isMediumScreen,
    required this.allClients,
    required this.onAddClient,
  });

  @override
  State<ClinetsPage> createState() => _ClinetsPageState();
}

class _ClinetsPageState extends State<ClinetsPage> {
  List<Client> _filteredClients = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredClients = widget.allClients;
  }

  @override
  void didUpdateWidget(covariant ClinetsPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.allClients != widget.allClients) {
      setState(() {
        _filteredClients = widget.allClients;
      });
    }
  }

  void _runFilter(String enteredKeyword) {
    List<Client> results = [];
    if (enteredKeyword.isEmpty) {
      results = widget.allClients;
    } else {
      results = widget.allClients
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
    return Expanded(
      child: Column(
        children: [
          // Top Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            color: Colors.white,
            child: Row(
              children: [
                // 1. Wrap the text Column in Expanded so it allows shrinking
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "المراجعين",
                        style: Theme.of(context).textTheme.headlineMedium
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
                      if (widget.isWideScreen)
                        Text(
                          "العدد الكلي للمراجعين ${widget.allClients.length}",
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
                if (widget.isWideScreen)
                  const Spacer()
                else
                  const SizedBox(width: 10),

                // Flexible Search Bar
                Expanded(
                  flex: widget.isWideScreen
                      ? 0
                      : 2, // Increased flex to 2 on small screens to give search bar more room
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 420),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: _searchController,

                      onChanged: _runFilter,
                      decoration: InputDecoration(
                        hintText: widget.isWideScreen
                            ? "ابحث عن المراجعين ..."
                            : "بحث...",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                // Button (Icon only on small screens)
                ElevatedButton.icon(
                  onPressed: widget.onAddClient,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: widget.isWideScreen
                      ? const Text(
                          "اضافة مراجع",
                          style: TextStyle(color: Colors.white),
                        )
                      : const SizedBox.shrink(), // Hide text on small screens
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.isMediumScreen ? 20 : 10,
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
                        style: TextStyle(color: Colors.grey[500], fontSize: 18),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _filteredClients.length,
                      separatorBuilder: (ctx, index) =>
                          const SizedBox(height: 15),
                      itemBuilder: (ctx, index) {
                        return ClientCard(client: _filteredClients[index]);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
