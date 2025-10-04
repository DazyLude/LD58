extends CharacterSkill
class_name Flee


func execute(user: Character, _target: Character):
	user.on_flight();
