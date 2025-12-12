import 'package:flutter/material.dart';

class LensesTypeWidget extends StatefulWidget {

  final Function(String) onSelected;
  final List<String> lensesTypes;

  const LensesTypeWidget({
    super.key,
    required this.lensesTypes,
    required this.onSelected,
  });

  @override
  State<LensesTypeWidget> createState() => _LensesTypeWidgetState();
}

class _LensesTypeWidgetState extends State<LensesTypeWidget> {
  // Store the selected String, not the int index
  late String selectedLens;

  @override
  void initState() {
    super.initState();
    // Initialize with the first item in the list
    if (widget.lensesTypes.isNotEmpty) {
      selectedLens = widget.lensesTypes[0];
    } else {
      selectedLens = '';
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Increased width to accommodate long Arabic text
      constraints: const BoxConstraints(maxWidth: 660),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
      
          value: selectedLens,
          isExpanded: true, // Crucial for long text
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 24,
            color: Colors.grey,
          ),
         
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize:
                20, // Slightly smaller font for long text compatibility
            fontFamily: 'Arial',
            
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedLens = newValue;
              });
              widget.onSelected(newValue);
            }
          },
          items: widget.lensesTypes.map<DropdownMenuItem<String>>((
            String value,
          ) {
            return DropdownMenuItem<String>(
              value: value,
             
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow
                    .ellipsis, // Handle very long text gracefully
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
