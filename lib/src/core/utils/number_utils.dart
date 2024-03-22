String formatNumber(int number) {
  if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(1)}m';
  } else if (number >= 1000) {
    double formattedNumber = number / 1000;
    if (formattedNumber % 1 == 0) {
      return '${formattedNumber.toInt()}k';
    } else {
      return '${formattedNumber.toStringAsFixed(1)}k';
    }
  } else {
    return number.toString();
  }
}
