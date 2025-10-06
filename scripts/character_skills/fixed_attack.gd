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
	
	
	func execute(user: Character, target: Character):
		var user_position = user.level_ref.get_player_scene_position() + user.target.position;
		var target_position = target.position + target.target.position;
		
		user.level_ref.throw_item(
			associated_item,
			true,
			user_position,
			target_position,
			0.5,
			min(target_position.y, user_position.y) - 50.0
		)
		
		await user.get_tree().create_timer(0.5).timeout;
		super.execute(user, target);
		user.sfx_player.play_sound(preload("res://assets/sounds/sfx/bomb.wav"));
		user.level_ref.update_item_related();
