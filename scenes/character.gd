extends Node2D
class_name Character


signal encounter(another_area: Area2D);
signal fled;
signal slain;


var stats := CharacterStats.new();
var auto_skills : Array[CharacterAutoSkill] = [BasicAttack.Auto.new()];
var usable_skills : Array[CharacterSkill] = []


@onready
var hitbox : Area2D = $Area2D;


func _ready() -> void:
	$Area2D.area_entered.connect(encounter.emit);
	stats.slain.connect(on_death);


func on_death() -> void:
	slain.emit();


func on_flight() -> void:
	fled.emit();


func enter_battle() -> void:
	pass;
