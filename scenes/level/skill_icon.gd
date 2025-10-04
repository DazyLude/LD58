extends Button
class_name SkillIcon

const SIZE := Vector2(64.0, 64.0);

var skill_cache : CharacterSkill = null;
var level_cache : Level = null;


func _ready() -> void:
	pressed.connect(start_cooldown);


func _process(delta: float) -> void:
	if $ProgressBar.value > $ProgressBar.min_value:
		$ProgressBar.value -= delta;
	
	disabled = $ProgressBar.value > $ProgressBar.min_value or not skill_cache.can_be_used(level_cache);


func start_cooldown() -> void:
	$ProgressBar.value = $ProgressBar.max_value;


func set_skill(skill: CharacterSkill, character: Character, level: Level) -> void:
	if skill_cache != skill:
		skill_cache = skill;
		self.icon = skill.icon;
		$ProgressBar.min_value = 0.0;
		$ProgressBar.max_value = skill.cooldown * character.stats.attack_speed;
	
	if level != level_cache:
		level_cache = level;
	
	if skill is CharacterItemSkill:
		$Label.show();
		$Label.position = SIZE * 0.8;
		$Label.text = "%d" % GameState.inventory.get_item_count_by_name(skill.associated_item);
	else:
		$Label.hide();
