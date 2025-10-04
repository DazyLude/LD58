extends RefCounted
class_name CharacterStats


signal slain;


var hp := 100.0;
var max_hp := 100.0;
var attack := 10.0;
var attack_speed := 1.0;


func take_damage(value: float) -> void:
	hp -= value;
	print("taken %s damage, current hp %s" % [value, hp])
	if hp <= 0.0:
		print("character slain")
		slain.emit();
