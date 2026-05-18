import 'package:flutter/material.dart';

class SimulationResultScreen extends StatelessWidget {
  final int budget;
  final int days;
  final int people;

  const SimulationResultScreen({
    super.key,
    required this.budget,
    required this.days,
    required this.people,
  });

  String formatRupiah(int number) {
    return number
        .toString()
        .replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
        );
  }

  @override
  Widget build(BuildContext context) {
    final budgetPerDay = budget ~/ days;
    final budgetPerPerson =
        budget ~/ people;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(
                              16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.04),
                          blurRadius: 20,
                          offset: const Offset(
                            0,
                            8,
                          ),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons
                            .arrow_back_ios_new_rounded,
                        color: Color(0xFF2ECC71),
                        size: 20,
                      ),
                    ),
                  ),

                  const Spacer(),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFF2ECC71,
                      ).withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(
                              100),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons
                              .auto_awesome_rounded,
                          color: Color(0xFF2ECC71),
                          size: 18,
                        ),

                        SizedBox(width: 8),

                        Text(
                          "AI Result",
                          style: TextStyle(
                            fontWeight:
                                FontWeight.w700,
                            color: Color(
                              0xFF2ECC71,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // Title
              const Text(
                "Rencana Makananmu\nSudah Siap 🎉",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                "AI telah membuat rekomendasi makanan berdasarkan budget dan kebutuhanmu.",
                style: TextStyle(
                  fontSize: 16,
                  height: 1.7,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 32),

              // Summary Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2ECC71),
                      Color(0xFF27AE60),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius:
                      BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xFF2ECC71,
                      ).withOpacity(0.25),
                      blurRadius: 30,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.restaurant_menu,
                          color: Colors.white,
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Ringkasan Plan",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: buildSummaryItem(
                            "Budget",
                            "Rp ${formatRupiah(budget)}",
                          ),
                        ),

                        Expanded(
                          child: buildSummaryItem(
                            "Durasi",
                            "$days Hari",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: buildSummaryItem(
                            "Orang",
                            "$people Orang",
                          ),
                        ),

                        Expanded(
                          child: buildSummaryItem(
                            "Per Hari",
                            "Rp ${formatRupiah(budgetPerDay)}",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // AI Insight
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.04),
                      blurRadius: 20,
                      offset: const Offset(
                        0,
                        8,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons
                              .lightbulb_rounded,
                          color: Color(0xFF2ECC71),
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Insight AI",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Text(
                      "Dengan budget ini, kamu dapat membuat pola makan yang cukup sehat dan seimbang untuk $people orang selama $days hari.",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.7,
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      "AI merekomendasikan menu tinggi protein sederhana, sayuran segar, dan makanan rumahan agar budget tetap hemat namun nutrisi tetap terjaga.",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.7,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Recommendation Card
              const Text(
                "Rekomendasi Menu",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              buildFoodCard(
                title: "Nasi Ayam Sayur",
                calories: "420 kcal",
                price: "Rp 18.000",
                icon: Icons.lunch_dining,
              ),

              buildFoodCard(
                title: "Oatmeal Buah",
                calories: "250 kcal",
                price: "Rp 12.000",
                icon: Icons.breakfast_dining,
              ),

              buildFoodCard(
                title: "Tumis Tempe Brokoli",
                calories: "390 kcal",
                price: "Rp 15.000",
                icon: Icons.ramen_dining,
              ),

              const SizedBox(height: 30),

              // Nutrition Card
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.04),
                      blurRadius: 20,
                      offset: const Offset(
                        0,
                        8,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Color(0xFF2ECC71),
                        ),

                        const SizedBox(width: 10),

                        const Text(
                          "Estimasi Nutrisi",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const Spacer(),

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF2ECC71,
                            ).withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(
                                    100),
                          ),
                          child: const Text(
                            "Seimbang",
                            style: TextStyle(
                              color: Color(
                                0xFF2ECC71,
                              ),
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        buildNutritionItem(
                          "Protein",
                          "85g",
                        ),

                        buildNutritionItem(
                          "Karbo",
                          "210g",
                        ),

                        buildNutritionItem(
                          "Lemak",
                          "55g",
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF2ECC71),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              22),
                    ),
                  ),
                  child: const Text(
                    "Selesai",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSummaryItem(
    String title,
    String value,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(
              0.8,
            ),
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildFoodCard({
    required String title,
    required String calories,
    required String price,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.04,
            ),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: const Color(
                0xFF2ECC71,
              ).withOpacity(0.1),
              borderRadius:
                  BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              color: const Color(
                0xFF2ECC71,
              ),
              size: 30,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Text(
                      calories,
                      style: TextStyle(
                        color:
                            Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Text(
                      price,
                      style: TextStyle(
                        color:
                            Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget buildNutritionItem(
    String title,
    String value,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2ECC71),
          ),
        ),

        const SizedBox(height: 6),

        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}