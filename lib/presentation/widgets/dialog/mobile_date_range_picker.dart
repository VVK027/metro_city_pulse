// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
//
// class MobileDateRangePicker extends StatefulWidget {
//   const MobileDateRangePicker({super.key});
//
//   @override
//   State<MobileDateRangePicker> createState() => _MobileDateRangePickerState();
// }
//
// class _MobileDateRangePickerState extends State<MobileDateRangePicker> {
//   PickerDateRange? _tempRange;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: MediaQuery.of(context).viewInsets, // avoid keyboard overlap
//       child: Wrap(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Drag handle
//                 Container(
//                   width: 50,
//                   height: 4,
//                   margin: const EdgeInsets.only(bottom: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[400],
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//
//                 // Calendar
//                 _buildCalendarOnly(),
//
//                 const SizedBox(height: 8),
//
//                 // Quick options row
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       _quickChip("Today"),
//                       _quickChip("Yesterday"),
//                       _quickChip("Last week"),
//                       _quickChip("Last month"),
//                       _quickChip("Last quarter"),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 // Bottom action row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextButton(
//                       onPressed: _resetSelection,
//                       child: const Text(
//                         "Reset",
//                         style: TextStyle(color: Colors.blue),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         OutlinedButton(
//                           onPressed: () => Navigator.pop(context, null),
//                           child: const Text("Cancel"),
//                         ),
//                         const SizedBox(width: 8),
//                         ElevatedButton(
//                           onPressed: () => Navigator.pop(context, _selectedRange),
//                           child: const Text("Apply"),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _quickChip(String label) {
//     final bool isActive = _activeQuickOption == label;
//     return Padding(
//       padding: const EdgeInsets.only(right: 8),
//       child: ChoiceChip(
//         label: Text(label),
//         selected: isActive,
//         onSelected: (_) => _setQuickRange(label),
//         selectedColor: Colors.blue.shade100,
//         labelStyle: TextStyle(
//           color: isActive ? Colors.blue : Colors.black,
//           fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
//         ),
//       ),
//     );
//   }
// }
//
