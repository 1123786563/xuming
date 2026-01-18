import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/grid_background.dart';
import '../../../shared/widgets/scanline_overlay.dart';

/// 颈椎急救指引 (男)
class NeckFirstAidPage extends StatefulWidget {
  const NeckFirstAidPage({super.key});

  @override
  State<NeckFirstAidPage> createState() => _NeckFirstAidPageState();
}

class _NeckFirstAidPageState extends State<NeckFirstAidPage> with SingleTickerProviderStateMixin {
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
          // 1. 背景网格
          const GridBackground(
            gridColor: Color(0xFF00FF40), // Primary Green with low opacity handled by widget if customizable, here we might need to adjust or use default
            backgroundColor: Colors.transparent,
          ),
          
          // Custom Grid overlay for the specific look if needed, or rely on GridBackground
          // The design has a specific green grid. The GridBackground usually takes colors.
          // Let's assume GridBackground handles it well or we overlay a specific one.
          // The CSS says: linear-gradient(rgba(0, 255, 64, 0.05) ...
          
          // 2. 扫描线
          ScanlineOverlay(
            opacity: 0.1, 
            color: AppColors.lifeSignal.withOpacity(0.1),
          ),

          // 3. 内容
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: Stack(
                    children: [
                       // 3D Model & Markers
                       _buildCentralVisual(),
                       
                       // Right Stats
                       Positioned(
                         right: 16,
                         top: 24,
                         child: _buildRightStats(),
                       ),

                       // Left Stats
                       Positioned(
                         left: 16,
                         top: 24,
                         child: _buildLeftStats(),
                       ),
                    ],
                  ),
                ),
                _buildBottomPanel(),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        border: Border(bottom: BorderSide(color: AppColors.lifeSignal.withOpacity(0.2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.biotech, color: AppColors.lifeSignal, size: 24),
              const SizedBox(width: 8),
              Text(
                "MALE_BIO_SYNC_v2.0",
                style: AppTypography.pixelBody.copyWith(
                  color: AppColors.lifeSignal.withOpacity(0.7),
                  fontSize: 12,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "颈部后收",
                style: AppTypography.pixelHeadline.copyWith(
                  color: AppColors.lifeSignal,
                  fontSize: 20,
                  letterSpacing: 2,
                  shadows: [
                     Shadow(color: AppColors.lifeSignal.withOpacity(0.7), blurRadius: 10),
                  ],
                ),
              ),
              Text(
                "NECK RETRACTION",
                style: AppTypography.monoDecorative.copyWith(
                  color: AppColors.lifeSignal.withOpacity(0.4),
                  fontSize: 8,
                  letterSpacing: 4,
                ),
              ),
            ],
          ),
          Container(
            width: 48,
            alignment: Alignment.centerRight,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.lifeSignal,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(color: AppColors.lifeSignal, blurRadius: 8, spreadRadius: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "INTENSITY_LVL",
              style: AppTypography.pixelBody.copyWith(
                color: AppColors.lifeSignal.withOpacity(0.6),
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.lifeSignal.withOpacity(0.05),
                border: Border.all(color: AppColors.lifeSignal),
              ),
              child: Text(
                "Level 1: Gentle",
                style: AppTypography.monoBody.copyWith(
                  color: AppColors.lifeSignal,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "REMAINING_CYCLE",
              style: AppTypography.pixelBody.copyWith(
                color: AppColors.lifeSignal.withOpacity(0.6),
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.black.withOpacity(0.6),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: AppColors.lifeSignal, width: 2)),
                ),
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     Row(
                       mainAxisSize: MainAxisSize.min,
                       crossAxisAlignment: CrossAxisAlignment.baseline,
                       textBaseline: TextBaseline.alphabetic,
                       children: [
                         Text(
                           "00:45",
                           style: AppTypography.pixelHeadline.copyWith(
                             color: AppColors.lifeSignal,
                             fontSize: 48,
                             height: 1,
                             shadows: [
                               Shadow(color: AppColors.lifeSignal.withOpacity(0.7), blurRadius: 10),
                             ],
                           ),
                         ),
                         Text(
                           ".88",
                           style: AppTypography.pixelBody.copyWith(
                             color: AppColors.lifeSignal.withOpacity(0.7),
                             fontSize: 24,
                           ),
                         ),
                       ],
                     ),
                     const SizedBox(height: 4),
                     Text(
                       "MS_ACCURACY_ENABLED",
                       style: AppTypography.monoDecorative.copyWith(
                         color: AppColors.lifeSignal.withOpacity(0.4),
                         fontSize: 8,
                         letterSpacing: 2,
                       ),
                     ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLeftStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 12, top: 4, bottom: 4),
          decoration: BoxDecoration(
             border: Border(left: BorderSide(color: AppColors.lifeSignal.withOpacity(0.4))),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ANATOMICAL_ACCURACY: 98%",
                style: AppTypography.monoDecorative.copyWith(
                   color: AppColors.lifeSignal.withOpacity(0.8),
                   fontSize: 9,
                ),
              ),
              Text(
                "POSTURE_RECOGNITION: ACTIVE",
                style: AppTypography.monoDecorative.copyWith(
                   color: AppColors.lifeSignal.withOpacity(0.8),
                   fontSize: 9,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 64,
                height: 4,
                color: Colors.white.withOpacity(0.1),
                child: FractionallySizedBox(
                   alignment: Alignment.centerLeft,
                   widthFactor: 0.75,
                   child: Container(color: AppColors.lifeSignal),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
           width: 1,
           height: 128,
           decoration: BoxDecoration(
             gradient: LinearGradient(
               begin: Alignment.topCenter,
               end: Alignment.bottomCenter,
               colors: [
                 AppColors.lifeSignal.withOpacity(0.6),
                 AppColors.lifeSignal.withOpacity(0.1),
                 Colors.transparent,
               ],
             ),
           ),
           margin: const EdgeInsets.only(left: 4),
        )
      ],
    );
  }

  Widget _buildCentralVisual() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Image
            Image.network(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuCQOz-M1MswPCn_rbU0DDlXwER96ITjjoEmJRzFZDqDNU1OKcQkAHV4lg-eP6FGa3YPBj5HKrKjbT584_HRinbEsbWn5GO0e32ejvyiMkdRdr-vfhY--hEgnHHMlw3MSy2HRpmPkO_OAZpznUFJVznNcsbGV565VlvXkI1xt7xxlOSYhGRr33CCSQvaigComBa0Cy-M1J0M64ZHmDrtK68cYs5rCBujY9BLhvA4dasHyA8AvU8MO_NeqAHiYZDqx7n4a2QzWURAEQk",
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                 Icons.person,
                 size: 200,
                 color: AppColors.lifeSignal.withOpacity(0.2),
              ),
            ),
            
            // Markers
            // Spine Alignment Marker (Center-ish)
            Positioned(
              top: '34%', 
              left: '52%',
              child: FractionalTranslation(
                translation: const Offset(-0.5, -0.5),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Pulse Ring
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Container(
                          width: 48 * _pulseController.value + 20,
                          height: 48 * _pulseController.value + 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                               color: AppColors.lifeSignal.withOpacity(1 - _pulseController.value),
                            ),
                          ),
                        );
                      },
                    ),
                    // Dot
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.lifeSignal,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(color: AppColors.lifeSignal, blurRadius: 15, spreadRadius: 2),
                        ],
                      ),
                    ),
                    // Line and Label
                    Positioned(
                      left: 20,
                      child: Row(
                        children: [
                          Container(width: 48, height: 1, color: AppColors.lifeSignal.withOpacity(0.6)),
                          Container(
                             margin: const EdgeInsets.only(left: 64), // Offset for spacing 
                             child: Transform.translate(
                               offset: const Offset(-64, 0), // Pull back
                               child: Padding(
                                 padding: const EdgeInsets.only(left: 64),
                                 child: Container(
                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                   decoration: BoxDecoration(
                                     color: Colors.black.withOpacity(0.6),
                                     border: const Border(left: BorderSide(color: AppColors.lifeSignal, width: 2)),
                                   ),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(
                                         "C_SPINE_ALIGMENT",
                                         style: AppTypography.monoDecorative.copyWith(
                                           color: AppColors.lifeSignal,
                                           fontSize: 9, 
                                           fontWeight: FontWeight.bold,
                                         ),
                                       ),
                                       Text(
                                         "STRETCH_RATIO: 1.12x",
                                         style: AppTypography.monoDecorative.copyWith(
                                           color: Colors.white.withOpacity(0.5),
                                           fontSize: 7,
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Scapula Marker
            Positioned(
               top: '48%',
               left: '45%',
               child: FractionalTranslation(
                 translation: const Offset(-0.5, 0),
                 child: Stack(
                   clipBehavior: Clip.none,
                   alignment: Alignment.center,
                   children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.lifeSignal.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.lifeSignal.withOpacity(0.6)),
                        ),
                      ),
                      Positioned(
                        right: 12, 
                        child: Row(
                          children: [
                             Text(
                               "Scapula_Lock",
                               style: AppTypography.monoDecorative.copyWith(
                                 color: AppColors.lifeSignal.withOpacity(0.6),
                                 fontSize: 8,
                                 fontStyle: FontStyle.italic,
                               ),
                             ),
                             const SizedBox(width: 8),
                             Container(width: 32, height: 1, color: AppColors.lifeSignal.withOpacity(0.4)),
                          ],
                        ),
                      )
                   ],
                 ),
               ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
         color: Colors.black.withOpacity(0.9),
         border: Border(top: BorderSide(color: AppColors.lifeSignal.withOpacity(0.3))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        children: [
           // Quote
           Container(
             margin: const EdgeInsets.only(bottom: 24),
             child: Stack(
               clipBehavior: Clip.none,
               children: [
                  Positioned(
                    top: -16,
                    left: 0,
                    child: Row(
                      children: [
                         const Icon(Icons.terminal, color: AppColors.lifeSignal, size: 12),
                         const SizedBox(width: 4),
                         Text(
                           "Incoming_Comm: System",
                           style: AppTypography.monoDecorative.copyWith(
                             color: AppColors.lifeSignal.withOpacity(0.5),
                             fontSize: 8,
                             letterSpacing: 2,
                           ),
                         ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: AppColors.lifeSignal.withOpacity(0.3))),
                    ),
                    child: Text(
                      "\"If you can't even move your neck, how will you dodge the bullet of overwork?\"",
                      style: AppTypography.monoBody.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ),
               ],
             ),
           ),

           // Button
           GestureDetector(
             onTap: () => context.pop(), // Or finish action
             child: Container(
               height: 56,
               width: double.infinity,
               decoration: BoxDecoration(
                 color: AppColors.lifeSignal.withOpacity(0.1),
                 border: Border.all(color: AppColors.lifeSignal),
                 borderRadius: BorderRadius.circular(2),
               ),
               child: Stack(
                 alignment: Alignment.center,
                 children: [
                    // Hover effect logic could go here, keeping simple for now
                    Container(color: AppColors.lifeSignal.withOpacity(0.05)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.task_alt, color: AppColors.lifeSignal),
                        const SizedBox(width: 12),
                        Text(
                          "完成训练 / FINISH",
                          style: AppTypography.pixelHeadline.copyWith(
                            color: AppColors.lifeSignal,
                            fontSize: 20,
                            letterSpacing: 3,
                            shadows: [Shadow(color: AppColors.lifeSignal, blurRadius: 10)],
                          ),
                        ),
                      ],
                    ),
                    // Corner markers
                    const Positioned(top: 0, left: 0, child: _Corner(isTop: true, isLeft: true)),
                    const Positioned(bottom: 0, right: 0, child: _Corner(isTop: false, isLeft: false)),
                    Positioned(
                      right: 16,
                      child: Text(
                        "UID: 0x8821_REPAIR",
                        style: AppTypography.monoDecorative.copyWith(
                          color: AppColors.lifeSignal.withOpacity(0.3),
                          fontSize: 7,
                        ),
                      ),
                    )
                 ],
               ),
             ),
           ),
           
           const SizedBox(height: 16),
           Container(
             width: 96,
             height: 4,
             decoration: BoxDecoration(
               color: Colors.white.withOpacity(0.1),
               borderRadius: BorderRadius.circular(4),
             ),
           ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      height: 32,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Row(
             children: [
               Text("BUFFER: OPTIMAL", style: _footerStyle),
               const SizedBox(width: 16),
               Text("LATENCY: 12ms", style: _footerStyle),
             ],
           ),
           Text("©2024 XUMING_CORE_SYS", style: _footerStyle),
        ],
      ),
    );
  }

  TextStyle get _footerStyle => AppTypography.monoDecorative.copyWith(
    color: AppColors.lifeSignal.withOpacity(0.4),
    fontSize: 8,
    letterSpacing: 1,
  );
}

class _Corner extends StatelessWidget {
  final bool isTop;
  final bool isLeft;

  const _Corner({required this.isTop, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        border: Border(
           top: isTop ? const BorderSide(color: AppColors.lifeSignal) : BorderSide.none,
           bottom: !isTop ? const BorderSide(color: AppColors.lifeSignal) : BorderSide.none,
           left: isLeft ? const BorderSide(color: AppColors.lifeSignal) : BorderSide.none,
           right: !isLeft ? const BorderSide(color: AppColors.lifeSignal) : BorderSide.none,
        ),
      ),
    );
  }
}
