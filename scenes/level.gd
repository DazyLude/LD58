extends Node2D
class_name Level


const RUN_SPEED := 50.0;

var character_pckd : PackedScene = preload("res://scenes/character.tscn");
var item_pckd : PackedScene = preload("res://scenes/item.tscn");

@onready
var player_root : Node2D = $Player;
var player_node : Character = null;


var items : Array[Item] = [];
var enemies : Dictionary[Area2D, Character] = {};

@onready
var battle_manager : BattleManager = $BattleManager;
var in_battle : bool = false;


func _ready() -> void:
	spawn_player();
	spawn_items();
	spawn_enemy(750.0);


func _process(delta: float) -> void:
	if not in_battle:
		player_root.position += Vector2(RUN_SPEED * delta, 0.0);


func spawn_enemy(at: float) -> void:
	var enemy_node : Character = character_pckd.instantiate();
	enemy_node.position = Vector2(at, $Player/PlayerSpawn.position.y);
	$Enemies.add_child(enemy_node);
	enemies[enemy_node.hitbox] = enemy_node;


func spawn_player() -> void:
	player_node = character_pckd.instantiate();
	player_node.position = $Player/PlayerSpawn.position;
	$Player.add_child(player_node);
	player_node.encounter.connect(on_encounter);


func spawn_items() -> void:
	for x in range(500.0, 2000.0, 250.0):
		spawn_item(x);


func spawn_item(at: float) -> void:
	var item : Item = item_pckd.instantiate();
	item.position = Vector2(at, 600.0);
	$Items.add_child(item);
	item.picked.connect(on_item_picked.bind(item));


func on_item_picked(_event_position: Vector2, item_node: Item) -> void:
	item_node.hide();


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
	in_battle = false;
