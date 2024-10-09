import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text; // Volvemos al String text
  final bool
      isLoading; // Agregamos un flag para indicar si se debe mostrar el loader
  final Color? buttonColor;

  const CustomFilledButton(
      {super.key,
      this.onPressed,
      required this.text,
      required this.isLoading, // Aseguramos que se pase el estado del loader
      this.buttonColor});

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(10);

    return FilledButton(
      style: FilledButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: radius,
            bottomRight: radius,
            topLeft: radius,
          ))),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Centrar el contenido del botón
        children: [
          if (isLoading) // Mostramos el loader solo si isLoading es true
            const Padding(
              padding: EdgeInsets.only(
                  right: 8.0), // Espacio entre el texto y el loader
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2.0,
                ),
              ),
            ),
          Text(text), // Mostramos el texto normalmente
        ],
      ),
    );
  }
}
