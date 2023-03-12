import 'package:flutter/material.dart';

class SliverHeaderScrollView extends StatefulWidget {
  final String title;
  final List<Widget> slivers;
  // final ScrollController scrollController;
  final Widget? headerWidget;
  final bool canScroll;
  final VoidCallback? onNextPagePressed;
  final VoidCallback? onPreviousPagePressed;
  final int? currentPage;
  final int? pagesCount;

  const SliverHeaderScrollView({
    super.key,
    required this.title,
    required this.slivers,
    // required this.scrollController,
    this.headerWidget,
    this.canScroll = true,
    this.onNextPagePressed,
    this.onPreviousPagePressed,
    this.currentPage,
    this.pagesCount,
  });

  @override
  State<SliverHeaderScrollView> createState() => _SliverHeaderScrollViewState();
}

class _SliverHeaderScrollViewState extends State<SliverHeaderScrollView> {
    final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      physics: widget.canScroll ? null : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        _appBar(),
        if (widget.headerWidget != null) _headerContainer(context),
        ...widget.slivers,
      ],
    );
  }

  Widget _appBar() {
    return SliverAppBar.medium(
      pinned: true,
      title: Text(widget.title),
      actions: [
        if (widget.currentPage != null && widget.pagesCount != null) ...[
          IconButton(
            onPressed: widget.onPreviousPagePressed,
            icon: const Icon(Icons.navigate_before_rounded),
          ),
          Text("${widget.currentPage}/${widget.pagesCount}"),
          IconButton(
            onPressed: widget.onNextPagePressed,
            icon: const Icon(Icons.navigate_next_rounded),
          )
        ]
      ],
    );
  }

  Widget _headerContainer(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ClipRect(
          clipBehavior: Clip.antiAlias,
          child: AnimatedAlign(
            alignment: Alignment.topLeft,
            // heightFactor: _headerHeightFactor,
            duration: const Duration(milliseconds: 200),
            child: widget.headerWidget,
          ),
        ),
      ),
    );
  }
}
