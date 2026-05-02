import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/claim.dart';
import '../../services/api_client.dart';
import '../../services/claim_service.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';
import '../../utils/constants.dart';
import '../../utils/date_format.dart';

class MyClaimsPage extends StatefulWidget {
  const MyClaimsPage({super.key});

  @override
  State<MyClaimsPage> createState() => _MyClaimsPageState();
}

class _MyClaimsPageState extends State<MyClaimsPage> {
  late final ClaimService _service;

  List<Claim> _allItems = [];
  bool _loading = true;
  String? _error;

  static const _tabs = <String>['all', 'pending', 'approved', 'rejected', 'cancelled'];
  static const _tabLabels = <String>['全部', '待审核', '已通过', '已拒绝', '已取消'];
  String _activeTab = 'all';

  @override
  void initState() {
    super.initState();
    _service = ClaimService(apiClient: ApiClient.instance);
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

  List<Claim> get _filteredItems {
    if (_activeTab == 'all') return _allItems;
    return _allItems.where((c) => c.status == _activeTab).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的认领'),
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
        icon: Icons.assignment_outlined,
        message: '暂无认领记录',
      );
    }
    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) => _ClaimCard(
          claim: items[index],
          onCancel: () => _showCancelDialog(items[index]),
          onTap: () => context.go('/lost-found/${items[index].lostFoundId}'),
        ),
      ),
    );
  }

  Future<void> _showCancelDialog(Claim claim) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('取消申请'),
        content: const Text('确定要取消这条认领申请吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('返回'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('确认取消'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      try {
        await _service.cancel(claim.id);
        await _loadData();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('取消失败: $e')),
          );
        }
      }
    }
  }
}

class _ClaimCard extends StatelessWidget {
  final Claim claim;
  final VoidCallback onCancel;
  final VoidCallback onTap;

  const _ClaimCard({
    required this.claim,
    required this.onCancel,
    required this.onTap,
  });

  String? get _thumbnail {
    final images = claim.lostFoundImages;
    if (images != null && images.isNotEmpty) return images.first;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final statusLabel = claimStatusLabels[claim.status] ?? claim.status;
    final statusColor = _statusColor(claim.status, cs);

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thumbnail
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 72,
                      height: 72,
                      child: _thumbnail != null
                          ? Image.network(
                              _thumbnail!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => _placeholder(cs),
                            )
                          : _placeholder(cs),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          claim.lostFoundTitle ?? '物品 #${claim.lostFoundId}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (claim.lostFoundLocation != null)
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined,
                                  size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  claim.lostFoundLocation!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                statusLabel,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: statusColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              timeAgo(claim.createTime),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                            const Spacer(),
                            if (claim.status == 'pending')
                              TextButton.icon(
                                onPressed: onCancel,
                                icon: const Icon(Icons.close, size: 16),
                                label: const Text('取消', style: TextStyle(fontSize: 12)),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  visualDensity: VisualDensity.compact,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Description
              if (claim.description != null && claim.description!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  claim.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
              // Rejection reason
              if (claim.status == 'rejected' &&
                  claim.remark != null &&
                  claim.remark!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    '拒绝原因：${claim.remark}',
                    style: const TextStyle(fontSize: 13, color: Colors.red),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholder(ColorScheme cs) {
    return Container(
      color: cs.surfaceContainerHighest,
      child: Icon(Icons.image_outlined, size: 28, color: cs.onSurfaceVariant.withValues(alpha: 0.3)),
    );
  }

  Color _statusColor(String status, ColorScheme cs) {
    return switch (status) {
      'pending' => Colors.orange,
      'approved' => Colors.green,
      'rejected' => Colors.red,
      'cancelled' => Colors.grey,
      _ => cs.outline,
    };
  }
}
