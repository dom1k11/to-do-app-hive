import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:to_do_app_hive/contollers/form_controllers.dart';

class PriorityForm extends StatefulWidget {
  const PriorityForm({super.key});

  @override
  State<PriorityForm> createState() => _PriorityFormState();
}

class _PriorityFormState extends State<PriorityForm> {
  String selectedPriority = 'Low';
  Color selectedColor = Colors.grey;

  void updateColor(String value) {
    setState(() {
      selectedPriority = value;
      switch (value) {
        case 'Low':
          selectedColor = Colors.green;
          break;
        case 'Medium':
          selectedColor = Colors.yellow;
          break;
        case 'High':
          selectedColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double chipWidth = (screenWidth/2);

    double textSize = (screenWidth / 25).clamp(8.0, 36.0);
    return FormBuilderChoiceChip(
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      runAlignment: WrapAlignment.center,
      direction: Axis.vertical,
      spacing: 8,
      elevation: 16,
      showCheckmark: false,
      alignment: WrapAlignment.center,
      selectedColor: selectedColor,
      backgroundColor: Colors.orange,
      name: 'priority',
      labelPadding: const EdgeInsets.symmetric(horizontal: 50),
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
      ),
      options: [
        FormBuilderChipOption(
            value: 'Low',
            child: Container(
                width: chipWidth,
                height: 50,
                child:  Center(
                  child: Text('Low',
                      style: TextStyle(
                          fontSize: textSize,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold)),
                ))),
        FormBuilderChipOption(
            value: 'Medium',
            child: Container(
                width: chipWidth,
                height: 50,
                child: Center(
                    child: Text(
                  'Medium',
                  style: TextStyle(
                      fontSize: textSize,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold),
                )))),
        FormBuilderChipOption(
            value: 'High',
            child: Container(
                width: chipWidth,
                height: 50,
                child: Center(
                    child: Text('High',
                        style: TextStyle(
                            fontSize: textSize,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold))))),
      ],
      onChanged: (value) {
        taskPriorityController.text = value.toString();
        updateColor(value.toString());
      },
      validator: (value) {
        if (value == null) {
          return "Please select a priority";
        }
        return null;
      },
    );
  }
}
