import 'package:flutter/material.dart';

class EstadisticaScreen extends StatefulWidget {
  @override
  _EstadisticaScreenState createState() => _EstadisticaScreenState();
}

class _EstadisticaScreenState extends State<EstadisticaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Aquí irán las estadísticas',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la lógica para actualizar las estadísticas
              },
              child: Text('Actualizar estadísticas'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Estadísticas de rendimiento en tareas',
    home: EstadisticaScreen(),
  ));
}
