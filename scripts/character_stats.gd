extends RefCounted
class_name CharacterStats


signal slain;


var hp := 100.0;
var max_hp := 100.0;
var attack := 10.0;
var attack_speed := 1.0;

var blocking : bool = false;


var is_alive : bool :
	get:
		return hp > 0.0;


func take_damage(value: float) -> void:
	if not blocking:
		hp -= value;
		print("taken %s damage, current hp %s" % [value, hp]);
		if hp <= 0.0:
			print("character slain");
			slain.emit();
	else:
		print("blocked!");
