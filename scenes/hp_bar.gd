extends Node2D
class_name HPDisplay


var tracking_stats : CharacterStats;


func connect_character(character: Character) -> void:
	tracking_stats = character.stats;
	$ProgressBar.min_value = 0.0;
	$ProgressBar.max_value = tracking_stats.max_hp;


func _process(_delta: float) -> void:
	if tracking_stats != null:
		if tracking_stats.blocking:
			$Label.text = "shielded";
		else:
			$ProgressBar.value = tracking_stats.hp;
			$Label.text = "%d" % tracking_stats.hp;
