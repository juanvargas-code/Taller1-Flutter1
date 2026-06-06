import 'package:flutter/material.dart';
import '../models/university_model.dart';
import '../services/firestore_service.dart';
import 'university_form_screen.dart';

class UniversityListScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  UniversityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidades'),
        backgroundColor: const Color(0xFF2D6A4F),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<University>>(
        stream: _firestoreService.getUniversities(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final universities = snapshot.data ?? [];

          if (universities.isEmpty) {
            return const Center(child: Text('No hay universidades registradas.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: universities.length,
            itemBuilder: (context, index) {
              final uni = universities[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    uni.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('NIT: ${uni.nit}'),
                      Text('Dir: ${uni.direccion}'),
                      Text('Tel: ${uni.telefono}'),
                      Text(
                        uni.paginaWeb,
                        style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _firestoreService.deleteUniversity(uni.id),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UniversityFormScreen(university: uni),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2D6A4F),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UniversityFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
