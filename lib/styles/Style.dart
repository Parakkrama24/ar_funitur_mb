import 'package:flutter/material.dart';

class apptextDecoration{
  static InputDecoration main({
    hinttext_="Enter....",
    labaleText=null
  }){
    return InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hinttext_,
      hintStyle: const TextStyle(color: Colors.black),
      labelText: labaleText
    );

  }
}

class buttonDecoration{
  static BoxDecoration main({ color_ = const Color.fromARGB(221, 221, 44, 44)}){
    return BoxDecoration(
      color: color_,
      borderRadius: BorderRadius.circular(25),
    );
  }
}