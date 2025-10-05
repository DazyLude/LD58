extends Node2D
class_name Level


const RUN_SPEED := 75.0;
const ITEM_DROP_INTERVAL := 0.5;

var frogbert_pckd : PackedScene = CharactersDB.get_character_scene("frogbert");
var level_data : LevelData = null;

@onready
var player_root : Node2D = $Player;
var player_node : Character = null;


var items : Array[Item] = [];
var enemies : Dictionary[Area2D, Character] = {};
var boss_node : Character = null;

@onready
var battle_manager : BattleManager = $BattleManager;
var in_battle : bool = false;
var fleeing : bool = false;
var dead : bool = false;

@onready
var inventory : LevelInventoryDisplay = $UI/Inventory;
var inventory_tween : Tween = null;
@onready
var skills : LevelSkillDisplay = $UI/Skills;


func _ready() -> void:
	GameState.player_stats.hp = GameState.player_stats.max_hp;
	spawn_player();
	
	level_data = GameState.level if GameState.level != null else LevelsDB.forest;
	setup_backgrounds();
	
	spawn_items();
	spawn_enemies();
	spawn_boss();
	
	update_item_related();
	skills.skill_pressed.connect(skill_used);
	player_node.walk();
	
	player_node.fled.connect(flee_sequence);


func _process(delta: float) -> void:
	if in_battle:
		pass;
	elif fleeing:
		player_node.position -= Vector2(RUN_SPEED * delta, 0.0);
	elif dead:
		pass;
	else:
		player_root.position += Vector2(RUN_SPEED * delta, 0.0);


func setup_backgrounds() -> void:
	$Background/Horizon.repeat_size.x = level_data.parallax_horizon_width;
	$Background/Horizon/Sprite2D.texture = level_data.parallax_horizon;
	
	$Background/Back.repeat_size.x = level_data.parallax_back_width;
	$Background/Back/Sprite2D.texture = level_data.parallax_back;
	
	$Background/Main.repeat_size.x = level_data.parallax_main_width;
	$Background/Main/Sprite2D.texture = level_data.parallax_main;
	
	$FrontGround/Front.repeat_size.x = level_data.parallax_front_width;
	$FrontGround/Front/Sprite2D.texture = level_data.parallax_front;


func spawn_enemies() -> void:
	for x in range(
		level_data.enemy_start_margin,
		level_data.boss_distance - level_data.enemy_end_margin,
		level_data.enemy_distance):
			var enemy = level_data.select_random_enemy();
			spawn_enemy(enemy, x);


func spawn_boss() -> void:
	var boss = spawn_enemy(level_data.boss, level_data.boss_distance);
	boss_node = boss;


func spawn_enemy(enemy: String, at: float) -> Character:
	var enemy_node : Character = CharactersDB.get_character_scene(enemy).instantiate();
	enemy_node.position = Vector2(at, $Player/PlayerSpawn.position.y);
	$Enemies.add_child(enemy_node);
	enemies[enemy_node.hitbox] = enemy_node;
	return enemy_node;


func spawn_player() -> void:
	player_node = frogbert_pckd.instantiate();
	
	player_node.stats = GameState.player_stats;
	player_node.inventory = GameState.inventory;
	
	player_node.position = $Player/PlayerSpawn.position;
	$Player.add_child(player_node);
	player_node.encounter.connect(on_encounter);


func spawn_items() -> void:
	for x in range(
		level_data.item_start_margin,
		level_data.boss_distance - level_data.item_end_margin,
		level_data.item_distance):
			var item = level_data.select_random_item();
			spawn_item(item, x);


func spawn_item(item: String, x: float, y: float = 400.0) -> Item:
	var item_node : Item = ItemsDB.get_item(item).instantiate();
	item_node.position = Vector2(x, y);
	$Items.add_child(item_node);
	item_node.picked.connect(on_item_picked.bind(item_node));
	return item_node;


func on_item_picked(_event_position: Vector2, item_node: Item) -> void:
	if item_node != null:
		GameState.inventory.add_item(item_node);
		item_node.hide();
	update_item_related();


func update_item_related() -> void:
	inventory.update();
	player_node.update_item_skills();
	player_node.update_item_buffs();
	skills.update(self, player_node);
	check_overweight();


func check_overweight() -> void:
	var weight = GameState.inventory.current_weight;
	var limit = GameState.player_stats.weight_capacity;
	if weight > limit:
		start_losing_it();
	else:
		stop_losing_it();


func start_losing_it() -> void:
	inventory.start_shake();
	
	if inventory_tween != null:
		inventory_tween.kill();
	
	inventory_tween = create_tween();
	inventory_tween.tween_interval(ITEM_DROP_INTERVAL);
	inventory_tween.tween_callback(drop_item);
	inventory_tween.tween_callback(update_item_related);


func stop_losing_it() -> void:
	inventory.stop_shake()
	if inventory_tween != null:
		inventory_tween.kill();


func get_player_scene_position() -> Vector2:
	return $Player.position + player_node.position;


func drop_item(item := GameState.inventory.drop_random_item(), from: Character = player_node) -> void:
	var item_position : Vector2;
	
	if from == player_node:
		item_position = get_player_scene_position();
	else:
		item_position = from.position;
	
	var item_node := spawn_item(item, item_position.x, item_position.y);
	var item_position_dupe = Vector2(item_position);
	
	var item_x_speed := RUN_SPEED * (randf_range(-0.5, 3.0) - (1.0 if in_battle else 0.0));
	var item_y_peak := randf_range(120.0, 240.0);
	var fall_time := 1.0;
	
	var tween = create_tween();
	tween.tween_property(item_node, ^"position:x", item_node.position.x + item_x_speed * fall_time, fall_time);
	
	var gravity_tween = create_tween();
	gravity_tween.set_trans(Tween.TRANS_QUAD);
	gravity_tween.tween_property(item_node, ^"position:y", item_y_peak, fall_time / 2).set_ease(Tween.EASE_OUT);
	gravity_tween.tween_property(item_node, ^"position:y", item_position_dupe.y, fall_time / 2).set_ease(Tween.EASE_IN);


func on_encounter(other_area: Area2D) -> void:
	var enemy : Character = enemies.get(other_area);
	if enemy != null:
		start_fight(player_node, enemy);


func start_fight(one: Character, another: Character) -> void:
	in_battle = true;
	one.enter_battle();
	another.enter_battle();
	
	battle_manager.initiate_fight(one, another);
	await battle_manager.battle_ended;
	
	resolve_battle(another, another == boss_node);


func resolve_battle(opponent: Character, with_boss: bool = false) -> void:
	in_battle = false;
	match battle_manager.battle_state.get(player_node):
		BattleManager.STATE_FIGHTING when with_boss:
			victory_sequence();
		BattleManager.STATE_FIGHTING:
			if opponent.drop != "":
				drop_item(opponent.drop, opponent);
			player_node.walk();
		BattleManager.STATE_FLED:
			flee_sequence();
		BattleManager.STATE_DIED:
			death_sequence();


func flee_sequence() -> void:
	if not fleeing:
		fleeing = true;
		player_node.walk();
		await get_tree().create_timer(4.0).timeout;
		get_tree().change_scene_to_file("res://scenes/town/town.tscn");


func death_sequence() -> void:
	dead = true;
	await get_tree().create_timer(2.0).timeout;
	get_tree().change_scene_to_file("res://scenes/town/town.tscn");


func victory_sequence() -> void:
	player_node.walk();
	await get_tree().create_timer(2.0).timeout;
	get_tree().change_scene_to_file("res://scenes/town/town.tscn");


func skill_used(skill: CharacterSkill) -> void:
	if in_battle:
		var combatants = battle_manager.battle_state.keys();
		var target = skill.targeting_strategy.select(combatants, player_node);
		skill.execute(player_node, target);
	else:
		skill.execute(player_node, player_node);
	
	update_item_related();
