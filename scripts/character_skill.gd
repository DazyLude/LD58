@abstract
extends RefCounted
class_name CharacterSkill
# strategy pattern


var targeting_strategy : TargetingStrategy = TargetingStrategyOther.new();


@abstract
func execute(user: Character, target: Character);
