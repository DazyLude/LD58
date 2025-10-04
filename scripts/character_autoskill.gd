extends CharacterSkill
class_name CharacterAutoSkill


var skill : CharacterSkill = null;


func execute(user: Character, target: Character):
	if skill == null:
		push_error("can't use autoskill without connected skill");
		return;
	
	skill.execute(user, target);


@warning_ignore("unused_parameter")
func can_be_used(context: Level) -> bool:
	return true;
