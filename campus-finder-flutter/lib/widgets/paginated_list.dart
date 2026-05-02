import 'package:flutter/material.dart';

class PaginatedList extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Future<void> Function() onLoadMore;
  final bool hasMore;
  final bool isLoading;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Widget? emptyWidget;
  final ScrollController? scrollController;

  const PaginatedList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.hasMore,
    required this.isLoading,
    this.separatorBuilder,
    this.emptyWidget,
    this.scrollController,
  });

  @override
  State<PaginatedList> createState() => _PaginatedListState();
}

class _PaginatedListState extends State<PaginatedList> {
  ScrollController? _controller;
  bool _loading = false;

  ScrollController get _sc => widget.scrollController ?? (_controller ??= ScrollController());

  @override
  void initState() {
    super.initState();
    _sc.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant PaginatedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollController != oldWidget.scrollController) {
      oldWidget.scrollController?.removeListener(_onScroll);
      widget.scrollController?.addListener(_onScroll);
      if (widget.scrollController == null && oldWidget.scrollController != null) {
        _controller?.removeListener(_onScroll);
        _controller = null;
      }
    }
  }

  @override
  void dispose() {
    _sc.removeListener(_onScroll);
    _controller?.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_sc.position.pixels >= _sc.position.maxScrollExtent - 100) {
      if (!_loading && widget.hasMore && !widget.isLoading) {
        _loading = true;
        widget.onLoadMore().then((_) {
          _loading = false;
        }).catchError((_) {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0 && !widget.isLoading) {
      return widget.emptyWidget ?? const SizedBox.shrink();
    }

    if (widget.itemCount == 0 && widget.isLoading) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    final children = <Widget>[];
    for (int i = 0; i < widget.itemCount; i++) {
      children.add(widget.itemBuilder(context, i));
      if (widget.separatorBuilder != null && i < widget.itemCount - 1) {
        children.add(widget.separatorBuilder!(context, i));
      }
    }

    if (widget.isLoading && widget.itemCount > 0) {
      children.add(
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
      );
    }

    if (!widget.hasMore && widget.itemCount > 0) {
      children.add(
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              '没有更多了',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      );
    }

    return ListView(
      controller: _sc,
      padding: widget.itemCount == 0 ? null : const EdgeInsets.all(12),
      children: children,
    );
  }
}
