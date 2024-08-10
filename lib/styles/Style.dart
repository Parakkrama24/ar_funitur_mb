import 'package:flutter/material.dart';

class apptextDecoration{
  static InputDecoration main({
    hinttext_="Enter...."
  }){
    return InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hinttext_,
      hintStyle: const TextStyle(color: Colors.black),
      
    );

  }
}

class buttonDecoration{
  static BoxDecoration main({ color_ = Colors.black87}){
    return BoxDecoration(
      color: color_,
    );
  }
}