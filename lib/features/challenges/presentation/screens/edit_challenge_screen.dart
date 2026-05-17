import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/challenge_model.dart';
import '../bloc/challenge_bloc.dart';
import '../bloc/challenge_event.dart';
import '../bloc/challenge_state.dart';

const kBrown = Color(0xFF795548);
const kCream = Color(0xFFFFF8F0);

class EditChallengeScreen extends StatefulWidget {
  final ChallengeModel challenge;

  const EditChallengeScreen({super.key, required this.challenge});

  @override
  State<EditChallengeScreen> createState() => _EditChallengeScreenState();
}

class _EditChallengeScreenState extends State<EditChallengeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _durationController;
  late String _selectedDifficulty;
  late bool _completed;

  final List<String> _difficulties = ['Easy', 'Medium', 'Hard'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.challenge.title);
    _descriptionController =
        TextEditingController(text: widget.challenge.description);
    _durationController =
        TextEditingController(text: widget.challenge.duration);
    _selectedDifficulty = widget.challenge.difficulty;
    _completed = widget.challenge.completed;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final updated = widget.challenge.copyWith(
      title: _titleController.text.trim(),
      difficulty: _selectedDifficulty,
      duration: _durationController.text.trim(),
      completed: _completed,
      description: _descriptionController.text.trim(),
    );

    context.read<ChallengeBloc>().add(UpdateChallenge(updated));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      appBar: AppBar(
        title: const Text('Edit Challenge'),
        backgroundColor: kBrown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocListener<ChallengeBloc, ChallengeState>(
        listener: (context, state) {
          if (state is ChallengeLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Challenge updated!'),
                backgroundColor: kBrown,
              ),
            );
            Navigator.pop(context);
          }
          if (state is ChallengeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ChallengeBloc, ChallengeState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildField(
                      controller: _titleController,
                      label: 'Challenge Title',
                      icon: Icons.fitness_center,
                    ),
                    const SizedBox(height: 16),
                    _buildField(
                      controller: _descriptionController,
                      label: 'Description',
                      icon: Icons.description,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    _buildField(
                      controller: _durationController,
                      label: 'Duration',
                      icon: Icons.timer,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedDifficulty,
                      dropdownColor: kCream,
                      decoration: InputDecoration(
                        labelText: 'Difficulty',
                        prefixIcon: const Icon(Icons.bar_chart, color: kBrown),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: kBrown),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      items: _difficulties
                          .map(
                              (d) => DropdownMenuItem(value: d, child: Text(d)))
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _selectedDifficulty = val!),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: SwitchListTile(
                        title: const Text('Mark as Completed'),
                        subtitle: const Text('Toggle if already done'),
                        value: _completed,
                        activeColor: kBrown,
                        onChanged: (val) => setState(() => _completed = val),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (state is ChallengeLoading)
                      const CircularProgressIndicator(color: kBrown)
                    else
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: _submit,
                          icon: const Icon(Icons.update),
                          label: const Text('Update Challenge',
                              style: TextStyle(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kBrown,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: kBrown),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: kBrown),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (v) => v == null || v.isEmpty ? 'Please enter $label' : null,
    );
  }
}
