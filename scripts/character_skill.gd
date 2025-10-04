@abstract
extends RefCounted
class_name CharacterSkill
# strategy pattern


var targeting_strategy : TargetingStrategy = TargetingStrategyOther.new();
var icon : Texture2D = null;
var cooldown : float = 1.0;


@abstract
func execute(user: Character, target: Character);


@warning_ignore("unused_parameter")
func can_be_used(context: Level) -> bool:
	return true;
