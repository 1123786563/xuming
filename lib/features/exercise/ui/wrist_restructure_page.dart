import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yundong/core/theme/app_colors.dart';
import 'package:yundong/core/theme/app_typography.dart';

class WristRestructurePage extends StatefulWidget {
  const WristRestructurePage({super.key});

  @override
  State<WristRestructurePage> createState() => _WristRestructurePageState();
}

class _WristRestructurePageState extends State<WristRestructurePage> with TickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.void_,
      body: Stack(
        children: [
          // Scanline background effect (simplified if shared widget not available immediately, 
          // but I'll implement a simple gradient/line effect or use a shared one if I knew where it was.
          // For now, I'll stick to the background color and let the overlay do the work if I had it.
          // I will manually recreate the scanline effect from CSS using a shader or just an overlay image/gradient.
          // Simple CSS scanline: background: linear-gradient(to bottom, transparent 50%, rgba(0, 255, 0, 0.05) 51%); background-size: 100% 4px;
          Positioned.fill(
            child: CustomPaint(
              painter: _ScanlinePainter(),
            ),
          ),
          
          Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHUDStats(),
                      _buildCentralVisual(),
                      _buildTimerSection(),
                      _buildHeadlineAndQuote(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              _buildBottomBar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 12,
        left: 24,
        right: 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.void_,
        border: Border(bottom: BorderSide(color: Color(0x3300FF41))), // primary/20
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios, color: AppColors.lifeSignal, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TASK: WRIST_RESTRUCTURE',
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.lifeSignal,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    '手腕结构重组',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.lifeSignal,
                      shape: BoxShape.circle,
                    ),
                  ), // Animate pulse if needed
                  const SizedBox(width: 8),
                  Text(
                    'BIO_LINK: STABLE',
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.lifeSignal,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'ENCRYPTED_SIGNAL_0X4F',
                style: GoogleFonts.jetBrainsMono(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHUDStats() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      // grid gap 1px
      color: AppColors.lifeSignal.withOpacity(0.2),
      padding: const EdgeInsets.all(1), // border effect
      child: Row(
        children: [
          Expanded(child: _buildStatItem('Joint Tension', '42', 'PSI', false)),
          const SizedBox(width: 1), // gap
          Expanded(child: _buildStatItem('Sync Rate', '98.4', '%', true)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String unit, bool isPrimary) {
    return Container(
      color: AppColors.void_,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.lifeSignal.withOpacity(0.6),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: GoogleFonts.spaceGrotesk(
                  color: isPrimary ? AppColors.lifeSignal : Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit,
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCentralVisual() {
    return SizedBox(
      height: 400, // Fixed height for visual area or maintain aspect ratio
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulse Rings
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                   _buildPulseRing(1, 0.0),
                   _buildPulseRing(1.5, 0.5),
                ],
              );
            },
          ),
          
          // Main Image
           Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAbQ5rd_XUmGkEaHdmUg8WDr8elpRnxatr1aPIcJBKrT0pbKhzhbkrg-tuUn6yQKxE-IgCeR-6TFpMO7MRZi9KjEEpG5vWsjZ5QieW50GMhOdpAFhQ8ZQ9V0CahGwZ45jbfsfDt7iNLmnfs7ChppdIMDWtzvRMe4-hjcyjBNiEr2hg_ZDLHEwJbd-xMdnejFeNcYH9S3I6--IhO42-qN3-fTOUEvJ9n7t-PwoK1H4Y62ljOV5dHYQTXuP-NBKZQ5i1kSWh9SoRRJeM',
            fit: BoxFit.contain,
            width: 300,
            height: 300,
            color: Colors.white.withOpacity(0.9),
            colorBlendMode: BlendMode.modulate,
          ),
          
          // Joint Nodes (Hardcoded positions roughly matching image)
          // top: 40%, left: 45% -> relative to the 300x300 box
          // Ideally these should be relative to image, but hardcoding for now
          const Positioned(
            top: 130, // 40% of ~320ish area
            left: 0, right: 0,
            child: IgnorePointer(
               child: Center(
                 child: SizedBox(
                   width: 320, height: 320,
                   child: Stack(
                     children: [
                       Positioned(
                         top: 130, left: 145, 
                         child: _GlowingDot(size: 12, color: AppColors.lifeSignal),
                       ),
                        Positioned(
                         top: 175, left: 175, 
                         child: _GlowingDot(size: 8, color: Color(0x9900FF41)),
                       ),
                     ],
                   ),
                 ),
               ),
            )
          ),

          // Label
          Positioned(
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              color: AppColors.lifeSignal,
              child: Text(
                'Active: Wrist Extension',
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPulseRing(double scaleBase, double delay) {
     // simple ring simplified
     // Actually using AnimationController
     double value = (_pulseController.value + delay) % 1.0;
     double scale = 1.0 + (value * 0.1); // 1.0 to 1.1
     double opacity = 1.0 - value; // 1.0 to 0.0

    return Transform.scale(
      scale: scale,
      child: Opacity(
        opacity: opacity * 0.5,
        child: Container(
          width: 128 * scaleBase,
          height: 128 * scaleBase,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.lifeSignal.withOpacity(0.5), width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildTimerSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D20).withOpacity(0.5), // cyber-gray/50
        border: const Border.symmetric(horizontal: BorderSide(color: Color(0x3300FF41))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTimerUnit('00', 'HRS'),
          _buildColon(),
          _buildTimerUnit('00', 'MIN'),
          _buildColon(),
          _buildActiveTimerUnit('15', '234ms'),
        ],
      ),
    );
  }
  
  Widget _buildTimerUnit(String value, String label) {
    return Column(
      children: [
        Container(
          width: 64, height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.lifeSignal.withOpacity(0.1),
            border: Border.all(color: AppColors.lifeSignal.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.lifeSignal,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white.withOpacity(0.4),
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveTimerUnit(String sec, String ms) {
    return Column(
      children: [
        Container(
          width: 96, height: 56,
          decoration: BoxDecoration(
            color: AppColors.lifeSignal.withOpacity(0.2),
            border: Border.all(color: AppColors.lifeSignal.withOpacity(0.6)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
               Positioned.fill(child: Container(color: AppColors.lifeSignal.withOpacity(0.05))),
               Center(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                      Text(
                        sec,
                        style: GoogleFonts.spaceGrotesk(
                          color: AppColors.lifeSignal,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                          letterSpacing: -1,
                        ),
                      ),
                      Text(
                        ms,
                        style: GoogleFonts.jetBrainsMono(
                          color: AppColors.lifeSignal.withOpacity(0.6),
                          fontSize: 10,
                          height: 1.0,
                        ),
                      ),
                   ],
                 ),
               )
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'SEC_MS',
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white.withOpacity(0.4),
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildColon() {
     return const Text(
       ':',
       style: TextStyle(
         color: AppColors.lifeSignal,
         fontSize: 24,
         fontWeight: FontWeight.bold,
       ),
    );
  }

  Widget _buildHeadlineAndQuote() {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
       child: Column(
         children: [
           RichText(
             textAlign: TextAlign.center,
             text: TextSpan(
               style: GoogleFonts.spaceGrotesk(
                 color: Colors.white,
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
                 height: 1.3,
               ),
               children: const [
                 TextSpan(text: '保持腕部向后拉伸，\n感知'),
                 TextSpan(
                   text: '神经电流',
                   style: TextStyle(color: AppColors.lifeSignal),
                 ),
                 TextSpan(text: '的回流。'),
               ],
             ),
           ),
           const SizedBox(height: 16),
           Container(width: 48, height: 1, color: AppColors.lifeSignal.withOpacity(0.4)),
           const SizedBox(height: 16),
           Text(
             '"Don\'t let your hands turn into rigid claws."',
             textAlign: TextAlign.center,
             style: GoogleFonts.spaceGrotesk(
               color: Colors.white.withOpacity(0.6),
               fontSize: 14,
               fontStyle: FontStyle.italic,
             ),
           ),
         ],
       ),
     );
  }

  Widget _buildBottomBar() {
     return Container(
       padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
       decoration: const BoxDecoration(
         color: AppColors.void_,
         border: Border(top: BorderSide(color: Color(0x3300FF41))),
       ),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
            _buildBarIcon(Icons.analytics_outlined, 'Log', false),
            
            // Play Button
            Container(
              margin: const EdgeInsets.only(top: 0), // Adjust alignment if needed
              transform: Matrix4.translationValues(0, -24, 0), // float up
              child: Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  color: AppColors.lifeSignal,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.void_, width: 4),
                  boxShadow: const [
                    BoxShadow(color: Color(0x6600FF41), blurRadius: 20)
                  ],
                ),
                child: const Icon(Icons.play_arrow, color: Colors.black, size: 32),
              ),
            ),

            _buildBarIcon(Icons.accessibility_new, 'Action', true),
         ],
       ),
     );
  }

  Widget _buildBarIcon(IconData icon, String label, bool isActive) {
     return Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         Icon(
           icon, 
           color: isActive ? AppColors.lifeSignal : Colors.white.withOpacity(0.4),
           size: 24,
         ),
         const SizedBox(height: 4),
         Text(
           label.toUpperCase(),
           style: GoogleFonts.spaceGrotesk(
             color: isActive ? AppColors.lifeSignal : Colors.white.withOpacity(0.4),
             fontSize: 9,
             fontWeight: FontWeight.bold,
             letterSpacing: -0.5,
           ),
         ),
       ],
     );
  }
}

class _GlowingDot extends StatelessWidget {
   final double size;
   final Color color;
   
   const _GlowingDot({required this.size, required this.color});

   @override
   Widget build(BuildContext context) {
      return Container(
        width: size, height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: color, blurRadius: 10, spreadRadius: 2),
          ],
        ),
      );
   }
}

class _ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.5, 0.51],
        colors: [Colors.transparent, Color(0x0D00FF41)], // 0.05 opacity
        tileMode: TileMode.repeated,
      ).createShader(Rect.fromLTWH(0, 0, size.width, 4));
      
    // Applying shader to a rect across the whole screen? 
    // Shader tiling is tricky with `paint.shader`. 
    // Easier to just draw lines or use a giant rect filled with a pattern.
    // simpler approach: Draw 1px lines every 4px
    
    final linePaint = Paint()
      ..color = const Color(0x0D00FF41)
      ..strokeWidth = 1;
      
    for (double y = 0; y < size.height; y += 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
