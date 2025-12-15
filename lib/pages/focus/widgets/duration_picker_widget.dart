import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class DurationPickerWidget extends StatefulWidget {
  final int workDuration;
  final int shortBreakDuration;
  final int longBreakDuration;
  final int cyclesBeforeLongBreak;
  final Function(int) onWorkDurationChanged;
  final Function(int) onShortBreakChanged;
  final Function(int) onLongBreakChanged;
  final Function(int) onCyclesChanged;
  final VoidCallback onResetToDefaults;

  const DurationPickerWidget({
    super.key,
    required this.workDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.cyclesBeforeLongBreak,
    required this.onWorkDurationChanged,
    required this.onShortBreakChanged,
    required this.onLongBreakChanged,
    required this.onCyclesChanged,
    required this.onResetToDefaults,
  });

  @override
  State<DurationPickerWidget> createState() => _DurationPickerWidgetState();
}

class _DurationPickerWidgetState extends State<DurationPickerWidget> {
  int _selectedTab = 0;
  late int _workDuration;
  late int _shortBreakDuration;
  late int _cyclesBeforeLongBreak;

  bool get _isUsingDefaults =>
      _workDuration == 25 &&
      _shortBreakDuration == 5 &&
      _cyclesBeforeLongBreak == 4;

  @override
  void initState() {
    super.initState();
    _workDuration = widget.workDuration;
    _shortBreakDuration = widget.shortBreakDuration;
    _cyclesBeforeLongBreak = widget.cyclesBeforeLongBreak;
    _selectedTab = _isUsingDefaults ? 0 : 1;
  }

  @override
  void didUpdateWidget(DurationPickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.workDuration != _workDuration) {
      _workDuration = widget.workDuration;
    }
    if (widget.shortBreakDuration != _shortBreakDuration) {
      _shortBreakDuration = widget.shortBreakDuration;
    }
    if (widget.cyclesBeforeLongBreak != _cyclesBeforeLongBreak) {
      _cyclesBeforeLongBreak = widget.cyclesBeforeLongBreak;
    }
    _selectedTab = _isUsingDefaults ? 0 : 1;
  }

  void _updateWorkDuration(int value) {
    widget.onWorkDurationChanged(value);
  }

  void _updateShortBreakDuration(int value) {
    widget.onShortBreakChanged(value);
  }

  void _updateCyclesBeforeLongBreak(int value) {
    widget.onCyclesChanged(value);
  }

  void _resetToDefaults() {
    widget.onResetToDefaults();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Timer Settings',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildTabSelector(),
            const SizedBox(height: 24),
            if (_selectedTab == 0) _buildNormalTab() else _buildCustomTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedTab = 0);
                if (!_isUsingDefaults) {
                  _resetToDefaults();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 0 ? const Color(0xFF3B82F6) : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'Normal',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _selectedTab == 0 ? Colors.white : Colors.grey.shade600,
                    fontWeight: _selectedTab == 0 ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 1 ? const Color(0xFF3B82F6) : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'Custom',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _selectedTab == 1 ? Colors.white : Colors.grey.shade600,
                    fontWeight: _selectedTab == 1 ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNormalTab() {
    return Column(
      children: [
        Text(
          'Standard Pomodoro technique with proven defaults for optimal productivity.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 24),
        _InfoRow(label: 'Work Duration', value: '25 min'),
        const SizedBox(height: 12),
        _InfoRow(label: 'Break Duration', value: '5 min'),
        const SizedBox(height: 12),
        _InfoRow(label: 'Long Break After', value: '4 cycles'),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.blue.shade700, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'After 4 work sessions, you\'ll get a longer 15 min break.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue.shade700,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomTab() {
    return Column(
      children: [
        Text(
          'Customize your focus sessions to match your workflow.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 24),
        _SettingRow(
          label: 'Work Duration',
          value: '$_workDuration min',
          onTap: () => _showDurationPicker(
            context,
            'Work Duration',
            _workDuration,
            5,
            60,
            _updateWorkDuration,
          ),
        ),
        const SizedBox(height: 12),
        _SettingRow(
          label: 'Break Duration',
          value: '$_shortBreakDuration min',
          onTap: () => _showDurationPicker(
            context,
            'Break Duration',
            _shortBreakDuration,
            1,
            30,
            _updateShortBreakDuration,
          ),
        ),
        const SizedBox(height: 12),
        _SettingRow(
          label: 'Cycles Before Long Break',
          value: '$_cyclesBeforeLongBreak',
          onTap: () => _showCyclesPicker(context),
        ),
      ],
    );
  }

  String _getDescriptionForTitle(String title) {
    switch (title) {
      case 'Work Duration':
        return 'How long each focus session lasts';
      case 'Break Duration':
        return 'Rest time between work sessions';
      case 'Cycles Amount':
        return 'Work sessions before a long break';
      default:
        return '';
    }
  }

  void _showDurationPicker(
    BuildContext context,
    String title,
    int currentValue,
    int min,
    int max,
    Function(int) onChanged,
  ) {
    final rootContext = context;
    final description = _getDescriptionForTitle(title);
    final String unit = title == 'Cycles Amount' ? '' : ' min';

    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: rootContext,
        builder: (pickerContext) => Material(
          color: Colors.transparent,
          child: Container(
            height: 280,
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground.resolveFrom(pickerContext),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40,
                    scrollController: FixedExtentScrollController(
                      initialItem: currentValue - min,
                    ),
                    onSelectedItemChanged: (index) {
                      onChanged(min + index);
                    },
                    children: List.generate(
                      max - min + 1,
                      (index) => Center(
                        child: Text(
                          '${min + index}$unit',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      showModalBottomSheet(
        context: rootContext,
        backgroundColor: Colors.transparent,
        builder: (pickerContext) => Material(
          color: Colors.transparent,
          child: Container(
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    perspective: 0.005,
                    controller: FixedExtentScrollController(
                      initialItem: currentValue - min,
                    ),
                    onSelectedItemChanged: (index) {
                      onChanged(min + index);
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: max - min + 1,
                      builder: (ctx, index) => Center(
                        child: Text(
                          '${min + index}$unit',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    }
  }

  void _showCyclesPicker(BuildContext context) {
    _showDurationPicker(
      context,
      'Cycles Amount',
      _cyclesBeforeLongBreak,
      1,
      10,
      _updateCyclesBeforeLongBreak,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _SettingRow({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
