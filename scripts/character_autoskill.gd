extends CharacterSkill
class_name CharacterAutoSkill


var autocast_time : float;
var skill : CharacterSkill = null;


func execute(user: Character, target: Character):
	if skill == null:
		push_error("can't use autoskill without connected skill");
		return;
	
	skill.execute(user, target);
