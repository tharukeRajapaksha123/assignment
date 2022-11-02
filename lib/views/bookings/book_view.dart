// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:assignment/constants.dart';
import 'package:assignment/models/booking_model.dart';
import 'package:assignment/models/room_model.dart';
import 'package:assignment/views/common/date_time_pickers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BookView extends StatefulWidget {
  final RoomModel room;
  const BookView({
    Key? key,
    required this.room,
  }) : super(key: key);

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  final _key = GlobalKey<FormState>();

  final name = TextEditingController();

  DateTime? startDate;

  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book a room"),
      ),
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: name,
                validator: (val) => val != null
                    ? val.isEmpty
                        ? "Please enter customer name"
                        : null
                    : null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[400],
                  hintText: "Customer Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              DatePickerFormFieldWithLabel(
                hintText: "Start Date",
                label: "Start Date",
                onChangeDate: (DateTime? val) {
                  if (val != null) {
                    setState(() {
                      startDate = val;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              DatePickerFormFieldWithLabel(
                hintText: "End Date",
                label: "End Date",
                onChangeDate: (DateTime? val) {
                  if (val != null) {
                    setState(() {
                      endDate = val;
                    });
                  }
                },
              ),
              if (startDate != null && endDate != null)
                const SizedBox(
                  height: 8,
                ),
              if (startDate != null && endDate != null)
                Text(
                  "Total Bill is ${endDate!.difference(startDate!).inDays * widget.room.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    BookingModel bookingModel = BookingModel(
                        customersName: name.text,
                        startDate: startDate!.millisecondsSinceEpoch,
                        endDate: endDate!.millisecondsSinceEpoch,
                        roomId: widget.room.id);

                    await FirebaseFirestore.instance
                        .collection("bookingss")
                        .doc()
                        .set(bookingModel.toMap());

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Your booking set successfully")));
                    Navigator.pop(context);
                  }
                },
                child: Text("Create a booking"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
