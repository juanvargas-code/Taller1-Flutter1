import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class EvidenceScreen extends StatelessWidget {
  const EvidenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Evidencia de Sesión'),
        backgroundColor: const Color(0xFF2575FC),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authProvider.logout(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Información Almacenada',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'Datos de Usuario (SharedPreferences)',
              icon: Icons.person_outline,
              content: 'Nombre: ${user?.name ?? "N/A"}\nEmail: ${user?.email ?? "N/A"}',
              color: Colors.blue.shade50,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'Estado del Token (SecureStorage)',
              icon: Icons.security_outlined,
              content: authProvider.status == AuthStatus.authenticated
                  ? 'TOKEN PRESENTE'
                  : 'SIN TOKEN',
              color: Colors.green.shade50,
              contentColor: Colors.green.shade700,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.redAccent),
                  foregroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => authProvider.logout(),
                icon: const Icon(Icons.delete_forever),
                label: const Text('CERRAR SESIÓN Y LIMPIAR DATOS'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required String content,
    required Color color,
    Color? contentColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black54),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          ),
          const Divider(),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: contentColor ?? Colors.black87,
              height: 1.5,
              fontWeight: contentColor != null ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
