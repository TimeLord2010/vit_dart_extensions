enum TimeUnit {
  millisecond,
  second,
  minute,
  hour,
  day,
  month,
  year;

  factory TimeUnit.fromString(String value) {
    return switch (value) {
      'year' => year,
      'month' => month,
      'd' => day,
      'day' => day,
      'h' => hour,
      'hour' => hour,
      'min' => minute,
      'minute' => minute,
      's' => second,
      'sec' => second,
      'second' => second,
      'ms' => millisecond,
      'millisecond' => millisecond,
      _ => millisecond,
    };
  }
}
