import 'package:material_ui/material_ui.dart';

class SimulatedScribeAudioWidget extends StatefulWidget {
  final bool isGenerating;
  final VoidCallback onTriggerScribe;

  const SimulatedScribeAudioWidget({
    super.key,
    required this.isGenerating,
    required this.onTriggerScribe,
  });

  @override
  State<SimulatedScribeAudioWidget> createState() =>
      _SimulatedScribeAudioWidgetState();
}

class _SimulatedScribeAudioWidgetState extends State<SimulatedScribeAudioWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    if (widget.isGenerating) {
      _animController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant SimulatedScribeAudioWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isGenerating && !_animController.isAnimating) {
      _animController.repeat(reverse: true);
    } else if (!widget.isGenerating && _animController.isAnimating) {
      _animController.stop();
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isGenerating) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFBFDBFE)),
        ),
        child: Row(
          children: [
            FadeTransition(
              opacity: _animController,
              child: const Icon(Icons.mic, color: Color(0xFF0284C7)),
            ),
            const SizedBox(width: 10),
            const Text(
              'AI Clinical Scribe is processing ambient audio stream & synthesizing SOAP draft...',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E40AF),
              ),
            ),
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ),
      );
    }

    return OutlinedButton.icon(
      key: const Key('trigger_ai_scribe_button'),
      icon: const Icon(Icons.auto_awesome, color: Color(0xFF0284C7)),
      label: const Text('Simulate AI Clinical Scribe Dictation'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        side: const BorderSide(color: Color(0xFF0284C7)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: widget.onTriggerScribe,
    );
  }
}
