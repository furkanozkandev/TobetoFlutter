// Verilen sayının Armstrong sayı olup olmadığını bulan fonksiyonu yazınız ve test ediniz.

import 'dart:math';

bool isArmstrongNumber(int number) {
  int originalNumber = number;
  int numberOfDigits = 0;
  int sum = 0;

  while (number > 0) {
    number ~/= 10;
    numberOfDigits++;
  }

  number = originalNumber;

  while (number > 0) {
    int digit = number % 10;
    sum += pow(digit, numberOfDigits).toInt();
    number ~/= 10;
  }

  return sum == originalNumber;
}

void main() {
  print(isArmstrongNumber(183)); // false
  print(isArmstrongNumber(371)); // true
  print(isArmstrongNumber(670)); // false
}
