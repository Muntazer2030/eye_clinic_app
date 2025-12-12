import 'package:flutter/material.dart';

class DateSelectorWidget extends StatefulWidget {
  final Function(int, int, int) onDateSelected;
  const DateSelectorWidget({super.key, required this.onDateSelected});

  @override
  State<DateSelectorWidget> createState() => _DateSelectorWidgetState();
}

class _DateSelectorWidgetState extends State<DateSelectorWidget> {
  // Initialize with Today
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int selectedDay = DateTime.now().day;

  int get daysInMonth => DateTime(selectedYear, selectedMonth + 1, 0).day;

  @override
  Widget build(BuildContext context) {
    return Container(
     constraints: const BoxConstraints(maxWidth: 220),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Day
          _buildMinimalDropdown(
            value: selectedDay,
            items: List.generate(daysInMonth, (index) => index + 1),
            flex: 2,
            onChanged: (val) => setState(() => selectedDay = val as int),
          ),
            
          _buildSeparator(),
            
          // Month
          _buildMinimalDropdown(
            value: selectedMonth,
            items: List.generate(12, (index) => index + 1),
            flex: 2,
            onChanged: (val) {
              setState(() {
                selectedMonth = val as int;
                if (selectedDay > daysInMonth) selectedDay = daysInMonth;
              });
            },
          ),
            
          _buildSeparator(),
            
          // Year
          _buildMinimalDropdown(
            value: selectedYear,
            items: List.generate(80, (index) => 1950 + index),
            flex: 3,
            onChanged: (val) {
              setState(() {
                selectedYear = val as int;
                if (selectedDay > daysInMonth) selectedDay = daysInMonth;
              });
              widget.onDateSelected(selectedYear, selectedMonth, selectedDay);
            },
          ),
        ],
      ),
    );
  }

  // The subtle "/" separator
  Widget _buildSeparator() {
    return Text(
      "/",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w300, // Thinner looks more modern
        color: Colors.grey.shade400,
      ),
    );
  }

  // A cleaner, borderless dropdown designed to fit inside the main container
  Widget _buildMinimalDropdown({
    required int value,
    required List<int> items,
    required int flex,
    required Function(dynamic) onChanged,
  }) {
    return Expanded(
      flex: flex,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: Colors.grey,
          ),
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold, // Bold numbers look better
            fontSize: 16,
          ),
          onChanged: onChanged,
          alignment: Alignment.center, // Center the text
          items: items.map((int item) {
            return DropdownMenuItem<int>(
              value: item,
              child: Center(
                child: Text(item.toString().padLeft(2, '0')),
              ), // 01, 02 format
            );
          }).toList(),
        ),
      ),
    );
  }
}
