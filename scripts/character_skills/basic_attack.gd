extends CharacterSkill
class_name BasicAttack


func execute(user: Character, target: Character):
	if user == null or target == null:
		push_error("someone is null, can't use attack");
		return;
	
	if user.stats == null or target.stats == null:
		push_error("stats are null, can't use attack");
		return;
	
	var damage = roundf(user.stats.attack * randf_range(0.9, 1.1));
	print("%s attacked %s for %s" % [user, target, damage]);
	
	user.attack();
	await user.get_tree().create_timer(0.25).timeout;
	target.stats.take_damage(damage);
	await user.get_tree().create_timer(0.5).timeout;
	user.enter_battle();



class Auto extends CharacterAutoSkill:
	func _init() -> void:
		skill = BasicAttack.new();
		cooldown = 1.0;
