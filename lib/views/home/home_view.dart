import 'package:assignment/constants.dart';
import 'package:assignment/models/room_model.dart';
import 'package:assignment/views/home/room_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rooms"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: kToolbarHeight,
              child: FutureBuilder<QuerySnapshot>(
                  future:
                      FirebaseFirestore.instance.collection("bookingss").get(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return snapshot.hasData
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2 * defaultPadding),
                            child: Text(
                              "You have ${snapshot.data!.docs.length} Bookings",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Text("");
                  }),
            ),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("rooms").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.docs.isEmpty
                        ? const Center(
                            child: Text("No results"),
                          )
                        : ListView(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding),
                            children: snapshot.data!.docs.map((e) {
                              RoomModel roomModel =
                                  RoomModel.fromDocumentSnapshot(e);
                              return RoomCard(
                                room: roomModel,
                              );
                            }).toList(),
                          );
                  }
                  if (snapshot.hasError) return Text(snapshot.error.toString());
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
