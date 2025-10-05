extends Character


var body_deform_tween : Tween = null;

@export var attack_speed_override : float = 1.0;
@export var attack_override : float = 5.0;
@export var hp_override : float = 50.0;


func _ready() -> void:
	stats.attack = attack_override;
	stats.attack_speed = attack_speed_override;
	stats.max_hp = hp_override;
	stats.hp = hp_override;
	
	super._ready();


func on_death() -> void:
	if body_deform_tween != null:
		body_deform_tween.kill();
	
	super.on_death();


func enter_battle() -> void:
	super.enter_battle();


func attack() -> void:
	super.attack();
	
	if body_deform_tween != null:
		body_deform_tween.kill();
	
	body_deform_tween = create_tween();
	
	body_deform_tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT);
	body_deform_tween.tween_property($Sprite2D, ^"scale", Vector2(0.95, 1.05), wind_up);
	body_deform_tween.parallel().tween_property($Sprite2D, ^"rotation", 0.05, wind_up);
	
	body_deform_tween.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN);
	body_deform_tween.tween_property($Sprite2D, ^"scale", Vector2(1.05, 0.95), 0.05 / stats.attack_speed);
	body_deform_tween.parallel().tween_property($Sprite2D, ^"rotation", -0.1, 0.05 / stats.attack_speed);
	
	body_deform_tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT_IN);
	body_deform_tween.tween_property($Sprite2D, ^"scale", Vector2(1., 1.), 0.2 / stats.attack_speed);
	body_deform_tween.parallel().tween_property($Sprite2D, ^"rotation", 0.0, 0.2 / stats.attack_speed);
