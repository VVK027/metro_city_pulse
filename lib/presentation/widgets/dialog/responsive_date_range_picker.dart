import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ResponsiveDateRangePicker extends ConsumerStatefulWidget {
  const ResponsiveDateRangePicker({super.key});

  @override
  ConsumerState<ResponsiveDateRangePicker> createState() =>
      _ResponsiveDateRangePickerState();
}

class _ResponsiveDateRangePickerState
    extends ConsumerState<ResponsiveDateRangePicker> {
  PickerDateRange? _selectedRange;
  PickerDateRange? _tempRange;
  final DateRangePickerController _datePickerController =
      DateRangePickerController();

  String? _activeQuickOption; // tracks which option is highlighted

  // === Quick range helper ===
  PickerDateRange _getRange(String type) {
    final now = DateTime.now();
    DateTime start;
    DateTime end;

    switch (type) {
      case "today":
        start = end = DateTime(now.year, now.month, now.day);
        break;
      case "yesterday":
        final y = now.subtract(const Duration(days: 1));
        start = end = DateTime(y.year, y.month, y.day);
        break;
      case "last_week":
        final lastMonday = now.subtract(Duration(days: now.weekday + 6));
        start = DateTime(lastMonday.year, lastMonday.month, lastMonday.day);
        end = start.add(const Duration(days: 6));
        break;
      case "last_month":
        start = DateTime(now.year, now.month - 1, 1);
        end = DateTime(now.year, now.month, 0);
        break;
      case "last_quarter":
        final currentQuarter = ((now.month - 1) ~/ 3) + 1;
        final startMonth = (currentQuarter - 2) * 3 + 1;
        start = DateTime(now.year, startMonth, 1);
        end = DateTime(now.year, startMonth + 3, 0);
        break;
      default:
        start = now;
        end = now;
    }
    return PickerDateRange(start, end);
  }

  void _setQuickRange(String type) {
    final range = _getRange(type);

    setState(() {
      _tempRange = range;
      _datePickerController.selectedRange = range;
      _datePickerController.displayDate = range.startDate;
      _activeQuickOption = type;
    });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      final range = args.value as PickerDateRange;
      setState(() {
        _tempRange = range;
        _activeQuickOption = _detectQuickOption(
          range,
        ); // auto-highlight if match
      });
    }
  }

  void _onApply() {
    setState(() {
      _selectedRange = _tempRange;
    });
    Navigator.pop(context, _selectedRange);
  }

  void _onCancel() {
    setState(() {
      _tempRange = _selectedRange;
      _datePickerController.selectedRange = _selectedRange;
      _activeQuickOption = null;
    });
    Navigator.pop(context);
  }

  void _onReset() {
    setState(() {
      _tempRange = null;
      _selectedRange = null;
      _datePickerController.selectedRange = null;
      _activeQuickOption = null;
    });
  }

  /// Detect if the range matches one of the quick options
  String? _detectQuickOption(PickerDateRange range) {
    final quickOptions = [
      "today",
      "yesterday",
      "last_week",
      "last_month",
      "last_quarter",
    ];
    for (final opt in quickOptions) {
      final qr = _getRange(opt);
      if (_isSameRange(qr, range)) return opt;
    }
    return null;
  }

  bool _isSameRange(PickerDateRange a, PickerDateRange b) {
    return a.startDate!.year == b.startDate!.year &&
        a.startDate!.month == b.startDate!.month &&
        a.startDate!.day == b.startDate!.day &&
        a.endDate!.year == b.endDate!.year &&
        a.endDate!.month == b.endDate!.month &&
        a.endDate!.day == b.endDate!.day;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text("select_date_range".tr(ref).toAllCapitalize()),
        actions: isMobile
            ? [
                IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () => _showQuickOptionsBottomSheet(context),
                ),
              ]
            : null,
      ),
      body: isMobile
          ? Column(
              children: [
                Expanded(child: _buildCalendarOnly()),
                _buildActionButtons(),
              ],
            )
          : Row(
              children: [
                _buildQuickOptionsSidebar(),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: _buildCalendarOnly()),
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // Sidebar quick options
  Widget _buildQuickOptionsSidebar() {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 140,
      color: Colors.grey.shade100,
      child: ListView(
        children: [
          _quickOption("today".tr(ref), "today"),
          _quickOption("yesterday".tr(ref), "yesterday"),
          _quickOption("last_week".tr(ref), "last_week"),
          _quickOption("last_month".tr(ref), "last_month"),
          _quickOption("last_quarter".tr(ref), "last_quarter"),
          ListTile(
            title: Text(
              "reset".tr(ref).toAllCapitalize(),
              style: TextStyle(color: colorScheme.primary),
            ),
            onTap: _onReset,
          ),
        ],
      ),
    );
  }

  // Calendar only
  Widget _buildCalendarOnly() {
    final colorScheme = Theme.of(context).colorScheme;
    return SfDateRangePicker(
      controller: _datePickerController,
      onSelectionChanged: _onSelectionChanged,
      selectionMode: DateRangePickerSelectionMode.range,
      initialSelectedRange: _selectedRange,
      selectionColor: colorScheme.primary,
      rangeSelectionColor: colorScheme.primary.withValues(alpha: 0.2),
      todayHighlightColor: colorScheme.primary,
      showActionButtons: false,
      key: ValueKey(_selectedRange?.startDate.toString() ?? "empty"),
    );
  }

  // Action buttons
  Widget _buildActionButtons() {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: _onCancel,
            child: Text("cancel".tr(ref).toAllCapitalize()),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: _onApply,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
            ),
            child: Text("apply".tr(ref).toAllCapitalize()),
          ),
        ],
      ),
    );
  }

  // Mobile bottom sheet quick options
  void _showQuickOptionsBottomSheet(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              _quickOption("today".tr(ref), "today"),
              _quickOption("yesterday".tr(ref), "yesterday"),
              _quickOption("last_week".tr(ref), "last_week"),
              _quickOption("last_month".tr(ref), "last_month"),
              _quickOption("last_quarter".tr(ref), "last_quarter"),
              ListTile(
                title: Text(
                  "reset".tr(ref).toAllCapitalize(),
                  style: TextStyle(color: colorScheme.primary),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _onReset();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Reusable option with highlight
  Widget _quickOption(String label, String type) {
    final colorScheme = Theme.of(context).colorScheme;
    final isActive = _activeQuickOption == type;

    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive ? colorScheme.primary : Colors.black,
        ),
      ),
      tileColor: isActive ? colorScheme.primary.withValues(alpha: 0.1) : null,
      onTap: () {
        Navigator.popUntil(
          context,
          (route) => route.isFirst,
        ); // close sheet if mobile
        _setQuickRange(type);
      },
    );
  }
}
