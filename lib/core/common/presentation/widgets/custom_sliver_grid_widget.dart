import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef ItemBuilder = Widget Function(BuildContext context, int index);

class CustomSliverGridWidget extends StatelessWidget {
  const CustomSliverGridWidget({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final ItemBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid.builder(
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: max(1, 2.w.toInt()),
        //   childAspectRatio: 2 / 3,
        //   crossAxisSpacing: 4.0,
        //   mainAxisSpacing: 4.0,
        // ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: size.width / 2.w,
          mainAxisExtent: size.height / 3.h,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
