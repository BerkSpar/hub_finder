import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final TextEditingController searchController =
      TextEditingController(text: 'berkspar');
}
