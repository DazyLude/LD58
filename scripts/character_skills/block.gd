extends CharacterSkill
class_name Block


func execute(user: Character, target: Character):
	if user == null or target == null:
		push_error("someone is null, can't use attack");
		return;
	
	if user.stats == null or target.stats == null:
		push_error("stats are null, can't use attack");
		return;
	
	if not user.is_inside_tree():
		push_error("user node needs to be inside tree for this skill to work");
		return;
	
	target.stats.blocking = true;
	var blocking_time = 0.2 * (1.0 + user.stats.attack_speed);
	var expire_timer = user.create_tween();
	expire_timer.tween_interval(blocking_time)
	expire_timer.tween_callback(func(): target.stats.blocking = false);


class Shield extends CharacterItemSkill:
	func _init() -> void:
		skill = Block.new();
		targeting_strategy = TargetingStrategySelf.new();
		associated_item = "shield";
		cost = 0;
		cooldown = 2.5;
