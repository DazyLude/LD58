extends Node
class_name ItemsDBClass

const ROOT := "res://scenes/items/";
var items : Dictionary[String, PackedScene] = {};

var item_skills : Dictionary[String, Script] = {
	"shield": Block.Shield,
	"bomb": FixedAttack.Bomb,
	"potion_red": Heal.RedPotion,
	"potion_green": TemporaryBuff.GreenPotion,
	"potion_grey": TemporaryBuff.GreyPotion,
}


var item_buffs : Array[BuffItemGroup] = [
	BuffItemGroup.from_array([
		["helmet1", 0, CharacterStats.Buff.new(CharacterStats.Buff.ARMOR, 5.0)],
		["helmet2", 1, CharacterStats.Buff.new(CharacterStats.Buff.ARMOR, 20.0)],
		["helmet3", 2, CharacterStats.Buff.new(CharacterStats.Buff.ARMOR, 50.0)],
	]),
	BuffItemGroup.from_array([
		["sword1", 0, CharacterStats.Buff.new(CharacterStats.Buff.ATTACK, 5.0)],
		["sword2", 1, CharacterStats.Buff.new(CharacterStats.Buff.ATTACK, 17.0)],
		["sword3", 2, CharacterStats.Buff.new(CharacterStats.Buff.ATTACK, 30.0)],
	]),
]


func _init() -> void:
	for file in DirAccess.get_files_at(ROOT):
		var path = ROOT.path_join(file);
		if ResourceLoader.exists(path):
			var resource := load(path);
			if resource is PackedScene:
				var instance = resource.instantiate();
				if instance is Item:
					items[instance.item_name] = resource;


func get_item(item: String) -> PackedScene:
	return items.get(item, items[Item.PLACEHOLDER_NAME]);


func get_item_skill(item: String) -> Script:
	return item_skills.get(item, null);


class BuffItemGroup:
	var priority : Dictionary[String, int] = {};
	var buffs : Dictionary[String, CharacterStats.Buff] = {}
	var last_item : String = "";
	
	static func from_array(arr: Array) -> BuffItemGroup:
		var inst = BuffItemGroup.new();
		
		for item in arr:
			var item_name : String = item[0];
			inst.priority[item_name] = item[1];
			inst.buffs[item_name] = item[2];
		
		return inst;
	
	
	func get_strongest_for_items(items: Array) -> CharacterStats.Buff:
		var current_priority := -1;
		var current_buff : CharacterStats.Buff = null;
		
		for item in items:
			if item in priority and priority[item] > current_priority:
				current_buff = buffs[item];
				last_item = item;
		
		return current_buff;
