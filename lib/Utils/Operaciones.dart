import 'package:flutter/material.dart';

class Operaciones {
  //OPERACIONES PARA LOS TIPOS DE BOLSAS

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

  double precioTotal(double vkilos, double vpkilos) {
    if (vkilos == null && vpkilos == null) {
      return 0.0;
    } else {
      return vkilos * vpkilos;
    }
  }

  // double precioTotalBobina(){

  // }

  //Precion por unidad
  double precioXUnidad(double vprecioTotal, double vcantidad) {
    if (vprecioTotal == null && vcantidad == null) {
      return 1.0;
    } else {
      return vprecioTotal / vcantidad;
    }
  }

  double kilosXRolloPEBD(double ancho, double espesor, double largo) {
    if (ancho == null && espesor == null && largo == null) {
      return 1.0;
    } else {
      return (ancho * espesor * 1.848 * largo / 100000);
    }
  }

  double kilosXRolloPEAD(double ancho, double espesor, double largo) {
    if (ancho == null && espesor == null && largo == null) {
      return 1.0;
    } else {
      return (ancho * espesor * 1.86 * largo / 100000);
    }
  }

  double kilosXRolloPP(double ancho, double espesor, double largo) {
    if (ancho == null && espesor == null && largo == null) {
      return 1.0;
    } else {
      return (ancho * espesor * 1.7 * largo / 100000);
    }
  }
}
