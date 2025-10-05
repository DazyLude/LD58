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
	user.sfx_player.play_sound(user.windup_sound);
	await user.get_tree().create_timer(user.wind_up).timeout;
	if user.stats.is_alive:
		user.sfx_player.play_sound(user.hit_sound);
		target.stats.take_damage(damage);


class Auto extends CharacterAutoSkill:
	func _init() -> void:
		skill = BasicAttack.new();
		cooldown = 1.0;


class Jabich extends CharacterAutoSkill:
	func _init() -> void:
		skill = BasicAttack.new();
		cooldown = 1.0;
	
	
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
		user.sfx_player.play_sound(user.windup_sound);
		var user_position = user.position + user.throw_from.position;
		var target_position = target.level_ref.get_player_scene_position() + target.target.position;
		
		await user.get_tree().create_timer(user.wind_up).timeout;
		user.level_ref.throw_item(
			"crystal_ball",
			true,
			user_position,
			target_position,
			user.wind_up / 2,
			min(target_position.y, user_position.y) - 50.0
		)
		
		await user.get_tree().create_timer(user.wind_up / 2).timeout;
		if user.stats.is_alive:
			user.sfx_player.play_sound(user.hit_sound);
			target.stats.take_damage(damage);
