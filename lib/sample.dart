// import 'package:flutter/material.dart';
// import '../../widget/widget.dart';

// class groupInfo extends StatefulWidget {
//   const groupInfo({super.key});

//   @override
//   State<groupInfo> createState() => _groupInfoState();
// }

// TextEditingController _controller = TextEditingController();
// TextEditingController _controller1 = TextEditingController();

// final List<DropdownMenuItem<String>> dropdownItems = [
//   DropdownMenuItem(
//     value: 'item1',
//     child: Text('Item 1'),
//   ),
//   DropdownMenuItem(
//     value: 'item2', 
//     child: Text('Item 2'),
//   ),
//   DropdownMenuItem(
//     value: 'item3',
//     child: Text('Item 3'),
//   ),
// ];

// String _selectedOption = 'Option 1';
// final List<String> _options = ['Option 1', 'Option 2', 'Option 3'];

// class _groupInfoState extends State<groupInfo> {

//   bool _isChecked = false;

//   // DateTime _selectedDate = DateTime.now();

//   void _handleDateSelected(DateTime date) {
//     print('Selected date: $date');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Kuanzisha Chomoka',
//         subtitle: 'Kuanzisha Chomoka',
//         showBackArrow: true,
//         // icon: Icons.settings,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             CustomTextField(
//               aboveText: 'Ingiza Jina La kikundi',
//               labelText: 'Jina la Kikundi',
//               hintText: 'Ingiza Jina La Kikundi',
//               controller: _controller, // Pass the controller here
//               obscureText: false,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             CustomTextField(
//               aboveText: 'Ingiza Jina La kikundi',
//               labelText: 'Jina la Kikundi',
//               hintText: 'Ingiza Jina La Kikundi',
//               controller: _controller, // Pass the controller here
//               obscureText: false,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             // CustomCalendar(
//             //   onDateSelected: _handleDateSelected,
//             //   labelText: 'Date of Birth',
//             //   hintText: 'Enter your date of birth',
//             //   aboveText: 'Please select your date of birth',
//             // ),
//             SizedBox(
//               height: 10,
//             ),
//             CustomDropdown<String>(
//               labelText: 'Choose an item',
//               hintText: 'Select an option',
//               items: dropdownItems,
//               value: 'item1', // Initial selected value
//               onChanged: (value) {
//                 print('Selected: $value');
//               },
//               validator: (value) {
//                 if (value == null) {
//                   return 'Please select an item';
//                 }
//                 return null;
//               },
//               aboveText:
//                   'Please choose an item from the dropdown', // Text above the dropdown
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             CustomCheckbox(
//               labelText: 'Accept Terms and Conditions',
//               hintText: 'Please read and accept the terms and conditions',
//               value: _isChecked,
//               onChanged: (bool newValue) {
//                 setState(() {
//                   _isChecked = newValue;
//                 });
//               },
//               aboveText: 'Terms and Conditions', // Text above the checkbox
//             ),
//             CustomRadioGroup<String>(
//               labelText: 'Select an option',
//               options: _options,
//               value: _selectedOption,
//               onChanged: (String newValue) {
//                 setState(() {
//                   _selectedOption = newValue;
//                 });
//               },
//               aboveText: 'Radio Button Group', // Text above the radio buttons
//             ),
//             CustomButton(
//               color: Color.fromARGB(255, 4, 34, 207),
//               buttonText: 'Flat Button',
//               onPressed: () {
//                 // Button press logic here
//                 print('Flat Button Pressed');
//               },
//               type: ButtonType.elevated,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
