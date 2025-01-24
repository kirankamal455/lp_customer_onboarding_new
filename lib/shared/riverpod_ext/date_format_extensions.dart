import 'package:intl/intl.dart';

extension DateParsing on String {
  // Method to format any date string into dd-MM-yyyy format
  String toFormattedDate() {
    // Define all possible input date formats
    List<String> formats = [
      'yyyy-MM-dd', // 2024-10-20
      'dd/MM/yyyy', // 20/10/2024
      'MM/dd/yyyy', // 10/20/2024
      'yyyy/MM/dd', // 2024/10/20
      'yyyy-MM-dd HH:mm:ss', // 2024-10-20 14:30:00
      'dd-MM-yyyy', // 20-10-2024
      'dd MMM yyyy', // 23 AUG 2022
      // Add more formats as needed
    ];

    for (var format in formats) {
      try {
        // Try to parse the input date using the current format
        DateFormat inputFormat = DateFormat(format);
        DateTime parsedDate = inputFormat.parseStrict(this);

        // Return the date in the desired format (dd-MM-yyyy)
        return DateFormat('dd-MM-yyyy').format(parsedDate);
      } catch (e) {
        // If parsing fails, continue with the next format
        continue;
      }
    }

    // Return a default message if no valid date format is found
    return 'Invalid Date';
  }
}
