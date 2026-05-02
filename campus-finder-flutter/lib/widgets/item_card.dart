import 'package:flutter/material.dart';
import '../models/lost_found.dart';
import '../utils/constants.dart';
import '../utils/date_format.dart';
import 'status_badge.dart';

class ItemCard extends StatelessWidget {
  final LostFoundItem item;
  final VoidCallback? onTap;

  const ItemCard({super.key, required this.item, this.onTap});

  String? get _thumbnail {
    final images = item.images;
    if (images != null && images.isNotEmpty) return images.first;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final typeLabel = itemTypeLabels[item.itemType] ?? item.itemType;
    final isLost = item.itemType == 'lost';

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail + status badge
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: _thumbnail != null
                      ? Image.network(
                          _thumbnail!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (_, __, ___) => _placeholder(cs),
                          loadingBuilder: (_, child, progress) {
                            if (progress == null) return child;
                            return _placeholder(cs);
                          },
                        )
                      : _placeholder(cs),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: StatusBadge(status: item.status, fontSize: 11),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isLost ? cs.error : cs.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      typeLabel,
                      style: TextStyle(
                        color: isLost ? cs.onError : cs.onPrimary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Info section
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  _infoRow(Icons.location_on_outlined, item.location),
                  const SizedBox(height: 4),
                  _infoRow(Icons.access_time, formatDate(item.happenedTime)),
                  const SizedBox(height: 8),
                  _statsRow(theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder(ColorScheme cs) {
    return Container(
      color: cs.surfaceContainerHighest,
      child: Icon(Icons.image_outlined, size: 36, color: cs.onSurfaceVariant.withOpacity(0.3)),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _statsRow(ThemeData theme) {
    return Row(
      children: [
        _statChip(Icons.visibility_outlined, item.viewCount),
        const SizedBox(width: 12),
        _statChip(Icons.favorite_border, item.favoriteCount),
        const SizedBox(width: 12),
        _statChip(Icons.handshake_outlined, item.claimCount),
      ],
    );
  }

  Widget _statChip(IconData icon, int? count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 3),
        Text('${count ?? 0}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
