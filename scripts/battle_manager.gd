extends Node
class_name BattleManager


enum {
	STATE_FIGHTING,
	STATE_FLED,
	STATE_DIED,
}


signal battle_ended;


var skill_tweens : Dictionary[CharacterAutoSkill, Tween] = {};
var battle_state : Dictionary[Character, int] = {};


func initiate_fight(...participants: Array) -> void:
	battle_state.clear();
	var participant_characters : Array[Character] = Array(
		participants.filter(func(p): return p is Character), TYPE_OBJECT, &"Node2D", Character
	);
	
	for participant in participant_characters:
		participant.slain.connect(on_death.bind(participant));
		participant.fled.connect(on_flight.bind(participant));
		battle_state[participant] = STATE_FIGHTING;
		
		for skill in participant.auto_skills:
			queue_cast(participant, skill);


func queue_cast(user: Character, skill: CharacterAutoSkill) -> void:
	var tween := create_tween();
	skill_tweens[skill] = tween;
	tween.tween_interval(skill.cooldown * user.stats.attack_speed * randf_range(0.95, 1.05));
	tween.tween_callback(cast_skill.bind(user, skill));


func cast_skill(user: Character, skill: CharacterAutoSkill) -> void:
	skill.execute(user, skill.targeting_strategy.select(get_active_participants(), user))
	queue_cast(user, skill);
	check_battle_result();


func stop_battle() -> void:
	for skill in skill_tweens:
		skill_tweens[skill].kill();
	
	skill_tweens.clear();
	
	for participant in battle_state:
		participant.slain.disconnect(on_death);
		participant.fled.disconnect(on_flight);


func on_flight(character: Character) -> void:
	battle_state[character] = STATE_FLED;


func on_death(character: Character) -> void:
	battle_state[character] = STATE_DIED;


func get_active_participants() -> Array[Character]:
	var result : Array[Character] = [];
	
	for ch in battle_state:
		if battle_state[ch] == STATE_FIGHTING:
			result.push_back(ch);
	
	return result;


func check_battle_result() -> void:
	var still_fighting = get_active_participants().size();
	if still_fighting <= 1:
		stop_battle();
		battle_ended.emit();
