extends Node
class_name GameStateClass


var inventory := InventoryManager.new();
var player_stats := PlayerStats.new();

var cash : float = 0.0;
var level : LevelData = null;
var progress : int = 0;
