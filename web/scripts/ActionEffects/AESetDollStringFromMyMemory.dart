import '../Entity.dart';
import 'ActionEffect.dart';

class AESetDollStringFromMyMemory extends ActionEffect {
    AESetDollStringFromMyMemory(String importantString, num importantNum) : super(importantString, importantNum);

  @override
  void effectEntities(Entity effector, List<Entity> entities) {
    entities.forEach((Entity e) => e.setNewDoll(effector.getStringMemory(importantString)));
  }

}