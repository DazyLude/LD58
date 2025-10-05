extends RefCounted
class_name CharacterStats


signal slain;


var buff_table : Dictionary[String, Buff] = {};


var hp := 100.0:
	get:
		return add_buffs(hp, get_buffs(Buff.HP));

var max_hp := 100.0:
	get:
		return add_buffs(max_hp, get_buffs(Buff.MAX_HP));

var armor := 0.0:
	get:
		return add_buffs(armor, get_buffs(Buff.ARMOR));

var attack := 20.0:
	get:
		return add_buffs(attack, get_buffs(Buff.ATTACK));

var attack_speed := 0.5:
	get:
		return add_buffs(attack_speed, get_buffs(Buff.ATTACK_SPEED));


var blocking : bool = false;


var is_alive : bool :
	get:
		return hp > 0.0;


func take_damage(value: float) -> void:
	if not blocking:
		var damage = value / (armor / 60.0 + 1.0)
		hp -= damage;
		print("taken %s damage, current hp %s" % [damage, hp]);
		if hp <= 0.0:
			print("character slain");
			slain.emit();
	else:
		print("blocked!");


func grant_buff(from: String, buff: Buff) -> void:
	buff_table[from] = buff;


func revoke_buffs(from: String) -> void:
	buff_table.erase(from);


func clear_buffs() -> void:
	buff_table.clear();


func get_buffs(to: int) -> Array[Buff]:
	var result : Array[Buff] = [];
	
	for buff_source in buff_table:
		var buff := buff_table[buff_source];
		if buff.to == to:
			result.append(buff);
	
	return result;


func add_buffs(value: float, buffs: Array[Buff]) -> float:
	return value + buffs.reduce(func(acc: float, b: Buff) -> float: return acc + b.value, 0.0);


class Buff:
	enum {
		HP,
		MAX_HP,
		ARMOR,
		ATTACK,
		ATTACK_SPEED,
	}
	var value : float = 0.0;
	var to : int;
	
	@warning_ignore("shadowed_variable")
	func _init(to: int, value: float) -> void:
		self.value = value;
		self.to = to;
