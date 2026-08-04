import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/sightings_view_model.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/custom_button.dart';

class AddSightingDialog extends StatefulWidget {
  const AddSightingDialog({super.key});

  @override
  State<AddSightingDialog> createState() => _AddSightingDialogState();
}

class _AddSightingDialogState extends State<AddSightingDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descController = TextEditingController();

  String _objectType = 'Esfera Lumínica';
  String _frequencyType = 'Armonía';

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final vm = context.read<SightingsViewModel>();
      final success = await vm.addSighting(
        title: _titleController.text,
        objectType: _objectType,
        frequencyType: _frequencyType,
        locationName: _locationController.text,
        description: _descController.text,
      );

      if (mounted) {
        if (success) {
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(vm.errorMessage ?? 'Error al guardar')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text('Reportar Avistamiento', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: _titleController,
                labelText: 'Título',
                prefixIcon: Icons.title,
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _objectType,
                decoration: const InputDecoration(labelText: 'Tipo de Objeto', prefixIcon: Icon(Icons.rocket_launch)),
                items: ['Esfera Lumínica', 'Platillo Volador', 'Nave Nodriza', 'Eco Pleyadiano']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _objectType = v!),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _frequencyType,
                decoration: const InputDecoration(labelText: 'Frecuencia Detectada', prefixIcon: Icon(Icons.waves)),
                items: ['Ultra-Baja', 'Armonía', 'Aguda']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _frequencyType = v!),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _locationController,
                labelText: 'Ubicación',
                prefixIcon: Icons.location_on,
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _descController,
                labelText: 'Descripción',
                prefixIcon: Icons.description,
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
        ),
        CustomButton(
          text: 'Reportar',
          onPressed: _submit,
          icon: Icons.send,
        ),
      ],
    );
  }
}
