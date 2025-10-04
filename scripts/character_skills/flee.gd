extends CharacterSkill
class_name Flee


func _init() -> void:
	targeting_strategy = TargetingStrategySelf.new();


@warning_ignore("unused_parameter")
func execute(user: Character, target: Character):
	target.on_flight();
