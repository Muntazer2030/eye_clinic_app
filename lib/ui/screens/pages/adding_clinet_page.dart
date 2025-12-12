import 'dart:math';

import 'package:eye_clinic/models/client.dart';
import 'package:eye_clinic/ui/widgets/date_selector_widget.dart';
import 'package:eye_clinic/ui/widgets/eye_prescription_table.dart';
import 'package:eye_clinic/ui/widgets/lenses_type_widget.dart';
import 'package:flutter/material.dart';

class AddingClinetPage extends StatefulWidget {
  final bool isWideScreen;
  final bool isMediumScreen;
  final List<Client> allClients;
  final List<String> lensesTypes;
  final Function(Client) onAddClient;
  const AddingClinetPage({
    super.key,
    required this.isWideScreen,
    required this.isMediumScreen,
    required this.allClients,
    required this.onAddClient,
    required this.lensesTypes,
  });

  @override
  State<AddingClinetPage> createState() => _AddingClinetPageState();
}

class _AddingClinetPageState extends State<AddingClinetPage> {
  final Map<String, TextEditingController> controllers = {
    'right_sph_distance': TextEditingController(),
    'right_cyl_distance': TextEditingController(),
    'right_axis_distance': TextEditingController(),
    'left_sph_distance': TextEditingController(),
    'left_cyl_distance': TextEditingController(),
    'left_axis_distance': TextEditingController(),
    'right_sph_near': TextEditingController(),
    'right_cyl_near': TextEditingController(),
    'right_axis_near': TextEditingController(),
    'left_sph_near': TextEditingController(),
    'left_cyl_near': TextEditingController(),
    'left_axis_near': TextEditingController(),
  };

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int selectedDay = DateTime.now().day;

  String selectedLensesType = "";

  @override
  void initState() {
    if (widget.lensesTypes.isNotEmpty) selectedLensesType = widget.lensesTypes[0];
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ),
                color: Colors.white,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "إضافة مراجع جديد",
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
                  ],
                ),
              ),

              Card(
                margin: const EdgeInsets.all(20),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "نموذج إضافة مراجع جديد",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 420),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: TextField(
                              controller: nameController,
                              maxLength: 35,

                              decoration: InputDecoration(
                                counter: const SizedBox.shrink(),
                                hintText: "اسم المراجع",

                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 220),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: TextField(
                              controller: ageController,
                              maxLength: 3,

                              decoration: InputDecoration(
                                counter: const SizedBox.shrink(),
                                hintText: "العمر",

                                prefixIcon: const Icon(
                                  Icons.perm_identity,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 420),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey.shade300),
                            ),

                            child: TextField(
                              controller: phoneController,
                              maxLength: 16,
                              decoration: InputDecoration(
                                counter: const SizedBox.shrink(),
                                hintText: 'رقم الهاتف',

                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          DateSelectorWidget(
                            onDateSelected:
                                (selectedYear, selectedMonth, selectedDay) {
                                  selectedYear = selectedYear;
                                  selectedMonth = selectedMonth;
                                  selectedDay = selectedDay;
                                },
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      LensesTypeWidget(
                        lensesTypes: widget.lensesTypes,
                        onSelected: (selectedLenses) {},
                      ),

                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: EyePrescriptionTable(controllers: controllers),
                        ),
                      ),

                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 420),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey.shade300),
                            ),

                            child: TextField(
                              controller: priceController,
                              maxLength: 20,
                              decoration: InputDecoration(
                                counter: const SizedBox.shrink(),
                                hintText: "السعر",

                                prefixIcon: const Icon(
                                  Icons.sell,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 420),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey.shade300),
                            ),

                            child: TextField(
                              controller: notesController,
                              maxLength: 100,
                              decoration: InputDecoration(
                                counter: const SizedBox.shrink(),
                                hintText: "ملاحظات",

                                prefixIcon: const Icon(
                                  Icons.notes,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                           try{
                             Client newClient = Client(
                              id: Random().nextInt(10000000),
                              name: nameController.text,
                              phone: phoneController.text,
                              lastVisit: "$selectedYear/$selectedMonth/$selectedDay",
                              lensesType: selectedLensesType,
                              age: int.parse(ageController.text),
                              price: priceController.text,
                              notes: notesController.text,
                            );
                            widget.onAddClient(newClient);
                           } catch(e){
                            // Handle error if needed
                           }
                          },
                          child: const Text(
                            'إضافة المراجع',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
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
