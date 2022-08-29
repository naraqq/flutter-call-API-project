abstract class Action {}

class Convert extends Action {}

class UpdateValue extends Action {
  String payload;

  UpdateValue({
    required this.payload,
  });
}
