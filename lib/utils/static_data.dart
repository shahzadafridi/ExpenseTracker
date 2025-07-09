const List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

const years = ['2021', '2022', '2023', '2024', '2025'];


int parseMonthToInt(String month) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return months.indexOf(month) + 1;
}

DateTime parseYearToDate(String year) {
  try {
    final parsed = int.parse(year);
    return DateTime(parsed); // Defaults to Jan 1st of that year
  } catch (e) {
    return DateTime.now();
  }
}