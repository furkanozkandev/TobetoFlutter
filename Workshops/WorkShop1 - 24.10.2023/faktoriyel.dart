//Aldığı sayının faktöriyelini hesaplayarak sayıyı geriye dönen fonksiyonu oluşturunuz.

void main() {
  int faktoriyelHesaplama(int sayi) {
    if (sayi == 0) {
      return 1;
    }
    int sonuc = 1;
    for (int i = 1; i <= sayi; i++) {
      sonuc *= i;
    }
    return sonuc;
  }

  int hesaplanacakSayi = 5;
  int factoriyel = faktoriyelHesaplama(hesaplanacakSayi);
  print("Girilen sayı : $hesaplanacakSayi; Faktöriyeli: $factoriyel");
}
