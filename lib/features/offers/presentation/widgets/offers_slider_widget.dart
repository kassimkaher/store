import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_web/config/store_app.dart';
import 'package:store_web/core/widgets/offer_card.dart';
import 'package:store_web/features/offers/presentation/cubit/offers_cubit.dart';
import 'package:store_web/features/offers/presentation/cubit/offers_state.dart';

import '../../domain/entities/offer_entity.dart';

class OffersSliderWidget extends StatefulWidget {
  final List<OfferEntity> offers;

  const OffersSliderWidget({super.key, required this.offers});

  @override
  State<OffersSliderWidget> createState() => _OffersSliderWidgetState();
}

class _OffersSliderWidgetState extends State<OffersSliderWidget> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (widget.offers.isEmpty) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<OffersCubit, OffersState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('العروض ', style: textTheme.titleLarge),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'عرض الكل',
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 176,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(right: 16, left: 0),
                children: state.maybeWhen(
                  orElse: () => [],
                  loaded: (offers) => offers
                      .map(
                        (offer) => Row(
                          children: [
                            OfferCard(
                              title: offer.note ?? "",
                              badge: '',

                              imageUrl: "${offer.contentUrl}${offer.image}",
                              backgroundColor: const Color(0xFFE8F3F1),

                              onTap: () {},
                            ),
                            const SizedBox(width: 16),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
