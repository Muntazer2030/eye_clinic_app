import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final bool isWideScreen;
  final bool isMediumScreen;
  final List<String> currentLensTypes;
  
  // Callbacks
  final Function(String) onAddLensType;
  final Function(String) onDeleteLensType;
  final VoidCallback onDeleteAllData;

  const SettingsPage({
    super.key,
    required this.isWideScreen,
    required this.isMediumScreen,
    required this.currentLensTypes,
    required this.onAddLensType,
    required this.onDeleteLensType,
    required this.onDeleteAllData,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _lensTypeController = TextEditingController();

  @override
  void dispose() {
    _lensTypeController.dispose();
    super.dispose();
  }

  void _handleAddLens() {
    if (_lensTypeController.text.trim().isNotEmpty) {
      widget.onAddLensType(_lensTypeController.text.trim());
      _lensTypeController.clear();
      
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("تمت إضافة نوع العدسة بنجاح", style: TextStyle(fontFamily: 'Arial')),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // --- 1. NEW: Confirmation Dialog for single lens deletion ---
  void _confirmDeleteLensType(String typeToDelete) {
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child:  AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.orange, size: 28),
              SizedBox(width: 10),
              Text("حذف عنصر"),
            ],
          ),
          content: Text(
            "هل أنت متأكد من حذف '$typeToDelete' من القائمة؟",
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text("إلغاء", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                // Perform deletion
                widget.onDeleteLensType(typeToDelete);
                Navigator.of(ctx).pop(); // Close dialog
              },
              child: const Text("حذف", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  // --- Existing: Confirmation Dialog for Delete All ---
  void _showDeleteAllConfirmationDialog() {
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
              SizedBox(width: 10),
              Text("تحذير هام"),
            ],
          ),
          content: const Text(
            "هل أنت متأكد أنك تريد حذف جميع بيانات المراجعين؟\nلا يمكن التراجع عن هذه العملية وسيتم فقدان جميع السجلات.",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text("إلغاء", style: TextStyle(color: Colors.grey, fontSize: 16)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                widget.onDeleteAllData();
              },
              child: const Text("حذف الجميع", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // --- Header Section ---
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                color: Colors.white,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الإعدادات العامة",
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "إدارة أنواع العدسات والبيانات",
                            style: TextStyle(color: Colors.grey[600], fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // --- Body Section ---
              Card(
                margin: const EdgeInsets.all(20),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Add Lens Type Section
                      Text(
                        "إضافة نوع عدسة جديد",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 420),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: TextField(
                                controller: _lensTypeController,
                                decoration: const InputDecoration(
                                  hintText: "اكتب اسم العدسة هنا...",
                                  prefixIcon: Icon(Icons.remove_red_eye_outlined, color: Colors.grey),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _handleAddLens,
                            child: const Text(
                              'إضافة',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),
                      const Divider(thickness: 1, color: Colors.black12),
                      const SizedBox(height: 40),

                      // 2. Display Current Lens Types
                      Text(
                        "أنواع العدسات الحالية",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                      ),
                      const SizedBox(height: 15),
                      
                      if (widget.currentLensTypes.isEmpty)
                        const Text("لا توجد أنواع مضافة حالياً", style: TextStyle(color: Colors.grey))
                      else
                        Wrap(
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: widget.currentLensTypes.map((type) {
                            return Chip(
                              elevation: 2,
                              backgroundColor: Colors.blue[50],
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              avatar: const CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                                child: Icon(Icons.lens, size: 14, color: Colors.white),
                              ),
                              label: Text(
                                type,
                                style: const TextStyle(
                                  fontSize: 14, 
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              deleteIcon: const Icon(Icons.close, size: 18),
                              deleteIconColor: Colors.red,
                              
                              // --- 2. Call the confirmation dialog instead of direct delete ---
                              onDeleted: () {
                                _confirmDeleteLensType(type);
                              },
                              
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.blue.shade100),
                              ),
                            );
                          }).toList(),
                        ),

                      const SizedBox(height: 40),
                      const Divider(thickness: 1, color: Colors.black12),
                      const SizedBox(height: 40),

                      // 3. Danger Zone
                      Row(
                        children: [
                          const Icon(Icons.dangerous_outlined, color: Colors.red, size: 30),
                          const SizedBox(width: 10),
                          Text(
                            "حذف جميع بيانات المراجعين",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "هذا الإجراء سيقوم بمسح جميع بيانات المراجعين المخزنة في النظام. يرجى الحذر.",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[50],
                            foregroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: Colors.red),
                            ),
                            elevation: 0,
                          ),
                          onPressed: _showDeleteAllConfirmationDialog,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete_forever),
                              SizedBox(width: 10),
                              Text(
                                'حذف جميع البيانات',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
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