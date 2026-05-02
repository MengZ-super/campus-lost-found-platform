import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../models/category.dart';
import '../../models/lost_found.dart';
import '../../services/lost_found_service.dart';
import '../../services/category_service.dart';
import '../../services/upload_service.dart';
import '../../utils/validators.dart';
import '../../widgets/image_picker_sheet.dart';
import '../../widgets/map_picker.dart';

class PublishLostFoundPage extends StatefulWidget {
  const PublishLostFoundPage({super.key});

  @override
  State<PublishLostFoundPage> createState() => _PublishLostFoundPageState();
}

class _PublishLostFoundPageState extends State<PublishLostFoundPage> {
  final _formKey = GlobalKey<FormState>();

  // Form values
  String _itemType = 'lost';
  int? _categoryId;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _featuresController = TextEditingController();
  final _locationController = TextEditingController();
  String? _campus;
  DateTime? _happenedTime;

  // Map
  double? _latitude;
  double? _longitude;
  String? _address;

  // Images
  List<String> _imageUrls = [];

  // Data
  List<Category> _categories = [];
  bool _isLoadingCategories = true;
  bool _isSubmitting = false;

  static const _campusOptions = ['主校区', '南校区', '北校区', '东校区', '西校区'];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _featuresController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    try {
      final service = context.read<CategoryService>();
      _categories = await service.getList();
    } catch (_) {
      _categories = [];
    }
    if (mounted) setState(() => _isLoadingCategories = false);
  }

  // ── Image picker ──

  Future<void> _pickImages() async {
    final uploadService = context.read<UploadService>();
    final result = await showImagePickerSheet(
      context,
      onUpload: (File file) => uploadService.upload(file.path),
    );
    if (result != null) {
      setState(() => _imageUrls = result.urls);
    }
  }

  // ── Map picker ──

  Future<void> _openMapPicker() async {
    final result = await Navigator.of(context).push<MapPickerResult>(
      MaterialPageRoute(
        builder: (_) => MapPickerPage(
          initialLat: _latitude,
          initialLng: _longitude,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        _latitude = result.latitude;
        _longitude = result.longitude;
        _address = result.address;
      });
    }
  }

  // ── Date picker ──

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _happenedTime ?? now,
      firstDate: DateTime(2020),
      lastDate: now,
      helpText: '选择发生时间',
      cancelText: '取消',
      confirmText: '确定',
    );
    if (picked != null) {
      final hour = _happenedTime?.hour ?? 12;
      final minute = _happenedTime?.minute ?? 0;
      setState(() {
        _happenedTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          hour,
          minute,
        );
      });
    }
  }

  // ── Submit ──

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_categoryId == null) {
      _showSnack('请选择分类');
      return;
    }
    if (_happenedTime == null) {
      _showSnack('请选择发生时间');
      return;
    }
    if (_imageUrls.isEmpty) {
      _showSnack('请至少上传一张图片');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final request = CreateLostFoundRequest(
        categoryId: _categoryId!,
        itemType: _itemType,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        images: _imageUrls,
        features: _featuresController.text.trim().isEmpty
            ? null
            : _featuresController.text.trim(),
        location: _locationController.text.trim(),
        latitude: _latitude,
        longitude: _longitude,
        happenedTime: _happenedTime!,
        campus: _campus,
      );

      final service = context.read<LostFoundService>();
      final item = await service.publish(request);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('发布成功')),
        );
        GoRouter.of(context).go('/lost-found/${item.id}');
      }
    } catch (e) {
      if (mounted) {
        _showSnack(e.toString().replaceFirst('Exception: ', ''));
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // ── Build ──

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('发布信息'),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _submit,
            child: _isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('提交'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── 1. 基本信息 ──
            _sectionHeader(theme, '基本信息'),
            const SizedBox(height: 12),
            _buildTypeSelector(theme),
            const SizedBox(height: 16),
            _buildCategoryDropdown(theme),
            const SizedBox(height: 24),

            // ── 2. 物品描述 ──
            _sectionHeader(theme, '物品描述'),
            const SizedBox(height: 12),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '标题',
                hintText: '请输入物品标题',
                border: OutlineInputBorder(),
              ),
              maxLength: 100,
              validator: (v) => validateRequired(v, '标题') ??
                  validateMaxLength(v, 100, '标题'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: '描述',
                hintText: '请详细描述物品信息、特征等',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              maxLength: 2000,
              validator: (v) => validateRequired(v, '描述') ??
                  validateMaxLength(v, 2000, '描述'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _featuresController,
              decoration: const InputDecoration(
                labelText: '特征（选填）',
                hintText: '如颜色、品牌、型号等独特特征',
                border: OutlineInputBorder(),
              ),
              maxLength: 500,
              validator: (v) =>
                  v != null && v.isNotEmpty ? validateMaxLength(v, 500, '特征') : null,
            ),
            const SizedBox(height: 16),
            _buildImageSection(theme),
            const SizedBox(height: 24),

            // ── 3. 位置信息 ──
            _sectionHeader(theme, '位置信息'),
            const SizedBox(height: 12),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: '地点',
                hintText: '如：图书馆二楼、食堂门口',
                border: OutlineInputBorder(),
              ),
              maxLength: 200,
              validator: (v) => validateRequired(v, '地点') ??
                  validateMaxLength(v, 200, '地点'),
            ),
            const SizedBox(height: 12),
            _buildMapPickerCard(theme),
            const SizedBox(height: 24),

            // ── 4. 其他信息 ──
            _sectionHeader(theme, '其他信息'),
            const SizedBox(height: 12),
            _buildDateField(theme),
            const SizedBox(height: 16),
            _buildCampusDropdown(theme),
            const SizedBox(height: 32),

            // Submit button at bottom
            FilledButton.icon(
              onPressed: _isSubmitting ? null : _submit,
              icon: const Icon(Icons.publish),
              label: const Text('发布'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(ThemeData theme, String title) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  // ── Type Selector ──

  Widget _buildTypeSelector(ThemeData theme) {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(value: 'lost', label: Text('寻物'), icon: Icon(Icons.search_off)),
        ButtonSegment(value: 'found', label: Text('招领'), icon: Icon(Icons.check_circle_outline)),
      ],
      selected: {_itemType},
      onSelectionChanged: (v) => setState(() => _itemType = v.first),
    );
  }

  // ── Category Dropdown ──

  Widget _buildCategoryDropdown(ThemeData theme) {
    if (_isLoadingCategories) {
      return const Center(child: CircularProgressIndicator());
    }
    return DropdownButtonFormField<int>(
      initialValue: _categoryId,
      decoration: const InputDecoration(
        labelText: '分类',
        hintText: '请选择物品分类',
        border: OutlineInputBorder(),
      ),
      items: _categories.map((c) {
        return DropdownMenuItem(
          value: c.id,
          child: Text(c.name),
        );
      }).toList(),
      onChanged: (v) => setState(() => _categoryId = v),
      validator: (_) => _categoryId == null ? '请选择分类' : null,
    );
  }

  // ── Image Section ──

  Widget _buildImageSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('图片', style: theme.textTheme.bodyLarge),
            const SizedBox(width: 8),
            Text('(至少1张)', style: theme.textTheme.bodySmall?.copyWith(color: Colors.red)),
          ],
        ),
        const SizedBox(height: 8),
        if (_imageUrls.isNotEmpty) ...[
          _buildImageGrid(),
          const SizedBox(height: 8),
        ],
        OutlinedButton.icon(
          onPressed: _isSubmitting ? null : _pickImages,
          icon: const Icon(Icons.add_photo_alternate_outlined),
          label: Text(_imageUrls.isEmpty ? '添加图片' : '重新选择 (${_imageUrls.length}张)'),
        ),
      ],
    );
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: _imageUrls.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            _imageUrls[index],
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Icon(Icons.broken_image),
            ),
          ),
        );
      },
    );
  }

  // ── Map Picker Card ──

  Widget _buildMapPickerCard(ThemeData theme) {
    return Card(
      child: InkWell(
        onTap: _openMapPicker,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.red, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: _address != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('已选位置',
                              style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 4),
                          Text(_address!, style: const TextStyle(fontSize: 14)),
                          Text(
                            '$_latitude, $_longitude',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      )
                    : const Text('点击选择物品位置（可选）',
                        style: TextStyle(color: Colors.grey)),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  // ── Date Field ──

  Widget _buildDateField(ThemeData theme) {
    return InkWell(
      onTap: _pickDate,
      borderRadius: BorderRadius.circular(8),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: '发生时间',
          hintText: '请选择物品丢失/捡到的时间',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        child: Text(
          _happenedTime != null
              ? '${_happenedTime!.year}-${_happenedTime!.month.toString().padLeft(2, '0')}-${_happenedTime!.day.toString().padLeft(2, '0')} ${_happenedTime!.hour.toString().padLeft(2, '0')}:${_happenedTime!.minute.toString().padLeft(2, '0')}'
              : '请选择时间',
          style: TextStyle(
            color: _happenedTime != null ? null : Colors.grey,
          ),
        ),
      ),
    );
  }

  // ── Campus Dropdown ──

  Widget _buildCampusDropdown(ThemeData theme) {
    return DropdownButtonFormField<String>(
      initialValue: _campus,
      decoration: const InputDecoration(
        labelText: '校区（选填）',
        hintText: '请选择校区',
        border: OutlineInputBorder(),
      ),
      items: _campusOptions.map((c) {
        return DropdownMenuItem(value: c, child: Text(c));
      }).toList(),
      onChanged: (v) => setState(() => _campus = v),
    );
  }
}
