import 'package:flutter/material.dart';
import '../models/university_model.dart';
import '../services/firestore_service.dart';

class UniversityFormScreen extends StatefulWidget {
  final University? university;

  const UniversityFormScreen({super.key, this.university});

  @override
  State<UniversityFormScreen> createState() => _UniversityFormScreenState();
}

class _UniversityFormScreenState extends State<UniversityFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firestoreService = FirestoreService();

  late TextEditingController _nitController;
  late TextEditingController _nombreController;
  late TextEditingController _direccionController;
  late TextEditingController _telefonoController;
  late TextEditingController _webController;

  @override
  void initState() {
    super.initState();
    _nitController = TextEditingController(text: widget.university?.nit);
    _nombreController = TextEditingController(text: widget.university?.nombre);
    _direccionController = TextEditingController(text: widget.university?.direccion);
    _telefonoController = TextEditingController(text: widget.university?.telefono);
    _webController = TextEditingController(text: widget.university?.paginaWeb);
  }

  @override
  void dispose() {
    _nitController.dispose();
    _nombreController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _webController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final uni = University(
        id: widget.university?.id ?? '',
        nit: _nitController.text,
        nombre: _nombreController.text,
        direccion: _direccionController.text,
        telefono: _telefonoController.text,
        paginaWeb: _webController.text,
      );

      if (widget.university == null) {
        await _firestoreService.addUniversity(uni);
      } else {
        await _firestoreService.updateUniversity(uni.id, uni);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  String? _validateUrl(String? value) {
    if (value == null || value.isEmpty) return 'Campo requerido';
    final urlRegExp = RegExp(
        r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$');
    if (!urlRegExp.hasMatch(value)) return 'Ingrese una URL válida';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.university != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Universidad' : 'Nueva Universidad'),
        backgroundColor: const Color(0xFF2D6A4F),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField(_nitController, 'NIT', Icons.badge_outlined),
              _buildField(_nombreController, 'Nombre', Icons.business_outlined),
              _buildField(_direccionController, 'Dirección', Icons.location_on_outlined),
              _buildField(_telefonoController, 'Teléfono', Icons.phone_outlined, keyboardType: TextInputType.phone),
              _buildField(_webController, 'Página Web', Icons.language_outlined, validator: _validateUrl),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D6A4F),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _saveForm,
                  child: Text(
                    isEditing ? 'ACTUALIZAR' : 'GUARDAR',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: validator ?? (value) => value == null || value.isEmpty ? 'Requerido' : null,
      ),
    );
  }
}
