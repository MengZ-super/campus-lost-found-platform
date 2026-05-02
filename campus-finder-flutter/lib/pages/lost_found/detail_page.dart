import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import '../../blocs/lost_found_detail/lost_found_detail_bloc.dart';
import '../../blocs/lost_found_detail/lost_found_detail_event.dart';
import '../../blocs/lost_found_detail/lost_found_detail_state.dart';
import '../../models/lost_found.dart';
import '../../services/api_client.dart';
import '../../services/lost_found_service.dart';
import '../../utils/constants.dart';
import '../../utils/date_format.dart';
import '../../widgets/error_state.dart';
import '../../widgets/image_carousel.dart';
import '../../widgets/status_badge.dart';

class LostFoundDetailPage extends StatelessWidget {
  final int id;

  const LostFoundDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LostFoundDetailBloc(
        service: LostFoundService(
          apiClient: context.read<ApiClient>(),
        ),
      )..add(LoadDetail(id: id)),
      child: _DetailBody(id: id),
    );
  }
}

class _DetailBody extends StatelessWidget {
  final int id;

  const _DetailBody({required this.id});

  bool _isOwner(BuildContext context, LostFoundItem item) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      return authState.user.id == item.userId;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('物品详情')),
      body: BlocBuilder<LostFoundDetailBloc, LostFoundDetailState>(
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          error: (message) => ErrorState(
            message: message,
            onRetry: () => context
                .read<LostFoundDetailBloc>()
                .add(LoadDetail(id: id)),
          ),
          loaded: (item) => _DetailContent(
            item: item,
            isOwner: _isOwner(context, item),
          ),
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  final LostFoundItem item;
  final bool isOwner;

  const _DetailContent({required this.item, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageCarousel(imageUrls: item.images ?? [], height: 280),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BadgeRow(item: item),
                const SizedBox(height: 12),
                Text(
                  item.title,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _MetaCard(item: item),
                const SizedBox(height: 20),
                if (item.description.isNotEmpty) ...[
                  const _SectionTitle(title: '物品描述'),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: 20),
                ],
                if (item.features != null && item.features!.isNotEmpty) ...[
                  const _SectionTitle(title: '物品特征'),
                  const SizedBox(height: 8),
                  Text(
                    item.features!,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: 20),
                ],
                _StatsRow(item: item),
                const SizedBox(height: 20),
                _PublisherCard(item: item),
                const SizedBox(height: 24),
                _ActionBar(
                  item: item,
                  isOwner: isOwner,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeRow extends StatelessWidget {
  final LostFoundItem item;

  const _BadgeRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLost = item.itemType == 'lost';
    final typeLabel = itemTypeLabels[item.itemType] ?? item.itemType;

    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isLost ? cs.error : cs.primary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            typeLabel,
            style: TextStyle(
              color: isLost ? cs.onError : cs.onPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        StatusBadge(status: item.status, fontSize: 13),
      ],
    );
  }
}

class _MetaCard extends StatelessWidget {
  final LostFoundItem item;

  const _MetaCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Wrap(
        spacing: 24,
        runSpacing: 10,
        children: [
          if (item.categoryName != null)
            _MetaItem(
              icon: Icons.category_outlined,
              label: '分类',
              value: item.categoryName!,
            ),
          _MetaItem(
            icon: Icons.location_on_outlined,
            label: '地点',
            value: item.location,
          ),
          _MetaItem(
            icon: Icons.access_time,
            label: '时间',
            value: formatDateTime(item.happenedTime),
          ),
          if (item.campus != null && item.campus!.isNotEmpty)
            _MetaItem(
              icon: Icons.school_outlined,
              label: '校区',
              value: item.campus!,
            ),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetaItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: cs.primary),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final LostFoundItem item;

  const _StatsRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _StatItem(icon: Icons.visibility_outlined, label: '浏览', count: item.viewCount ?? 0),
        _StatItem(icon: Icons.favorite_outline, label: '收藏', count: item.favoriteCount ?? 0),
        _StatItem(icon: Icons.handshake_outlined, label: '认领', count: item.claimCount ?? 0),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(icon, size: 22, color: cs.primary),
        const SizedBox(height: 4),
        Text('$count', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
      ],
    );
  }
}

class _PublisherCard extends StatelessWidget {
  final LostFoundItem item;

  const _PublisherCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: cs.primaryContainer,
            backgroundImage: item.publisherAvatar != null
                ? NetworkImage(item.publisherAvatar!)
                : null,
            child: item.publisherAvatar == null
                ? Icon(Icons.person, color: cs.onPrimaryContainer)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.publisherNickname ?? '匿名用户',
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                if (item.createTime != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    '发布于 ${timeAgo(item.createTime)}',
                    style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  final LostFoundItem item;
  final bool isOwner;

  const _ActionBar({required this.item, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LostFoundDetailBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FavoriteButton(
          isFav: item.favorited == true,
          count: item.favoriteCount ?? 0,
          onTap: () => bloc.add(ToggleFavorite(id: item.id)),
        ),
        if (isOwner) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Navigate to edit page — restore when edit page exists
                    Navigator.of(context).pushNamed('/edit/${item.id}');
                  },
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text('编辑'),
                ),
              ),
              if (item.status == 'pending') ...[
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showCloseDialog(context),
                    icon: const Icon(Icons.cancel_outlined, size: 18),
                    label: const Text('关闭'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ] else ...[
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {
              // Apply claim — will be implemented in Phase D
            },
            icon: const Icon(Icons.handshake_outlined),
            label: const Text('申请认领'),
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
        ],
      ],
    );
  }

  void _showCloseDialog(BuildContext context) {
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('关闭物品'),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(
            hintText: '请输入关闭原因（选填）',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // Close action — will be wired in Phase D
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('确认关闭'),
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final bool isFav;
  final int count;
  final VoidCallback onTap;

  const _FavoriteButton({
    required this.isFav,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        size: 20,
        color: isFav ? cs.error : null,
      ),
      label: Text('${isFav ? "已收藏" : "收藏"} ($count)'),
      style: isFav
          ? OutlinedButton.styleFrom(foregroundColor: cs.error)
          : null,
    );
  }
}
