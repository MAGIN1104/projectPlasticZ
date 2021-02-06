import 'package:flutter/material.dart';

class Operaciones {
  double bolsaBajaKilos(
      double ancho, double largo, double espesor, int cantBolsas) {
    if (largo == null && ancho == null && espesor == null && cantBolsas == null)
      return 0.0;
    else
      return largo * ancho * espesor * 1.848 / 10000.0 * cantBolsas / 1000.0;
  }

  double bolsaAKilos(
      double ancho, double largo, double espesor, int cantBolsas) {
    if (largo == null && ancho == null && espesor == null && cantBolsas == null)
      return 0.0;
    else
      return (largo * ancho * espesor * 1.86 / 10000.0 * cantBolsas / 1000.0);
  }

  double bolsaPPKilos(
      double ancho, double largo, double espesor, int cantBolsas) {
    if (largo == null && ancho == null && espesor == null && cantBolsas == null)
      return 0.0;
    else
      return (largo * ancho * espesor * 1.72 / 10000.0 * cantBolsas / 1000.0);
  }
}
