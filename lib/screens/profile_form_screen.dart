import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../data/models.dart';
import '../state/app_state.dart';
import '../widgets/common_widgets.dart';

class ProfileFormScreen extends StatefulWidget {
  const ProfileFormScreen({super.key});
  @override
  State<ProfileFormScreen> createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  final _age = TextEditingController(text: '25'), _w = TextEditingController(text: '70'), _h = TextEditingController(text: '175');
  String _goal = 'Maintain';

  Widget _field(String label, TextEditingController c) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: c, keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: label, filled: true, fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)),
        ),
      );

  void _save() {
    final age = int.tryParse(_age.text), w = double.tryParse(_w.text), h = double.tryParse(_h.text);
    if (age == null || w == null || h == null || age <= 0 || w <= 0 || h <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter valid numbers')));
      return;
    }
    appState.saveProfile(UserProfile(age, w, h, _goal));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent, title: const Text('Fill in Data')),
        body: ListView(padding: const EdgeInsets.all(Sp.page), children: [
          _field('Age', _age), _field('Weight (kg)', _w), _field('Height (cm)', _h),
          Wrap(spacing: 8, children: [
            for (final g in ['Lose', 'Maintain', 'Gain'])
              ChoiceChip(label: Text(g), selected: _goal == g, onSelected: (_) => setState(() => _goal = g)),
          ]),
          const SizedBox(height: Sp.page),
          PillButton('Save', _save),
        ]),
      );
}
