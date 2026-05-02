import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/lost_found.dart';
import '../../services/api_client.dart';
import '../../services/lost_found_service.dart';
import '../../widgets/item_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';

class MyPublishesPage extends StatefulWidget {
  const MyPublishesPage({super.key});

  @override
  State<MyPublishesPage> createState() => _MyPublishesPageState();
}

class _MyPublishesPageState extends State<MyPublishesPage> {
  late final LostFoundService _service;

  List<LostFoundItem> _allItems = [];
  bool _loading = true;
  String? _error;

  static const _tabs = <String>['all', 'pending', 'claimed', 'closed'];
  static const _tabLabels = <String>['全部', '待认领', '已认领', '已结束'];
  String _activeTab = 'all';

  @override
  void initState() {
    super.initState();
    _service = LostFoundService(apiClient: ApiClient.instance);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      _allItems = await _service.myList();
      setState(() => _loading = false);
    } catch (e) {
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  List<LostFoundItem> get _filteredItems {
    if (_activeTab == 'all') return _allItems;
    return _allItems.where((item) => item.status == _activeTab).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的发布'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: _buildTabBar(),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildTabBar() {
    return Container(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: List.generate(_tabs.length, (i) {
            final selected = _activeTab == _tabs[i];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(_tabLabels[i]),
                selected: selected,
                onSelected: (_) => setState(() => _activeTab = _tabs[i]),
                visualDensity: VisualDensity.compact,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return ErrorState(message: _error!, onRetry: _loadData);
    }
    final items = _filteredItems;
    if (items.isEmpty) {
      return const EmptyState(
        icon: Icons.list_alt_outlined,
        message: '暂无发布记录',
      );
    }
    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) => _buildItemCard(items[index]),
      ),
    );
  }

  Widget _buildItemCard(LostFoundItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Stack(
        children: [
          ItemCard(
            item: item,
            onTap: () => context.go('/lost-found/${item.id}'),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: _buildActionButtons(item),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(LostFoundItem item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.status == 'pending') ...[
          _ActionChip(
            label: '关闭',
            icon: Icons.cancel_outlined,
            color: Colors.orange,
            onTap: () => _showCloseDialog(item),
          ),
        ],
        if (item.status == 'closed') ...[
          _ActionChip(
            label: '重开',
            icon: Icons.refresh,
            color: Colors.green,
            onTap: () => _showReopenDialog(item),
          ),
        ],
        const SizedBox(width: 4),
        _ActionChip(
          label: '删除',
          icon: Icons.delete_outline,
          color: Colors.red,
          onTap: () => _showDeleteDialog(item),
        ),
      ],
    );
  }

  Future<void> _showCloseDialog(LostFoundItem item) async {
    final controller = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('关闭发布'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '请输入关闭原因',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('确认关闭'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (confirmed == true && mounted) {
      try {
        await _service.close(item.id, controller.text.trim());
        await _loadData();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('关闭失败: $e')),
          );
        }
      }
    }
  }

  Future<void> _showReopenDialog(LostFoundItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('重新开启'),
        content: const Text('确定要重新开启这条发布吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('确认'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      try {
        await _service.reopen(item.id);
        await _loadData();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('重开失败: $e')),
          );
        }
      }
    }
  }

  Future<void> _showDeleteDialog(LostFoundItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除发布'),
        content: const Text('删除后不可恢复，确定要继续吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      try {
        await _service.delete(item.id);
        await _loadData();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('删除失败: $e')),
          );
        }
      }
    }
  }
}

class _ActionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 15, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
