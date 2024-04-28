extension StringExtension on String {
  /// Converts strings in ISO-8601 or DD/MM/(YYYY|YY)[ HH:mm] formats to a DateTime object.
  /// The returned DateTime object does not take hours, minutes, or seconds into account.
  ///
  /// Returns `null` if the string cannot be parsed into a valid date.
  ///
  /// ```dart
  /// String isoDateString = "2022-01-01";
  /// String brDateString = "01/01/2022";
  /// print(isoDateString.toMaybeDate()); // Outputs: 2022-01-01 00:00:00.000
  /// print(brDateString.toMaybeDate()); // Outputs: 2022-01-01 00:00:00.000
  /// ```
  DateTime? toMaybeDate() {
    // Splits the string by 'T' or whitespace, then takes the date part
    var dateStr = split(RegExp(r'T|\s')).elementAt(0);
    // Splits the date into parts and tries to parse each part into an integer
    var parts = dateStr.split(RegExp(r'/|-')).map((x) {
      return int.tryParse(x, radix: 10);
    });
    if (parts.length != 3) return null;

    int? year, month, day;

    // Determines if the format is ISO-8601 (YYYY-MM-DD)
    if (contains(RegExp(r'^\d{4}-'))) {
      year = parts.elementAt(0);
      month = parts.elementAt(1);
      day = parts.elementAt(2);
    } else {
      // Assumes the format is DD/MM/(YY|YYYY)
      day = parts.elementAt(0);
      month = parts.elementAt(1);
      year = parts.elementAt(2);
    }

    // Validates the date components
    if (year == null || month == null || day == null || month > 12 || day > 31) return null;
    // Adjusts for two-digit years
    if (year < 100) year += 2000;

    // Creates the DateTime object from the parts
    var dt = DateTime(year, month, day);
    return dt;
  }

  /// Inserts a given string [value] into the current string at the specified index [i].
  ///
  /// Returns a new string with the value inserted.
  ///
  /// ```dart
  /// String originalString = "HelloWorld";
  /// print(originalString.insertAt(5, " ")); // Outputs: "Hello World"
  /// ```
  String insertAt(int i, String value) {
    final start = substring(0, i);
    final end = substring(i);
    return start + value + end;
  }

  /// Checks if the current string is a valid email address.
  ///
  /// Returns `true` if the string matches the email pattern, otherwise `false`.
  ///
  /// ```dart
  /// String email = "example@example.com";
  /// String nonEmail = "notAnEmail";
  /// print(email.isEmail); // Outputs: true
  /// print(nonEmail.isEmail); // Outputs: false
  /// ```
  bool get isEmail {
    final pattern = RegExp(r'^.+@.*\.[a-zA-Z]+$');
    return pattern.hasMatch(this);
  }

  /// Returns the initials of each word of a string.
  ///
  /// This function takes a string and returns its initials, up to a specified
  /// number of initials. By default, it returns the first two initials without
  /// any separator.
  ///
  /// Examples:
  /// ```dart
  /// var name = 'John Doe';
  /// print(name.getInitials()); // 'JD'
  ///
  /// print(name.getInitials(initialsCount: 1)); // 'J'
  ///
  /// print(name.getInitials(joinString: '.')); // 'J.D'
  /// ```
  ///
  /// Parameters:
  /// - `initialsCount` (int): The maximum number of initials to return.
  ///   Defaults to 2.
  /// - `joinString` (String): The string to use to join the initials.
  ///   Defaults to '' (no separator).
  ///
  /// Returns:
  /// A string containing the initials.
  String getInitials({
    int initialsCount = 2,
    String joinString = '',
  }) {
    var words = split(' ').where((x) => x.isNotEmpty);
    var initials = words.map((x) => x.substring(0, 1).toUpperCase());
    return initials.take(initialsCount).join(joinString);
  }

  /// Checks if the string contains at least one uppercase letter.
  ///
  /// This getter considers not only English uppercase letters but also
  /// uppercase accented letters commonly used in the Brazilian Portuguese
  /// language, such as Á, À, Â, Ã, É, Ê, Í, Ó, Ô, Õ, Ú, and Ç.
  ///
  /// Example:
  /// ```dart
  /// String text1 = 'Hello world';
  /// print(text1.hasUpperCase); // Output: true
  ///
  /// String text2 = 'hello world';
  /// print(text2.hasUpperCase); // Output: false
  /// ```
  bool get hasUpperCase {
    return contains(RegExp(r'[A-ZÁÀÂÃÉÊÍÓÔÕÚÇ]'));
  }

  /// Checks if the string contains at least one lowercase letter.
  ///
  /// This getter considers not only English lowercase letters but also
  /// lowercase accented letters commonly used in the Brazilian Portuguese
  /// language, such as á, à, â, ã, é, ê, í, ó, ô, õ, ú, and ç.
  ///
  /// Example:
  /// ```dart
  /// String text1 = 'Hello world';
  /// print(text1.hasLowerCase); // Output: true
  ///
  /// String text2 = 'HELLO WORLD';
  /// print(text2.hasLowerCase); // Output: false
  /// ```
  bool get hasLowerCase {
    return contains(RegExp(r'[a-záàâãéêíóôõúç]'));
  }

  /// Checks if the string contains at least one digit.
  ///
  /// Example:
  /// ```dart
  /// String text1 = 'Hello123';
  /// print(text1.hasNumber); // Output: true
  ///
  /// String text2 = 'Hello';
  /// print(text2.hasNumber); // Output: false
  /// ```
  bool get hasNumber {
    return contains(RegExp(r'\d'));
  }

  /// Checks if the string contains at least one special symbol.
  ///
  /// This getter looks for common special symbols such as !, @, #, $, %, ^,
  /// &, *, (, ), ,, ., ?, ", :, {, }, |, <, and >.
  ///
  /// Example:
  /// ```dart
  /// String text1 = 'Hello@World';
  /// print(text1.hasSymbol); // Output: true
  ///
  /// String text2 = 'HelloWorld';
  /// print(text2.hasSymbol); // Output: false
  /// ```
  bool get hasSymbol {
    return contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  /// Checks if the length of the string is between the specified minimum and
  /// maximum values, inclusive.
  ///
  /// Parameters:
  /// - `min`: The minimum length of the string.
  /// - `max`: The maximum length of the string.
  ///
  /// Returns `true` if the length of the string is within the specified range,
  /// otherwise returns `false`.
  ///
  /// Example:
  /// ```dart
  /// String text = 'Hello';
  /// print(text.hasLengthBetween(3, 6)); // Output: true
  ///
  /// print(text.hasLengthBetween(6, 10)); // Output: false
  /// ```
  bool hasLengthBetween(int min, int max) {
    if (min < 0) {
      throw RangeError.range(min, min, max);
    }
    if (min > max) {
      throw RangeError.range(max, min, max);
    }
    var len = length;
    return len >= min && len <= max;
  }

  /// Converts each word in the string to title case, where the first letter is
  /// capitalized and the remainder of the word is in lowercase, except for
  /// words specified by the [wordIgnorer] function.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.toTitleCase(); // 'Hello World'
  /// 'hora de sair'.toTitleCase((word) => word == 'de'); // 'Hora de Sair'
  /// ```
  String toTitleCase([bool Function(String word)? wordIgnorer]) {
    if (isEmpty) return this;
    var words = split(RegExp(r'\s+'));
    var ignoreFunc = wordIgnorer ?? (_) => false;
    for (int i = 0; i < words.length; i++) {
      var word = words[i];
      if (ignoreFunc(word)) continue;
      var firstLetter = word.substring(0, 1).toUpperCase();
      var rest = word.substring(1).toLowerCase();
      words[i] = firstLetter + rest;
    }
    return words.join(' ');
  }
}
