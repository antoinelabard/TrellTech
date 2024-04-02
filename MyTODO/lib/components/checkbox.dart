import 'package:flutter/material.dart';

class CheckComponent extends Checkbox {
  const CheckComponent({
    super.key,
    required bool super.value,
    required super.onChanged,
  }) : super(
    activeColor: const Color(0xff5f96fd),
  );
}