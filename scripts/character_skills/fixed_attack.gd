extends CharacterSkill
class_name FixedAttack


var value : float = 10.0;


@warning_ignore("shadowed_variable")
func _init(value: float) -> void:
	self.value = value


func execute(user: Character, target: Character):
	if user == null or target == null:
		push_error("someone is null, can't use attack");
		return;
	
	if user.stats == null or target.stats == null:
		push_error("stats are null, can't use attack");
		return;
	
	var damage = roundf(value * randf_range(0.9, 1.1));
	print("%s attacked %s for %s" % [user, target, damage]);
	target.stats.take_damage(damage);


class Bomb extends CharacterItemSkill:
	func _init() -> void:
		skill = FixedAttack.new(50.0);
		cooldown = 5.0;
		associated_item = "bomb";
		cost = 1;
		icon = preload("res://assets/graphics/icons/bomb.png");
