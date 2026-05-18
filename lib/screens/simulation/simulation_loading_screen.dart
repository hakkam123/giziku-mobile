import 'dart:async';

import 'package:flutter/material.dart';

import 'simulation_result_screen.dart';

class SimulationLoadingScreen extends StatefulWidget {
  final int budget;
  final int days;
  final int people;

  const SimulationLoadingScreen({
    super.key,
    required this.budget,
    required this.days,
    required this.people,
  });

  @override
  State<SimulationLoadingScreen> createState() =>
      _SimulationLoadingScreenState();
}

class _SimulationLoadingScreenState
    extends State<SimulationLoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  int currentMessageIndex = 0;

  final List<String> loadingMessages = [
    "Menganalisis budget makanan...",
    "Menghitung kebutuhan nutrisi...",
    "Menyesuaikan porsi makanan...",
    "Mencari menu terbaik...",
    "Menyiapkan rekomendasi AI...",
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    startLoading();
  }

  Future<void> startLoading() async {
    for (int i = 0;
        i < loadingMessages.length;
        i++) {
      await Future.delayed(
        const Duration(milliseconds: 1200),
      );

      if (!mounted) return;

      setState(() {
        currentMessageIndex = i;
      });
    }

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SimulationResultScreen(
          budget: widget.budget,
          days: widget.days,
          people: widget.people,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            children: [
              const Spacer(),

              // AI Circle Animation
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle:
                        _animationController.value *
                        6.3,
                    child: Container(
                      width: 140,
                      height: 140,
                      padding: const EdgeInsets.all(
                          4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(
                          colors: [
                            const Color(0xFF2ECC71),
                            const Color(0xFF2ECC71)
                                .withOpacity(0.1),
                          ],
                        ),
                      ),
                      child: Container(
                        decoration:
                            const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          size: 54,
                          color: Color(0xFF2ECC71),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),

              // Title
              const Text(
                "AI Sedang Membuat\nRencana Makananmu",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 18),

              Text(
                "Tunggu sebentar, kami sedang\nmenyesuaikan menu terbaik untukmu.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.7,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 50),

              // Loading Messages
              Column(
                children: List.generate(
                  loadingMessages.length,
                  (index) {
                    final isActive =
                        index <= currentMessageIndex;

                    return AnimatedOpacity(
                      duration:
                          const Duration(
                            milliseconds: 400,
                          ),
                      opacity:
                          isActive ? 1 : 0.3,
                      child: Container(
                        margin:
                            const EdgeInsets.only(
                              bottom: 14,
                            ),
                        padding:
                            const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 16,
                            ),
                        decoration: BoxDecoration(
                          color:
                              isActive
                                  ? Colors.white
                                  : Colors.white
                                      .withOpacity(
                                        0.6,
                                      ),
                          borderRadius:
                              BorderRadius.circular(
                                20,
                              ),
                          border: Border.all(
                            color:
                                isActive
                                    ? const Color(
                                      0xFF2ECC71,
                                    ).withOpacity(
                                      0.2,
                                    )
                                    : Colors
                                        .transparent,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(
                                    0.04,
                                  ),
                              blurRadius: 20,
                              offset:
                                  const Offset(
                                    0,
                                    8,
                                  ),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration:
                                  BoxDecoration(
                                    color:
                                        isActive
                                            ? const Color(
                                              0xFF2ECC71,
                                            )
                                            : Colors
                                                .grey
                                                .shade300,
                                    shape:
                                        BoxShape
                                            .circle,
                                  ),
                              child: Icon(
                                isActive
                                    ? Icons.check
                                    : Icons
                                        .more_horiz,
                                color:
                                    Colors.white,
                                size: 18,
                              ),
                            ),

                            const SizedBox(
                              width: 14,
                            ),

                            Expanded(
                              child: Text(
                                loadingMessages[index],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                  color:
                                      isActive
                                          ? Colors
                                              .black
                                          : Colors
                                              .grey
                                              .shade500,
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

              const Spacer(),

              // Bottom Info
              Container(
                padding:
                    const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(22),
                  border: Border.all(
                    color: const Color(
                      0xFF2ECC71,
                    ).withOpacity(0.15),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.lightbulb_rounded,
                      color: Color(0xFF2ECC71),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Text(
                        "AI akan membuat rekomendasi menu berdasarkan budget, durasi, dan jumlah orang.",
                        style: TextStyle(
                          height: 1.5,
                          color:
                              Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}