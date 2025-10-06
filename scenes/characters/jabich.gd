extends AnimatedCharacter


func _init() -> void:
	auto_skills.clear();
	auto_skills.push_back(JabichAttack.new());


@export var attack_speed_override : float = 1.0;
@export var attack_override : float = 5.0;
@export var hp_override : float = 50.0;

@onready var throw_from : Marker2D = $ThrowOrigin;


func _ready() -> void:
	stats.attack = attack_override;
	stats.attack_speed = attack_speed_override;
	stats.max_hp = hp_override;
	stats.hp = hp_override;
	
	super._ready();


func attack() -> void:
	super.attack();


class JabichAttack extends CharacterAutoSkill:
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
