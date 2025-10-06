extends CharacterSkill
class_name Heal


var value : float = 0.0;


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
	
	var damage = roundf(value * randf_range(0.7, 1.3));
	target.stats.heal_damage(damage);


class RedPotion extends CharacterItemSkill:
	func _init() -> void:
		skill = Heal.new(50.0);
		targeting_strategy = TargetingStrategySelf.new();
		cost = 1;
		cooldown = 5.0;
		associated_item = 'potion_red';
		usable_out_of_combat = true;
		icon = preload("res://assets/graphics/icons/pot3.png");
	
	
	func execute(user: Character, target: Character):
		super.execute(user, target);
		user.sfx_player.play_sound(preload('res://assets/sounds/sfx/gulp.wav'));
