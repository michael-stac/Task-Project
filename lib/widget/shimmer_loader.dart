import 'package:flutter/material.dart';

import '../utils/shimmer.dart';

class LoadingShimmerIndicator extends StatelessWidget {
  const LoadingShimmerIndicator({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const ShimmerWidget.rectangular(height: 200),
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            SizedBox(
              width: 100,
              child: ShimmerWidget.rectangular(height: 20),
            ),
            Spacer(),
            ShimmerWidget.circular(height: 20, width: 30),
          ],
        ),
        const SizedBox(height: 15),
        const Row(
          children: [
            Expanded(
              child: SizedBox(
                child: ShimmerWidget.rectangular(height: 25),
              ),
            ),
            Spacer(),
            Expanded(
              child: SizedBox(
                child: ShimmerWidget.rectangular(height: 25),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
