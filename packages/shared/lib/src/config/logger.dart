import 'package:logger/logger.dart';

/// Initialize main global [Logger] instance.
Logger _logger = Logger(level: Logger.level);

/// Log error method that is used for printing out errors.
void logE(
  dynamic message, {
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
}) {
  return _logger.e(
    message,
    time: time ?? DateTime.now(),
    error: error,
    stackTrace: stackTrace,
  );
}

/// Log warning that used for printing warning/important messages
/// to pay developer attention on it, rather than
/// using logI method.
void logW(
  dynamic message, {
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
}) {
  return _logger.w(
    message,
    time: time ?? DateTime.now(),
    error: error,
    stackTrace: stackTrace,
  );
}

/// Log info method that used for printing info message.
void logI(
  dynamic message, {
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
}) {
  return _logger.i(
    message,
    time: time ?? DateTime.now(),
    error: error,
    stackTrace: stackTrace,
  );
}

/// Log debug method to illustrate that the message is in debug mode
void logD(
  dynamic message, {
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
}) {
  return _logger.d(
    message,
    time: time ?? DateTime.now(),
    error: error,
    stackTrace: stackTrace,
  );
}
