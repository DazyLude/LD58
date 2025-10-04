extends Node2D
class_name Character


signal encounter(another_area: Area2D);
signal fled;
signal slain;


var stats := CharacterStats.new();
var auto_skills : Array[CharacterAutoSkill] = [BasicAttack.Auto.new()];
var usable_skills : Array[CharacterSkill] :
	get:
		return Array(default_skills + item_skills, TYPE_OBJECT, &"RefCounted", CharacterSkill);

var default_skills : Array[CharacterSkill] = [Flee.new()];
var item_skills : Array[CharacterItemSkill] = [];


@onready
var hitbox : Area2D = $Area2D;
@onready
var hp_display : HPDisplay = $HpBar


func _ready() -> void:
	$Area2D.area_entered.connect(encounter.emit);
	stats.slain.connect(on_death);
	hp_display.connect_character(self);


func update_item_skills() -> void:
	item_skills.clear();
	
	for item in GameState.inventory.contents:
		var skill := ItemsDB.get_item_skill(item);
		if skill != null:
			item_skills.push_back(skill.new())


func on_death() -> void:
	slain.emit();


func on_flight() -> void:
	fled.emit();


func enter_battle() -> void:
	pass;
