extends Control
class_name LevelSkillDisplay


signal skill_pressed(skill: CharacterSkill);


var item_icon_pckd : PackedScene = preload("res://scenes/level/skill_icon.tscn");


@onready
var container := $HBoxContainer;
var skill_icons : Dictionary[CharacterSkill, SkillIcon] = {};


func update(level: Level, character: Character) -> void:
	var checked_skills : Dictionary[CharacterSkill, RefCounted] = {};
	
	for skill in character.usable_skills:
		var icon := get_skill_icon(skill);
		icon.set_skill(skill, character, level);
		
		checked_skills[skill] = null;
	
	for skill in skill_icons:
		if not skill in checked_skills:
			skill_icons[skill].hide();


func get_skill_icon(skill: CharacterSkill) -> SkillIcon:
	if skill in skill_icons:
		skill_icons[skill].show();
		return skill_icons[skill];
	else:
		var new_icon : SkillIcon = item_icon_pckd.instantiate();
		container.add_child(new_icon);
		skill_icons[skill] = new_icon;
		new_icon.pressed.connect(skill_pressed.emit.bind(skill));
		return new_icon;
