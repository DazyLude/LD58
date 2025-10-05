extends Node2D
class_name Character


signal encounter(another_area: Area2D);
signal fled;
signal slain;


var stats := CharacterStats.new();
var inventory := InventoryManager.new();

var auto_skills : Array[CharacterAutoSkill] = [BasicAttack.Auto.new()];
var usable_skills : Array[CharacterSkill] :
	get:
		return Array(default_skills + item_skills, TYPE_OBJECT, &"RefCounted", CharacterSkill);

var default_skills : Array[CharacterSkill] = [Flee.new()];
var item_skills : Array[CharacterItemSkill] = [];
var item_buffs : Dictionary[String, RefCounted] = {};


@export
var wind_up := 0.25;
@export 
var drop : String = "";


@onready
var hitbox : Area2D = $Area2D;
@onready
var hp_display : HPDisplay = $HpBar
@onready
var sfx_player : PolyphonicSfxPlayer = $Node;
@onready
var target : Marker2D = $ThrowTarget;

@export
var hit_sound : AudioStream = preload("res://assets/sounds/sfx/hit.wav");
@export
var windup_sound : AudioStream;


var level_ref : Level = null;


func _ready() -> void:
	$Area2D.area_entered.connect(encounter.emit);
	stats.slain.connect(on_death);
	hp_display.connect_character(self);


func update_item_skills() -> void:
	item_skills.clear();
	
	for item in inventory.contents:
		var skill := ItemsDB.get_item_skill(item);
		if skill != null:
			item_skills.push_back(skill.new());


func update_item_buffs() -> void:
	for item in item_buffs:
		stats.revoke_buffs(item);
	
	item_buffs.clear();
	
	for buff_group in ItemsDB.item_buffs:
		var buff := buff_group.get_strongest_for_items(inventory.contents.keys());
		if buff != null:
			item_buffs[buff_group.last_item] = null;
			stats.grant_buff(buff_group.last_item, buff);


func on_death() -> void:
	slain.emit();
	hp_display.hide();
	self.rotation = PI / 2;


func on_flight() -> void:
	self.scale.x *= -1;
	hp_display.hide();
	fled.emit();


func enter_battle() -> void:
	pass;


func walk() -> void:
	pass;


func idle() -> void:
	pass;


func attack() -> void:
	pass;
