// 1'den N'e kadar olan asal sayıları hesaplayan fonksiyon yazınız, fonksiyon parametre olarak aldığı sayıya kadar (N) hesaplama yapacaktır.

void main() {
  bool asalmi(int sayi) {
    if (sayi <= 1) {
      return false;
    }
    if (sayi <= 3) {
      return true;
    }
    if (sayi % 2 == 0 || sayi % 3 == 0) {
      return false;
    }
    for (int i = 5; i * i <= sayi; i += 6) {
      if (sayi % i == 0 || sayi % (i + 2) == 0) {
        return false;
      }
    }
    return true;
  }

  List<int> asalBulma(int N) {
    List<int> asalSayim = [];
    for (int i = 2; i <= N; i++) {
      if (asalmi(i)) {
        asalSayim.add(i);
      }
    }
    return asalSayim;
  }

  int N = 30;
  List<int> asalSayilar = asalBulma(N);
  print("1'den $N sayısına kadar olan asal sayılar: $asalSayilar");
}
