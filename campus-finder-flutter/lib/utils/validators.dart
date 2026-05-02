String? validateUsername(String? value) {
  if (value == null || value.trim().isEmpty) return '请输入用户名';
  if (value.trim().length < 3) return '用户名至少3个字符';
  if (value.trim().length > 50) return '用户名最多50个字符';
  return null;
}

String? validatePhone(String? value) {
  if (value == null || value.trim().isEmpty) return '请输入手机号';
  final regex = RegExp(r'^1[3-9]\d{9}$');
  if (!regex.hasMatch(value.trim())) return '请输入正确的手机号';
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return '请输入密码';
  if (value.length < 6) return '密码至少6个字符';
  if (value.length > 20) return '密码最多20个字符';
  if (!RegExp(r'[a-zA-Z]').hasMatch(value)) return '密码必须包含字母';
  if (!RegExp(r'\d').hasMatch(value)) return '密码必须包含数字';
  return null;
}

String? validateRequired(String? value, String label) {
  if (value == null || value.trim().isEmpty) return '请输入$label';
  return null;
}

String? validateMaxLength(String? value, int max, String label) {
  if (value != null && value.trim().length > max) return '$label最多$max个字符';
  return null;
}
