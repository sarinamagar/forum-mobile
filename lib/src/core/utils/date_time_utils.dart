String dateTimeUtil(DateTime timestamp) {
  DateTime currentTime = DateTime.now();
  Duration timeDifference = currentTime.difference(timestamp);

  int seconds = timeDifference.inSeconds;
  int minutes = (seconds / 60).floor();
  int hours = (minutes / 60).floor();
  int days = (hours / 24).floor();
  int months = (days / 30).floor();
  int years = (months / 12).floor();

  if (years >= 1) {
    return '${years}y ';
  } else if (months >= 1) {
    return '${months}m ';
  } else if (days >= 1) {
    return '${days}d ';
  } else if (hours >= 1) {
    return '${hours}h ';
  } else if (minutes >= 1) {
    return '${minutes}m  ';
  } else {
    return '${seconds}s';
  }
}

String extractCreatedDate(String createdAt) {
  DateTime dateTime = DateTime.parse(createdAt);
  String formattedDate =
      "${_getMonth(dateTime.month)} ${_twoDigits(dateTime.day)}, ${dateTime.year}";

  return formattedDate;
}

String _twoDigits(int n) {
  if (n >= 10) {
    return "$n";
  } else {
    return "0$n";
  }
}

String _getMonth(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "";
  }
}
