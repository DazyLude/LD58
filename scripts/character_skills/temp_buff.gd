extends CharacterSkill
class_name TemporaryBuff


var buff : CharacterStats.Buff = null;
var time : float = 5.0;
var source : String = "temp_buff"


@warning_ignore("shadowed_variable")
func _init(buff: CharacterStats.Buff, time: float, source: String) -> void:
	self.buff = buff;
	self.time = time;
	self.source = source;


func execute(user: Character, target: Character):
	if user == null or target == null:
		push_error("someone is null, can't use attack");
		return;
	
	if user.stats == null or target.stats == null:
		push_error("stats are null, can't use attack");
		return;
	
	target.stats.grant_buff(source, buff);
	await user.get_tree().create_timer(time).timeout
	target.stats.revoke_buffs(source);


class GreenPotion extends CharacterItemSkill:
	func _init() -> void:
		skill = TemporaryBuff.new(
			CharacterStats.Buff.new(CharacterStats.Buff.ATTACK_SPEED, 0.5),
			5.0, "Green Potion"
		);
		targeting_strategy = TargetingStrategySelf.new();
		cooldown = 5.0;
		associated_item = "potion_green";
		cost = 1;
		icon = preload("res://assets/graphics/icons/pot1.png");
	
	
	func execute(user: Character, target: Character):
		super.execute(user, target);
		user.sfx_player.play_sound(preload('res://assets/sounds/sfx/gulp.wav'));


class GreyPotion extends CharacterItemSkill:
	func _init() -> void:
		skill = TemporaryBuff.new(
			CharacterStats.Buff.new(CharacterStats.Buff.ARMOR, 50.0),
			5.0, "Grey Potion"
		);
		targeting_strategy = TargetingStrategySelf.new();
		cooldown = 5.0;
		associated_item = "potion_grey";
		cost = 1;
		icon = preload("res://assets/graphics/icons/pot2.png");
	
	
	func execute(user: Character, target: Character):
		super.execute(user, target);
		user.sfx_player.play_sound(preload('res://assets/sounds/sfx/gulp.wav'));
