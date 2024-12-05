class CheckoutService {
  // Misalnya, metode pembayaran API bisa ditambahkan di sini nanti
  Future<bool> processPayment(double amount) async {
    // Simulasi pembayaran berhasil
    await Future.delayed(Duration(seconds: 2));
    return true; // Mengembalikan true jika pembayaran berhasil
  }
}
