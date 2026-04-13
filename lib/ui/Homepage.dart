import 'package:flutter/material.dart';
import 'package:funax/services/funax_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final service = FunaxService();
  @override
  void initState() {
    super.initState();
    service.load_data().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
