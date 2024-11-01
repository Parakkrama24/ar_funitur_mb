import 'package:flutter/material.dart';

class apptextDecoration{
  static InputDecoration main({
    hinttext_="Enter....",
    labaleText
  }){
    return InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hinttext_,
      hintStyle: const TextStyle(color: Colors.black),
      labelText: labaleText
    );

  }

  static InputDecoration secondary({
    hinttext_="Enter....",
  }){
    return const InputDecoration();
  }
}

class buttonDecoration{
  static BoxDecoration main({ color_ = const Color.fromARGB(221, 221, 44, 44)}){
    return BoxDecoration(
      color: color_,
      borderRadius: BorderRadius.circular(25),
    );
  }

  static BoxDecoration secondary({
    Color color_ = const Color.fromARGB(221, 14, 3, 3),
    Color borderColor = Colors.black, // Default border color
    double borderWidth = 1.0,         // Default border width
  }) {
    return BoxDecoration(
      //color: color_,
      border: Border.all(
        color: borderColor,    // Set the border color
        width: borderWidth, 
          // Set the border width
      ),
      borderRadius:BorderRadius.circular(25) 
    );
  }
}