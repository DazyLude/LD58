extends TargetingStrategy
class_name TargetingStrategyOther


func select(targets: Array[Character], user: Character) -> Character:
	var targets_without_user = targets.duplicate();
	targets_without_user.erase(user);
	
	if targets_without_user.size() > 0:
		return targets_without_user.pick_random();
	else:
		return null;
