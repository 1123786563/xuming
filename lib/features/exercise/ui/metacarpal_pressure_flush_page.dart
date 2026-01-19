import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'base_exercise_page.dart';

/// 掌骨压力排空页面 (Variant 2) - 使用基类重构
class MetacarpalPressureFlushPage extends ConsumerWidget {
  const MetacarpalPressureFlushPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const BaseExercisePage(
      title: "掌骨压力排空",
      taskName: "MANUAL DATA FLUSH",
      procedureId: "MT_02_CARPAL",
      themeColor: Color(0xFF00EAFF),
      quote: "Your hands were built for tools, not just for endless scrolling and clicking.",
      visualFeedback: _MetacarpalVisuals(),
    );
  }
}

class _MetacarpalVisuals extends StatefulWidget {
  const _MetacarpalVisuals();

  @override
  State<_MetacarpalVisuals> createState() => _MetacarpalVisualsState();
}

class _MetacarpalVisualsState extends State<_MetacarpalVisuals> with SingleTickerProviderStateMixin {
  late AnimationController _scanlineController;
  static const Color _primaryCyan = Color(0xFF00EAFF);

  @override
  void initState() {
    super.initState();
    _scanlineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _scanlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C232F).withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _primaryCyan.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(color: _primaryCyan.withOpacity(0.1), blurRadius: 10, spreadRadius: -5),
              BoxShadow(color: _primaryCyan.withOpacity(0.2), blurRadius: 10),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCwc0Bt4oqM_QyY8ZjFu7pKSPfMP3Ks7N4Oa2HqQifj9aDTAMZ7vJedzlpgtf7hLoUkJL9Z3jwe6WuJ55WagIWOjJzAeafFbBLEESWCUKwQUOsNrOtR3NuoX6IKAkDWvCw7tThhHJ9WH64B_OGgUZv1Zwl-Xmt3fhTt6I7-0S54SzYL4B-U6s2bxT62XAAtFEFvsCCuWIE_hqc9lBSq2u5P45dYiIHNsoPUJwFYdGri9jOdE6Sy2mJ1KjCaaMvuGdM6ltIEzt4D4pQ',
                    fit: BoxFit.contain,
                    opacity: const AlwaysStoppedAnimation(0.8),
                  ),
                ),
              ),
              Positioned(
                top: 16, left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('X-AXIS: STABLE', style: GoogleFonts.jetBrainsMono(color: _primaryCyan.withOpacity(0.7), fontSize: 10)),
                    const SizedBox(height: 4),
                    Text('Y-AXIS: FLUSHING...', style: GoogleFonts.jetBrainsMono(color: _primaryCyan.withOpacity(0.7), fontSize: 10)),
                  ],
                ),
              ),
              Positioned(
                bottom: 16, right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('CARPAL INTEGRITY', style: GoogleFonts.jetBrainsMono(color: _primaryCyan.withOpacity(0.7), fontSize: 10)),
                    const SizedBox(height: 4),
                    Text('88.4%', style: GoogleFonts.spaceGrotesk(color: _primaryCyan, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: _scanlineController,
                builder: (context, child) {
                  return Positioned(
                    top: _scanlineController.value * 300,
                    left: 0, right: 0,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, _primaryCyan.withOpacity(0.05), Colors.transparent],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
