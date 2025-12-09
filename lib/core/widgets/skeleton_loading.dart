import 'package:flutter/material.dart';

class SkeletonLoading extends StatefulWidget {
  const SkeletonLoading({super.key});

  @override
  State<SkeletonLoading> createState() => _SkeletonLoadingState();
}

class _SkeletonLoadingState extends State<SkeletonLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar Skeleton
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildShimmer(120, 16, borderRadius: 8),
                            const SizedBox(height: 8),
                            _buildShimmer(80, 12, borderRadius: 6),
                          ],
                        ),
                        Row(
                          children: [
                            _buildShimmer(40, 40, borderRadius: 20),
                            const SizedBox(width: 12),
                            _buildShimmer(40, 40, borderRadius: 20),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Search Bar Skeleton
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _buildShimmer(double.infinity, 56, borderRadius: 16),
                  ),

                  const SizedBox(height: 24),

                  // Offer Slider Skeleton
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: index < 2 ? 16 : 0),
                          child: _buildShimmer(300, 180, borderRadius: 24),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Categories Title Skeleton
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _buildShimmer(100, 24, borderRadius: 8),
                  ),

                  const SizedBox(height: 16),

                  // Categories Grid Skeleton
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.8,
                          ),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            _buildShimmer(80, 80, borderRadius: 16),
                            const SizedBox(height: 8),
                            _buildShimmer(60, 12, borderRadius: 6),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Products Title Skeleton
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _buildShimmer(120, 24, borderRadius: 8),
                  ),

                  const SizedBox(height: 16),

                  // Products Grid Skeleton
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.7,
                          ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildShimmer(
                                double.infinity,
                                140,
                                borderRadius: 24,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildShimmer(100, 14, borderRadius: 6),
                                    const SizedBox(height: 8),
                                    _buildShimmer(60, 12, borderRadius: 6),
                                    const SizedBox(height: 8),
                                    _buildShimmer(80, 16, borderRadius: 6),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            4,
            (index) => _buildShimmer(60, 40, borderRadius: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer(double width, double height, {double borderRadius = 8}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [
              _animation.value - 1,
              _animation.value,
              _animation.value + 1,
            ],
            colors: const [
              Color(0xFFE0E0E0),
              Color(0xFFF5F5F5),
              Color(0xFFE0E0E0),
            ],
          ),
        ),
      ),
    );
  }
}
