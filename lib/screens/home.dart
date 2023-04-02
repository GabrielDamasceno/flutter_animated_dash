import 'package:flutter/material.dart';
import 'package:flutter_animated_dash/widgets/animated_dash.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AnimatedDash());
  }
}
