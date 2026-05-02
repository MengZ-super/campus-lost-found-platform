import 'package:intl/intl.dart';

String formatDateTime(DateTime? dateTime) {
  if (dateTime == null) return '';
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
}

String formatDate(DateTime? dateTime) {
  if (dateTime == null) return '';
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

String timeAgo(DateTime? dateTime) {
  if (dateTime == null) return '';
  final diff = DateTime.now().difference(dateTime);
  if (diff.inMinutes < 1) return '刚刚';
  if (diff.inMinutes < 60) return '${diff.inMinutes}分钟前';
  if (diff.inHours < 24) return '${diff.inHours}小时前';
  if (diff.inDays < 30) return '${diff.inDays}天前';
  return formatDate(dateTime);
}
