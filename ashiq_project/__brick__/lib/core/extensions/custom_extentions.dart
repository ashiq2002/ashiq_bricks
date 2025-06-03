import 'dart:ui';

import 'package:intl/intl.dart';

import '../config/strings/api_endpoint.dart';

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }
}

extension TextExtensions on String {
  String get capitalizeFirstLetter {
    if (this.isEmpty) return this;

    return this[0].toUpperCase() + this.substring(1);
  }
}

extension ImageBaseUrl on String? {
  String? get imageBaseUrl {
    if (this == null) return null;
    return ApiEndpoint.imageBaseUrl + this!;
  }
}

extension EndPointExtensions on String {
  String get baseUrl {
    return ApiEndpoint.baseUrl + this;
  }
}

extension FormateString on String? {
  String? get toRemoveMemberText {
    return this?.replaceAll(RegExp(r'^Member-', caseSensitive: false), '');
  }
}

extension FormateTime on String? {
  String get toAmPm {
    try {
      if (this == null) return "--:--";
      DateTime dateTime = DateFormat('HH:mm:ss').parse(this!);

      // Format the DateTime object into AM/PM format
      String formattedTime = DateFormat.jm().format(dateTime.toLocal());

      return formattedTime;
    } catch (e) {
      return "--:--";
    }
  }

  int? get toMinutes {
    if (this == null) return null;

    try {
      DateFormat timeFormat = DateFormat.Hms();
      DateTime parsedTime = timeFormat.parse(this!);

      int totalMinutes = (parsedTime.hour * 60) + parsedTime.minute;
      return totalMinutes;
    } catch (e) {
      return null;
    }
  }
}

extension FormateDate on DateTime? {
  String get timeAgo {
    if (this == null) return "";

    final Duration diff = DateTime.now().difference(this!);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hour ago';
    if (diff.inDays < 7) return '${diff.inDays} day ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()} week ago';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()} month ago';
    return '${(diff.inDays / 365).floor()} year ago';
  }

  int? get dateTimeToMinute {
    if (this == null) return null;

    print("DATE TIME: $this");

    return this!.toLocal().millisecondsSinceEpoch ~/ 60000;
  }

  String? get amPm {
    if (this == null) return null;

    return DateFormat('h:mm a').format(this!);
  }

  String? get toYYYYmmDD {
    if (this == null) return null;
    return DateFormat("yyyy-MM-dd").format(this!);
  }

  String get toMMMdd {
    if (this == null) return "";

    try {
      return DateFormat("MMM dd").format(this!);
    } catch (e) {
      return "";
    }
  }

  String get toMMyy {
    if (this == null) return "";

    try {
      return DateFormat('MMMM yyyy').format(this!);
    } catch (e) {
      return "";
    }
  }

  String get toddMMMhhMMa {
    if (this == null) return "";

    try {
      return DateFormat("dd MMM hh:mm a").format(this!);
    } catch (e) {
      return "";
    }
  }

  String? get ddMMyy {
    if (this == null) return "";

    try {
      return DateFormat("dd MMM, yyyy").format(this!);
    } catch (e) {
      return "";
    }
  }

  String? get MMddyy {
    if (this == null) return "";

    try {
      return DateFormat("MMM dd, yyyy").format(this!);
    } catch (e) {
      return "";
    }
  }

  String? get mMddyy {
    if (this == null) return "";

    try {
      return DateFormat(" MMM dd, yyyy").format(this!);
    } catch (e) {
      return "";
    }
  }

  String get toMMMddYYhhMMa {
    if (this == null) return "N/A";
    return DateFormat("MMM dd, yyyy hh:mm a").format(this!);
  }

  String get toMMddyyyhhmm {
    if (this == null) return "";

    try {
      return DateFormat("MMM dd, yyyy hh:mm a").format(this!);
    } catch (e) {
      return "";
    }
  }

}