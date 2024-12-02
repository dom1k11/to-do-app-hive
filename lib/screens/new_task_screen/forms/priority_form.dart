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
    return FormBuilderChoiceChip(
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
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
      options: const [
        FormBuilderChipOption(value: 'Low', child: Text('Low')),
        FormBuilderChipOption(value: 'Medium', child: Text('Medium')),
        FormBuilderChipOption(value: 'High', child: Text('High')),
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
