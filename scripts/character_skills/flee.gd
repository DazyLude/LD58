extends CharacterSkill
class_name Flee


func _init() -> void:
	targeting_strategy = TargetingStrategySelf.new();
	icon = preload("res://assets/graphics/icons/run2.png")


@warning_ignore("unused_parameter")
func execute(user: Character, target: Character):
	target.on_flight();


func can_be_used(context: Level) -> bool:
	return not (context.fleeing or context.dead);
