double calculaPreuSamarretes(int numero, String talla) {
  final preus = {
    "S": 10.0,
    "M": 12.0,
    "L": 15.0,
  };

  return numero * (preus[talla] ?? 0);
}

double calculaDescompte(double preu, int tipusDescompte) {
  if (tipusDescompte == 1) {
    return preu * 0.10;
  } else if (tipusDescompte == 2) {
    if (preu > 100) {
      return 20.0;
    }
  }
  return 0.0;
}

double preuDefinitiu(int numero, String talla, int tipusDescompte) {
  double preu = calculaPreuSamarretes(numero, talla);
  double descompte = calculaDescompte(preu, tipusDescompte);
  return preu - descompte;
}