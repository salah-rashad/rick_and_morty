mixin ApiFilter on Enum {
  List<ApiFilter> get getValues;

  @override
  String toString() => name;
}
