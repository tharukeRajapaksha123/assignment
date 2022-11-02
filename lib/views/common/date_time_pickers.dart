import 'package:assignment/views/common/date_formatter.dart';
import 'package:assignment/views/common/time_formatter.dart';
import 'package:flutter/material.dart';

class DatePickerFormFieldWithLabel extends StatefulWidget {
  final String label;
  final String? hintText;
  final DateTime? initialDate;
  final void Function(DateTime?)? onChangeDate;
  final String? errorText;
  const DatePickerFormFieldWithLabel({
    Key? key,
    this.initialDate,
    this.onChangeDate,
    this.label = "",
    this.hintText,
    this.errorText,
  }) : super(key: key);

  @override
  State<DatePickerFormFieldWithLabel> createState() =>
      _DatePickerFormFieldWithLabelState();
}

class _DatePickerFormFieldWithLabelState
    extends State<DatePickerFormFieldWithLabel> {
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    if (widget.initialDate != null) {
      dateController.text = formatDate(widget.initialDate!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: dateController,
          onTap: () async {
            DateTime? dateSelected = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 300)),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );

            if (widget.onChangeDate != null) {
              widget.onChangeDate!(dateSelected);
            }

            if (dateSelected != null) {
              dateController.text = formatDate(dateSelected);
            }
          },
          readOnly: true,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[400],
              hintText: widget.hintText,
              errorText: widget.errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.red))),
        ),
      ],
    );
  }
}

class TimePickerFormFieldWithLabel extends StatefulWidget {
  final String label;
  final String? hintText;
  final TimeOfDay? initialTime;
  final void Function(TimeOfDay?)? onChangeTime;

  const TimePickerFormFieldWithLabel({
    Key? key,
    this.initialTime,
    this.onChangeTime,
    this.label = "",
    this.hintText,
  }) : super(key: key);

  @override
  State<TimePickerFormFieldWithLabel> createState() =>
      _TimePickerFormFieldWithLabelState();
}

class _TimePickerFormFieldWithLabelState
    extends State<TimePickerFormFieldWithLabel> {
  final TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    if (widget.initialTime != null) {
      timeController.text = formatTime(widget.initialTime!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: timeController,
          onTap: () async {
            TimeOfDay time = widget.initialTime == null
                ? TimeOfDay.now()
                : widget.initialTime!;

            TimeOfDay? timeSelected = await showTimePicker(
              context: context,
              initialTime: time,
            );

            if (widget.onChangeTime != null) {
              widget.onChangeTime!(timeSelected);
            }

            if (timeSelected != null) {
              timeController.text = formatTime(timeSelected);
            }
          },
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFf8f8f8),
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
