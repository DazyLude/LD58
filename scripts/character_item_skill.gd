extends CharacterSkill
class_name CharacterItemSkill


var skill : CharacterSkill = null;
var usable_out_of_combat : bool = false;
var associated_item : String = "";
var cost : int = 0;


func execute(user: Character, target: Character):
	if skill == null:
		push_error("can't use item skill without connected skill");
		return;
	
	if cost > 0:
		GameState.inventory.remove_item_by_name(associated_item, cost);
		skill.execute(user, target);


func can_be_used(context: Level) -> bool:
	var has_item := GameState.inventory.contents.has(associated_item);
	var has_enough : bool = cost <= GameState.inventory.contents.get(associated_item, -1);
	var battle_check := usable_out_of_combat or context.in_battle;
	
	return has_item and has_enough and battle_check;
