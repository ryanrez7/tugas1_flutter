import 'package:flutter/material.dart'; 
import 'screens/task_list_screen.dart'; 
import 'services/task_storage.dart'; 
 
class Modul05App extends StatelessWidget { 
  const Modul05App({super.key}); 
 
  @override 
  Widget build(BuildContext context) { 
    // Jalankan dengan: flutter run --dart-define=LAMBAT=true 
    // untuk membuktikan keadaan "memuat". 
    const bool lambat = bool.fromEnvironment('LAMBAT'); 
    const TaskStorage storage = TaskStorage( 
      tunda: lambat ? Duration(seconds: 2) : Duration.zero, 
    ); 
 
    return MaterialApp( 
      title: 'Modul 05 - Tugas Praktikum', 
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true), 
      home: const TaskListScreen(storage: storage), 
    ); 
  } 
} 