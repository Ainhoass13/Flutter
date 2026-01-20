import 'package:flutter/material.dart';

/// Widget que muestra un número de índice grande y estilizado.
/// Utilizado en el carrusel de películas para mostrar la posición actual.
/// 
/// El número aparece con:
/// - Tamaño muy grande (120px) con sombra azul alrededor
/// - Cuatro sombras para crear un efecto de borde en azul (0xFF0296E5)
/// - Color de fondo del número en gris oscuro (0xFF242A32)
/// 
/// Parámetro:
/// - number: Número a mostrar (normalmente 1, 2, 3, etc.)
class IndexNumber extends StatelessWidget {
  const IndexNumber({
    super.key,
    required this.number,
  });
  final int number;
  @override
  Widget build(BuildContext context) {
    // Número con efecto de sombra azul en los cuatro lados
    return Text(
      (number).toString(),
      style: const TextStyle(
        fontSize: 120,
        fontWeight: FontWeight.w700,
        shadows: [
          // Sombra superior izquierda
          Shadow(
            offset: Offset(-3, -3),
            color: Color(0xFF0296E5),
          ),
          // Sombra superior derecha
          Shadow(
            offset: Offset(3, -3),
            color: Color(0xFF0296E5),
          ),
          // Sombra inferior derecha
          Shadow(
            offset: Offset(3, 3),
            color: Color(0xFF0296E5),
          ),
          // Sombra inferior izquierda
          Shadow(
            offset: Offset(-3, 3),
            color: Color(0xFF0296E5),
          ),
        ],
        color: Color(0xFF242A32),
      ),
    );
  }
}
