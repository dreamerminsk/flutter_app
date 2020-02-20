String trim(String value) {
  return value.trim().replaceAll((' '), '');
}

int parseInt(String value) {
  return int.tryParse(trim(value)) ?? 0;
}
