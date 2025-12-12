
import 'package:flutter/material.dart';

class EyePrescriptionTable extends StatefulWidget {
  final Map<String, TextEditingController> controllers;

  const EyePrescriptionTable({super.key, required this.controllers});

  @override
  State<EyePrescriptionTable> createState() => _EyePrescriptionTableState();
}

class _EyePrescriptionTableState extends State<EyePrescriptionTable> {
  @override
  Widget build(BuildContext context) {
    // Define the styling variables
    const double labelColumnWidth = 80.0;
    const Color headerColor = Color(0xFFE0E0E0); // Light grey like the image
    const TextStyle headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      fontFamily: 'Arial', // Basic font
    );
    const TextStyle subHeaderStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    const TextStyle labelStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );

    // Helper to build a cell with optional background color
    Widget buildCell(
      String text, {
      Color? color,
      TextStyle? style,
      double height = 50,
    }) {
      return Container(
        height: height,
        color: color,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4),
        child: Text(text, style: style, textAlign: TextAlign.center),
      );
    }

    Widget buildTextFieldCell({
      double height = 50,
      required TextEditingController controller,
    }) {
      return Container(
        height: height,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: TextField(
          textAlign: TextAlign.center,
          maxLength: 5,
          controller: controller,
          decoration: const InputDecoration(
            counter: SizedBox.shrink(),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ------------------------------------------
        // TOP TABLE (The "R.E" and "L.E" Headers)
        // ------------------------------------------
        Table(
          border: TableBorder.all(color: Colors.black, width: 1.5),
          columnWidths: const {
            0: FixedColumnWidth(labelColumnWidth), // The side label column
            1: FlexColumnWidth(1), // R.E section
            2: FlexColumnWidth(1), // L.E section
          },
          children: [
            TableRow(
              children: [
                // Top-left corner (Grey/Empty)
                buildCell("", color: headerColor, height: 45),
                // R.E Header
                buildCell(
                  "R.E اليمين",
                  color: headerColor,
                  style: headerStyle,
                  height: 45,
                ),
                // L.E Header
                buildCell(
                  "L.E اليسار",
                  color: headerColor,
                  style: headerStyle,
                  height: 45,
                ),
              ],
            ),
          ],
        ),

        // ------------------------------------------
        // BOTTOM TABLE (The Data Grid)
        // ------------------------------------------
        // We use a negative margin or just remove the top border to merge them visually
        Transform.translate(
          offset: const Offset(
            0,
            -1.5,
          ), // Pull up slightly to overlap the border
          child: Table(
            border: TableBorder.all(color: Colors.black, width: 1.5),
            columnWidths: const {
              0: FixedColumnWidth(labelColumnWidth),
              // We divide the remaining space into 6 equal parts (3 for Right, 3 for Left)
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(1),
              5: FlexColumnWidth(1),
              6: FlexColumnWidth(1),
            },
            children: [
              // Row 1: Sub-headers (SPH, CYL, AXIS)
              TableRow(
                decoration: const BoxDecoration(color: headerColor),
                children: [
                  buildCell(
                    "»",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    height: 35,
                  ),
                  // R.E Sub-headers
                  buildCell("SPH", style: subHeaderStyle, height: 35),
                  buildCell("CYL", style: subHeaderStyle, height: 35),
                  buildCell("AXIS", style: subHeaderStyle, height: 35),
                  // L.E Sub-headers
                  buildCell("SPH", style: subHeaderStyle, height: 35),
                  buildCell("CYL", style: subHeaderStyle, height: 35),
                  buildCell("AXIS", style: subHeaderStyle, height: 35),
                ],
              ),

              // Row 2: Distance (للبعيد)
              TableRow(
                children: [
                  buildCell(
                    "للبعيد",
                    color: headerColor,
                    style: labelStyle,
                    height: 60,
                  ),
                  // Input cells (Empty for now)
                  buildTextFieldCell(
                    height: 60,
                    controller: widget.controllers['right_sph_distance']!,
                  ),
                  buildTextFieldCell(
                    height: 60,
                    controller: widget.controllers['right_cyl_distance']!,
                  ),
                  buildTextFieldCell(
                    height: 60,
                    controller: widget.controllers['right_axis_distance']!,
                  ),
                  buildTextFieldCell(
                    height: 60,
                    controller: widget.controllers['left_sph_distance']!,
                  ),
                  buildTextFieldCell(
                    height: 60,
                    controller: widget.controllers['left_cyl_distance']!,
                  ),
                  buildTextFieldCell(
                    height: 60,
                    controller: widget.controllers['left_axis_distance']!,
                  ),
                ],
              ),

              // Row 3: Near (للقريب)
              TableRow(
                children: [
                  buildCell(
                    "للقريب",
                    color: headerColor,
                    style: labelStyle,
                    height: 60,
                  ),
                  // Input cells
                  buildTextFieldCell(
                    height: 60,
                    controller: widget.controllers['right_sph_near']!,
                  ),
                  buildTextFieldCell(
                    height: 60,
                    controller: widget.controllers['right_cyl_near']!,
                  ),
                  buildTextFieldCell(
                    height: 60,
                    controller: widget.controllers['right_axis_near']!,
                  ),
                  buildTextFieldCell(
                    height: 60,
                    controller: widget.controllers['left_sph_near']!,
                  ),
                  buildTextFieldCell(
                    height: 60,
                    controller: widget.controllers['left_cyl_near']!,
                  ),
                  buildTextFieldCell(
                    height: 60,
                    controller: widget.controllers['left_axis_near']!,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
