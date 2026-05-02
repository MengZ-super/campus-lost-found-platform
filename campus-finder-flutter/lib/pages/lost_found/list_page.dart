import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/lost_found_list/lost_found_list_bloc.dart';
import '../../blocs/lost_found_list/lost_found_list_event.dart';
import '../../blocs/lost_found_list/lost_found_list_state.dart';
import '../../models/category.dart';
import '../../services/api_client.dart';
import '../../services/lost_found_service.dart';
import '../../services/category_service.dart';
import '../../widgets/item_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';

class LostFoundListPage extends StatelessWidget {
  const LostFoundListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final apiClient = context.read<ApiClient>();
    return BlocProvider(
      create: (_) => LostFoundListBloc(
        lostFoundService: LostFoundService(apiClient: apiClient),
        categoryService: CategoryService(apiClient: apiClient),
      )..add(const LostFoundListEvent.loadList()),
      child: const _LostFoundListView(),
    );
  }
}

class _LostFoundListView extends StatefulWidget {
  const _LostFoundListView();

  @override
  State<_LostFoundListView> createState() => _LostFoundListViewState();
}

class _LostFoundListViewState extends State<_LostFoundListView> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<LostFoundListBloc>().add(const LostFoundListEvent.loadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('失物招领')),
      body: BlocBuilder<LostFoundListBloc, LostFoundListState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => ErrorState(
              message: message,
              onRetry: () =>
                  context.read<LostFoundListBloc>().add(const LostFoundListEvent.loadList()),
            ),
            loaded: (items, currentPage, hasMore, categories, itemType,
                categoryId, status, keyword, isLoadingMore) {
              return Column(
                children: [
                  // Search bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => context
                          .read<LostFoundListBloc>()
                          .add(LostFoundListEvent.searchChanged(value)),
                      decoration: InputDecoration(
                        hintText: '搜索物品...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: keyword.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 20),
                                onPressed: () {
                                  _searchController.clear();
                                  context.read<LostFoundListBloc>().add(
                                      const LostFoundListEvent.searchChanged(''));
                                },
                              )
                            : null,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                      ),
                    ),
                  ),

                  // Filters
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Type tabs
                        Row(
                          children: [
                            _buildTypeChip(context, '全部', null, itemType),
                            const SizedBox(width: 8),
                            _buildTypeChip(context, '寻物', 'lost', itemType),
                            const SizedBox(width: 8),
                            _buildTypeChip(context, '招领', 'found', itemType),
                            const Spacer(),
                            // Category dropdown
                            _buildCategoryDropdown(context, categories, categoryId),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Status chips
                        _buildStatusChips(context, status),
                      ],
                    ),
                  ),

                  // Grid
                  Expanded(
                    child: items.isEmpty
                        ? const EmptyState(message: '暂无物品信息')
                        : GridView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.72,
                            ),
                            itemCount: items.length + _gridFooterCount(hasMore, isLoadingMore),
                            itemBuilder: (context, index) {
                              if (index >= items.length) {
                                return _buildGridFooter(hasMore, isLoadingMore);
                              }
                              final item = items[index];
                              return ItemCard(
                                item: item,
                                onTap: () => context.push('/lost-found/${item.id}'),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/publish'),
        icon: const Icon(Icons.add),
        label: const Text('发布'),
      ),
    );
  }

  Widget _buildTypeChip(
      BuildContext context, String label, String? value, String? current) {
    final selected = current == value || (value == null && current == null);
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        if (!selected) {
          context
              .read<LostFoundListBloc>()
              .add(LostFoundListEvent.filterChanged(itemType: value));
        }
      },
    );
  }

  Widget _buildCategoryDropdown(
      BuildContext context, List<Category> categories, int? current) {
    return SizedBox(
      width: 140,
      child: DropdownButtonFormField<int?>(
        initialValue: current,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
        ),
        isExpanded: true,
        isDense: true,
        hint: const Text('全部分类', style: TextStyle(fontSize: 13)),
        items: [
          const DropdownMenuItem<int?>(
            value: null,
            child: Text('全部分类', style: TextStyle(fontSize: 13)),
          ),
          ...categories.map(
            (c) => DropdownMenuItem<int?>(
              value: c.id,
              child: Text(c.name, style: const TextStyle(fontSize: 13)),
            ),
          ),
        ],
        onChanged: (value) {
          context
              .read<LostFoundListBloc>()
              .add(LostFoundListEvent.filterChanged(categoryId: value));
        },
      ),
    );
  }

  Widget _buildStatusChips(BuildContext context, String? current) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        FilterChip(
          label: const Text('全部'),
          selected: current == null,
          onSelected: (_) {
            if (current != null) {
              context
                  .read<LostFoundListBloc>()
                  .add(const LostFoundListEvent.filterChanged(status: null));
            }
          },
        ),
        FilterChip(
          label: const Text('待认领'),
          selected: current == 'pending',
          onSelected: (selected) {
            context.read<LostFoundListBloc>().add(
                  LostFoundListEvent.filterChanged(
                      status: selected ? 'pending' : null),
                );
          },
        ),
        FilterChip(
          label: const Text('已认领'),
          selected: current == 'claimed',
          onSelected: (selected) {
            context.read<LostFoundListBloc>().add(
                  LostFoundListEvent.filterChanged(
                      status: selected ? 'claimed' : null),
                );
          },
        ),
        FilterChip(
          label: const Text('已结束'),
          selected: current == 'closed',
          onSelected: (selected) {
            context.read<LostFoundListBloc>().add(
                  LostFoundListEvent.filterChanged(
                      status: selected ? 'closed' : null),
                );
          },
        ),
      ],
    );
  }

  int _gridFooterCount(bool hasMore, bool isLoadingMore) {
    if (isLoadingMore) return 1;
    if (!hasMore) return 1;
    return 0;
  }

  Widget _buildGridFooter(bool hasMore, bool isLoadingMore) {
    if (isLoadingMore) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }
    return Center(
      child: Text(
        '没有更多了',
        style: TextStyle(
          fontSize: 13,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
