import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:to_do_app_hive/contollers/form_controllers.dart';

class PriorityForm extends StatelessWidget {
  const PriorityForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderChoiceChip(
      spacing: 8,
      elevation: 16,
      showCheckmark: false,
      alignment: WrapAlignment.center,
      selectedColor: Colors.greenAccent,
      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
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
