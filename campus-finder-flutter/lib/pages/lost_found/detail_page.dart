import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import '../../blocs/claim/claim_bloc.dart';
import '../../blocs/claim/claim_event.dart';
import '../../blocs/claim/claim_state.dart';
import '../../blocs/lost_found_detail/lost_found_detail_bloc.dart';
import '../../blocs/lost_found_detail/lost_found_detail_event.dart';
import '../../blocs/lost_found_detail/lost_found_detail_state.dart';
import '../../models/claim.dart';
import '../../models/lost_found.dart';
import '../../services/api_client.dart';
import '../../services/claim_service.dart';
import '../../services/lost_found_service.dart';
import '../../services/upload_service.dart';
import '../../utils/constants.dart';
import '../../utils/date_format.dart';
import '../../widgets/error_state.dart';
import '../../widgets/image_carousel.dart';
import '../../widgets/image_picker_sheet.dart';
import '../../widgets/status_badge.dart';

class LostFoundDetailPage extends StatelessWidget {
  final int id;

  const LostFoundDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final apiClient = context.read<ApiClient>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LostFoundDetailBloc(
            service: LostFoundService(apiClient: apiClient),
          )..add(LoadDetail(id: id)),
        ),
        BlocProvider(
          create: (_) => ClaimBloc(
            service: ClaimService(apiClient: apiClient),
          ),
        ),
      ],
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
                if (isOwner && item.status == 'pending') ...[
                  const SizedBox(height: 24),
                  _ClaimsSection(lostFoundId: item.id),
                ],
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

    return BlocListener<ClaimBloc, ClaimState>(
      listener: (context, state) {
        if (state is ClaimSubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('申请已提交，请等待审核')),
          );
          // Reset claim bloc so the form can be re-opened
          context.read<ClaimBloc>().add(const LoadClaims(lostFoundId: 0));
        }
      },
      child: Column(
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
          ] else if (item.status == 'pending') ...[
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => _showClaimFormSheet(context),
              icon: const Icon(Icons.handshake_outlined),
              label: const Text('申请认领'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ],
      ),
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('关闭功能即将上线')),
              );
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

  void _showClaimFormSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _ClaimFormSheet(lostFoundId: item.id),
    );
  }
}

// ──────────────────────────────────
// Claim form bottom sheet
// ──────────────────────────────────

class _ClaimFormSheet extends StatefulWidget {
  final int lostFoundId;

  const _ClaimFormSheet({required this.lostFoundId});

  @override
  State<_ClaimFormSheet> createState() => _ClaimFormSheetState();
}

class _ClaimFormSheetState extends State<_ClaimFormSheet> {
  final _formKey = GlobalKey<FormState>();
  String _claimType = 'claim';
  final _descriptionController = TextEditingController();
  final _featuresController = TextEditingController();
  final _contactController = TextEditingController();
  final List<String> _proofImages = [];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    _featuresController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final result = await showImagePickerSheet(
      context,
      onUpload: (file) async {
        final uploadService = UploadService(
          apiClient: context.read<ApiClient>(),
        );
        return uploadService.upload(file.path);
      },
      maxCount: 5,
    );
    if (result != null && mounted) {
      setState(() {
        _proofImages.addAll(result.urls);
        // Cap at 5
        if (_proofImages.length > 5) {
          _proofImages.removeRange(5, _proofImages.length);
        }
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final request = CreateClaimRequest(
      lostFoundId: widget.lostFoundId,
      claimType: _claimType,
      description: _descriptionController.text.trim(),
      features: _featuresController.text.trim().isEmpty
          ? null
          : _featuresController.text.trim(),
      contact: _contactController.text.trim(),
      proofImages: _proofImages.isEmpty ? null : _proofImages,
      expectTime: null,
    );

    if (mounted) {
      context.read<ClaimBloc>().add(SubmitClaim(request: request));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return BlocListener<ClaimBloc, ClaimState>(
      listener: (context, state) {
        if (state is ClaimSubmitted) {
          Navigator.pop(context);
        } else if (state is ClaimError) {
          setState(() => _isSubmitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: cs.onSurfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text('申请认领', style: theme.textTheme.titleLarge),
                const SizedBox(height: 20),

                // Claim type
                DropdownButtonFormField<String>(
                  value: _claimType,
                  decoration: const InputDecoration(
                    labelText: '申请类型',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'claim', child: Text('认领')),
                    DropdownMenuItem(value: 'clue', child: Text('提供线索')),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _claimType = v);
                  },
                ),
                const SizedBox(height: 14),

                // Description
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: '描述 *',
                    hintText: '请描述物品特征以便核实',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  maxLength: 500,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return '请输入描述';
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // Features
                TextFormField(
                  controller: _featuresController,
                  decoration: const InputDecoration(
                    labelText: '特征（选填）',
                    hintText: '补充特征信息',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                  maxLength: 200,
                ),
                const SizedBox(height: 14),

                // Contact
                TextFormField(
                  controller: _contactController,
                  decoration: const InputDecoration(
                    labelText: '联系方式 *',
                    hintText: '手机号/微信/QQ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return '请输入联系方式';
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // Proof images
                Text('凭证图片（选填，最多5张）',
                    style: theme.textTheme.bodyMedium),
                const SizedBox(height: 8),
                if (_proofImages.isNotEmpty) ...[
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _proofImages.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (_, index) => Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              _proofImages[index],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: -4,
                            right: -4,
                            child: InkWell(
                              onTap: () => setState(
                                  () => _proofImages.removeAt(index)),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black87,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(2),
                                child: const Icon(Icons.close,
                                    size: 14, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                OutlinedButton.icon(
                  onPressed: _proofImages.length >= 5 ? null : _pickImages,
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: const Text('添加图片'),
                ),
                const SizedBox(height: 20),

                // Submit
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('提交申请'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────
// Claims list section (owner view)
// ──────────────────────────────────

class _ClaimsSection extends StatefulWidget {
  final int lostFoundId;

  const _ClaimsSection({required this.lostFoundId});

  @override
  State<_ClaimsSection> createState() => _ClaimsSectionState();
}

class _ClaimsSectionState extends State<_ClaimsSection> {
  @override
  void initState() {
    super.initState();
    context
        .read<ClaimBloc>()
        .add(LoadClaims(lostFoundId: widget.lostFoundId));
  }

  void _reloadDetail() {
    context
        .read<LostFoundDetailBloc>()
        .add(LoadDetail(id: widget.lostFoundId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('认领申请', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        BlocBuilder<ClaimBloc, ClaimState>(
          builder: (context, state) => state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            ),
            claimsLoaded: (claims) {
              if (claims.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  child: const Text(
                    '暂无认领申请',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: claims.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) =>
                    _ClaimCard(
                      claim: claims[index],
                      onReview: (action, remark) {
                        context.read<ClaimBloc>().add(
                              ReviewClaim(
                                claimId: claims[index].id,
                                action: action,
                                remark: remark,
                              ),
                            );
                        _reloadDetail();
                      },
                      onRejectDialog: () =>
                          _showRejectDialog(context, claims[index].id),
                    ),
              );
            },
            error: (message) => Text(
              '加载失败: $message',
              style: const TextStyle(color: Colors.red),
            ),
            submitting: () => const SizedBox.shrink(),
            submitted: (_) => const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  void _showRejectDialog(BuildContext context, int claimId) {
    final remarkController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('拒绝申请'),
        content: TextField(
          controller: remarkController,
          decoration: const InputDecoration(
            hintText: '拒绝原因（选填）',
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
              context.read<ClaimBloc>().add(
                    ReviewClaim(
                      claimId: claimId,
                      action: 'reject',
                      remark: remarkController.text.trim().isEmpty
                          ? null
                          : remarkController.text.trim(),
                    ),
                  );
              _reloadDetail();
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('确认拒绝'),
          ),
        ],
      ),
    );
  }
}

class _ClaimCard extends StatelessWidget {
  final Claim claim;
  final void Function(String action, String? remark) onReview;
  final VoidCallback onRejectDialog;

  const _ClaimCard({
    required this.claim,
    required this.onReview,
    required this.onRejectDialog,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final statusLabel = {
      'pending': '待审核',
      'approved': '已通过',
      'rejected': '已拒绝',
      'cancelled': '已取消',
    }[claim.status] ?? claim.status;

    final statusColor = {
      'pending': Colors.orange,
      'approved': Colors.green,
      'rejected': Colors.red,
      'cancelled': Colors.grey,
    }[claim.status] ?? cs.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: claim.applicantAvatar != null
                    ? NetworkImage(claim.applicantAvatar!)
                    : null,
                child: claim.applicantAvatar == null
                    ? Icon(Icons.person, size: 18, color: cs.onSurfaceVariant)
                    : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  claim.applicantNickname ?? '匿名用户',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: cs.onSurface),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(fontSize: 12, color: statusColor, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Description
          if (claim.description != null && claim.description!.isNotEmpty) ...[
            Text(
              claim.description!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 6),
          ],

          // Contact
          if (claim.contact != null && claim.contact!.isNotEmpty) ...[
            Row(
              children: [
                Icon(Icons.contact_phone_outlined, size: 14, color: cs.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(claim.contact!, style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: 6),
          ],

          // Proof images
          if (claim.proofImages != null && claim.proofImages!.isNotEmpty) ...[
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: claim.proofImages!.length,
                separatorBuilder: (_, __) => const SizedBox(width: 6),
                itemBuilder: (_, i) => ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    claim.proofImages![i],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 60,
                      height: 60,
                      color: cs.surfaceContainerHighest,
                      child: const Icon(Icons.broken_image, size: 20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
          ],

          // Rejected remark
          if (claim.status == 'rejected' && claim.remark != null && claim.remark!.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '拒绝原因: ${claim.remark}',
                style: const TextStyle(fontSize: 12, color: Colors.red),
              ),
            ),
            const SizedBox(height: 6),
          ],

          // Review buttons
          if (claim.status == 'pending') ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () => onReview('approve', null),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      textStyle: const TextStyle(fontSize: 13),
                    ),
                    child: const Text('通过'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onRejectDialog,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      textStyle: const TextStyle(fontSize: 13),
                      foregroundColor: cs.error,
                    ),
                    child: const Text('拒绝'),
                  ),
                ),
              ],
            ),
          ],
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
