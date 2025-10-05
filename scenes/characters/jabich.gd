extends AnimatedCharacter


func _init() -> void:
	auto_skills.clear();
	auto_skills.push_back(BasicAttack.Jabich.new());


@export var attack_speed_override : float = 1.0;
@export var attack_override : float = 5.0;
@export var hp_override : float = 50.0;
@export var boss_name : String = "";

@onready var throw_from : Marker2D = $ThrowOrigin;


func _ready() -> void:
	stats.attack = attack_override;
	stats.attack_speed = attack_speed_override;
	stats.max_hp = hp_override;
	stats.hp = hp_override;
	
	super._ready();


func attack() -> void:
	super.attack();
