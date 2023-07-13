import 'package:flutter/material.dart';

void main() {
  runApp(const SeatFinderApp());
}

class SeatFinderApp extends StatelessWidget {
  const SeatFinderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seat Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SeatFinderScreen(),
    );
  }
}

class SeatFinderScreen extends StatefulWidget {
  const SeatFinderScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SeatFinderScreenState createState() => _SeatFinderScreenState();
}

class _SeatFinderScreenState extends State<SeatFinderScreen> {
  final List<String> seatTypes = [
    'Lower',
    'Middle',
    'Upper',
    'Side Lower',
    'Side Upper',
  ];
  final int totalSeats = 72;
  int selectedSeat = -1;
  late TextEditingController seatNumberController;

  @override
  void initState() {
    super.initState();
    seatNumberController = TextEditingController();
  }

  @override
  void dispose() {
    seatNumberController.dispose();
    super.dispose();
  }

  void findSeat() {
    int? seatNumber = int.tryParse(seatNumberController.text);
    if (seatNumber != null &&
        seatNumber > 0 &&
        seatNumber <= totalSeats) {
      setState(() {
        selectedSeat = seatNumber;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Seat Details'),
            content: Text(
              '$seatNumber is ${seatTypes[(seatNumber - 1) % seatTypes.length]}',
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid Seat Number'),
            content: Text(
              'Please enter a valid seat number between 1 and $totalSeats.',
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Finder'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: seatNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Seat Number',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                ElevatedButton(
                  onPressed: findSeat,
                  child: const Text('Find'),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: totalSeats,
              itemBuilder: (BuildContext context, int index) {
                if (index % 5 == 3) {
                  return const SizedBox.shrink();
                } else {
                  bool isSelected =
                      selectedSeat != -1 && selectedSeat == (index + 1);
                  int seatIndex = (index) % seatTypes.length;
                  return Container(
                    color: isSelected ? Colors.red : Colors.blue,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (index + 1).toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            seatTypes[seatIndex],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
