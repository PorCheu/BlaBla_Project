import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../../utils/date_time_utils.dart';
import '../../../theme/theme.dart';
import '../../../widgets/actions/bla_button.dart';
import '../../../widgets/inputs/location_picker.dart';

class RidePrefForm extends StatefulWidget {
  //
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
      departure = null;
      departureDate = DateTime.now();
      arrival = null;
      requestedSeats = 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void _swapLocations() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  Future<void> _selectDeparture() async {
    final selected = await showLocationPicker(context, title: 'Select Departure');
    if (selected != null) {
      setState(() {
        departure = selected;
      });
    }
  }

  Future<void> _selectArrival() async {
    final selected = await showLocationPicker(context, title: 'Select Arrival');
    if (selected != null) {
      setState(() {
        arrival = selected;
      });
    }
  }

   Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    
    if (picked != null) {
      setState(() {
        departureDate = picked;
      });
    }
  }

  void _onSearch() {
    if (departure == null || arrival == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('Please select both departure and arrival locations.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
  }
