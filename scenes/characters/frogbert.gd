extends Character


func on_death() -> void:
	super.on_death();
	$AnimatedSprite.play(&"idle");


func on_flight() -> void:
	super.on_flight();
	$AnimatedSprite.play(&"walk");


func enter_battle() -> void:
	super.enter_battle();
	$AnimatedSprite.play(&"battle");


func idle() -> void:
	super.idle();
	$AnimatedSprite.play(&"idle");


func walk() -> void:
	super.walk();
	$AnimatedSprite.play(&"walk");


func attack() -> void:
	super.attack();
	$AnimatedSprite.play(&"attack");
	await $AnimatedSprite.animation_finished;
	$AnimatedSprite.play(&"battle");
