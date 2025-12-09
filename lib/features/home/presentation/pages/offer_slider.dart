import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../offers/presentation/cubit/offers_cubit.dart';
import '../../../offers/presentation/cubit/offers_state.dart';
import '../../../offers/presentation/widgets/offers_slider_widget.dart';

class OfferSlider extends StatelessWidget {
  const OfferSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersCubit, OffersState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          ),
          loaded: (offers) => OffersSliderWidget(offers: offers),
          error: (message) => SizedBox(
            height: 180,
            child: Center(child: Text('Error loading offers: $message')),
          ),
        );
      },
    );
  }
}
