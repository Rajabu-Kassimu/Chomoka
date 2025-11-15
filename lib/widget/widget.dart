import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

//______________________________APP BAR_________________________________________

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showBackArrow;
  final IconData? icon;
  final VoidCallback? onIconPressed;
  final List<Widget>? additionalActions; // New property for additional actions
  final PreferredSizeWidget? bottom;

  CustomAppBar({
    required this.title,
    this.subtitle,
    this.showBackArrow = false,
    this.icon,
    this.onIconPressed,
    this.additionalActions, // Initialize additional actions
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize a list to hold all action widgets
    List<Widget> actionsList = [];

    // Add the primary icon if provided
    if (icon != null) {
      actionsList.add(
        IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: onIconPressed,
        ),
      );
    }

    // Add any additional actions if provided
    if (additionalActions != null && additionalActions!.isNotEmpty) {
      actionsList.addAll(additionalActions!);
    }

    return AppBar(
      backgroundColor: const Color.fromARGB(255, 42, 39, 241),
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => dashboard()));
              },
            )
          : null,
      titleSpacing: showBackArrow ? 0.0 : 16.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
        ],
      ),
      actions: actionsList.isNotEmpty ? actionsList : null,
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: bottom!.preferredSize,
              child: Container(
                color: const Color.fromARGB(255, 42, 39, 241),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 3,
                    fontWeight: FontWeight.w500,
                  ),
                  child: bottom!,
                ),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      ); // Adjust height to include bottom widget
}

//_____________________________LIST TILES_______________________________________

class ListTiles extends StatelessWidget {
  final Icon icon;
  final String title;
  final String mark;
  final VoidCallback? onTap;
  final Color tileColor;

  ListTiles({
    required this.icon,
    required this.title,
    required this.mark,
    this.onTap,
    this.tileColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      height: 70,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: onTap ?? () => print('$title tapped'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Icon with background
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: icon.color?.withOpacity(0.1) ??
                        Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: icon,
                ),
                SizedBox(width: 16),
                // Title
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                // Checkmark
                if (mark == 'completed')
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//_______________________________BUTTON_________________________________________

enum ButtonType { elevated, flat, outlined }

class CustomButton extends StatefulWidget {
  final Color color;
  final String buttonText;
  final VoidCallback onPressed;
  final ButtonType type;

  CustomButton({
    required this.color,
    required this.buttonText,
    required this.onPressed,
    this.type = ButtonType.elevated,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    Widget button;
    switch (widget.type) {
      case ButtonType.elevated:
        button = ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
          ),
          onPressed: widget.onPressed,
          child: Text(widget.buttonText,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        );
        break;
      case ButtonType.flat:
        button = TextButton(
          style: TextButton.styleFrom(
            foregroundColor: widget.color,
          ),
          onPressed: widget.onPressed,
          child: Text(widget.buttonText,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        );
        break;
      case ButtonType.outlined:
        button = OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: widget.color,
            side: BorderSide(color: widget.color),
          ),
          onPressed: widget.onPressed,
          child: Text(widget.buttonText,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        );
        break;
      default:
        button = ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
          ),
          onPressed: widget.onPressed,
          child: Text(widget.buttonText,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        );
    }

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: button,
    );
  }
}
//______________________________TEXT FIELD______________________________________

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final String? aboveText;

  CustomTextField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.aboveText,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  // void dispose() {
  //   widget.controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.aboveText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.aboveText!,
              style: TextStyle(
                fontSize: 16.0,
                color: const Color.fromARGB(255, 5, 5, 5),
              ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            border: OutlineInputBorder(),
          ),
          validator: widget.validator,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}

//_______________________________DROP DOWN______________________________________

class CustomDropdown<T> extends StatefulWidget {
  final String labelText;
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final String? aboveText;

  CustomDropdown({
    required this.labelText,
    required this.hintText,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.aboveText,
  });

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.aboveText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.aboveText!,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
        Container(
          // Restrict width to a percentage of the screen or allow adjustment
          width: MediaQuery.of(context).size.width * 0.95,
          child: DropdownButtonFormField<T>(
            value: widget.value,
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              border: OutlineInputBorder(),
            ),
            items: widget.items,
            onChanged: widget.onChanged,
            validator: widget.validator,
            // Ensures the dropdown expands within available space
            isExpanded: true,
          ),
        ),
      ],
    );
  }
}

//_______________________________CHECK BOX______________________________________

class CustomCheckbox extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? aboveText;
  CustomCheckbox({
    required this.labelText,
    required this.hintText,
    required this.value,
    required this.onChanged,
    this.aboveText,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.aboveText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.aboveText!,
              style: TextStyle(
                fontSize: 16.0,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        CheckboxListTile(
          title: Text(widget.labelText),
          subtitle: Text(widget.hintText),
          value: widget.value,
          onChanged: (bool? newValue) {
            if (newValue != null) {
              widget.onChanged(newValue);
            }
          },
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }
}

//_________________________________RADIO________________________________________

class CustomRadioGroup<T> extends StatefulWidget {
  final String labelText;
  final List<T> options;
  final T value;
  final ValueChanged<T> onChanged;
  final String? aboveText;
  CustomRadioGroup({
    required this.labelText,
    required this.options,
    required this.value,
    required this.onChanged,
    this.aboveText,
  });

  @override
  _CustomRadioGroupState<T> createState() => _CustomRadioGroupState<T>();
}

class _CustomRadioGroupState<T> extends State<CustomRadioGroup<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.aboveText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.aboveText!,
              style: TextStyle(
                fontSize: 16.0,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        Text(
          widget.labelText,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        ...widget.options.map((option) {
          return RadioListTile<T>(
            title: Text(option.toString()),
            value: option,
            groupValue: widget.value,
            onChanged: (T? newValue) {
              if (newValue != null) {
                widget.onChanged(newValue);
              }
            },
          );
        }).toList(),
      ],
    );
  }
}

//_________________________________CALENDAR________________________________________

class CustomCalendar extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final String labelText;
  final String hintText;
  final String aboveText;

  CustomCalendar({
    required this.onDateSelected,
    this.labelText = 'Select Date',
    this.hintText = 'yyyy-mm-dd',
    this.aboveText = '',
    required String? Function(dynamic value) validator,
  });

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _controller.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
      widget.onDateSelected(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.aboveText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.aboveText,
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            border: OutlineInputBorder(),
          ),
          readOnly: true,
          onTap: _pickDate,
        ),
      ],
    );
  }
}

//_______________________________MEMBER CARD____________________________________

class MemberCard extends StatelessWidget {
  final String image;
  final String memberNumber;
  final String name;
  final String phone;
  final VoidCallback onViewDetails;

  MemberCard({
    required this.image,
    required this.memberNumber,
    required this.name,
    required this.phone,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circular Avatar Image with fallback to user icon
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey[200],
              child: _getImageWidget(image),
            ),
            SizedBox(width: 12),

            // Member Number centered between Image and Name+Phone Column
            Text(
              memberNumber,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: 16),

            // Name and Phone in a Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    phone,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Eye Icon Button
            IconButton(
              icon: const Icon(
                Icons.remove_red_eye,
                color: Colors.blueGrey,
                size: 26,
              ),
              onPressed: onViewDetails,
              tooltip: 'View Details',
            ),
          ],
        ),
      ),
    );
  }

  /// Helper function to get Image Widget
  Widget _getImageWidget(String imagePath) {
    if (imagePath.isEmpty) {
      return Icon(Icons.person,
          size: 28, color: Colors.grey); // Fallback to user icon
    } else if (Uri.tryParse(imagePath)?.isAbsolute == true) {
      return ClipOval(
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: 56,
          height: 56,
          errorBuilder: (_, __, ___) {
            return Icon(Icons.person,
                size: 28, color: Colors.grey); // On error fallback
          },
        ),
      );
    } else {
      try {
        return ClipOval(
          child: Image.file(
            File(imagePath),
            fit: BoxFit.cover,
            width: 56,
            height: 56,
          ),
        );
      } catch (e) {
        return Icon(Icons.person,
            size: 28, color: Colors.grey); // On exception fallback
      }
    }
  }
}

//_______________________________IMAGE PICKER____________________________________

class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _image; // Holds the selected image
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Update with selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Weka Picha',
        showBackArrow: true,
        // icon: Icons.settings,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Image preview container with increased size
          _image == null
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Hakuna Picha.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 32, 19, 224)),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(_image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _pickImage(ImageSource.camera),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Color.fromARGB(255, 4, 34, 207),
                        ),
                        // Text(
                        //   'Chukua Picha',
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     color: Color.fromARGB(255, 4, 34, 207),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _pickImage(ImageSource.gallery),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.photo,
                          size: 30,
                          color: Color.fromARGB(255, 4, 34, 207),
                        ),
                        // Text(
                        //   'Kutoka kwa Matunzio',
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     color: Color.fromARGB(255, 4, 34, 207),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          if (_image != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                color: Color.fromARGB(255, 4, 34, 207),
                buttonText: 'Endelea',
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ()),
                  // );
                  print('Flat Button Pressed');
                },
                type: ButtonType.elevated,
              ),
            ),
        ],
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text('This is the next screen.'),
      ),
    );
  }
}
//_________________________________________________________________________

class CustomCard extends StatefulWidget {
  final String titleText;
  final VoidCallback? onEdit; // Make onEdit nullable
  final List<Map<String, String>> items; // List of description-value pairs

  CustomCard({
    required this.titleText,
    this.onEdit, // Make onEdit nullable in the constructor
    required this.items,
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.titleText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // If onEdit is null, reserve space with a SizedBox of width 24
              widget.onEdit != null
                  ? IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: widget.onEdit, // Callback for edit button
                    )
                  : SizedBox(width: 24), // Maintain space if onEdit is null
            ],
          ),
        ),
        SizedBox(height: 8),
        // Card widget
        Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.items.map((item) {
                return Container(
                  width: 500,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['description'] ?? '',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          item['value'] ?? '',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
