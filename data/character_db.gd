extends Node
class_name CharactersDBClass


var character_packed_scenes : Dictionary[String, PackedScene] = {
	"frogbert": preload("res://scenes/characters/frogbert.tscn"),
	
	"slime1": preload("res://scenes/characters/slime1.tscn"),
	"slime2": preload("res://scenes/characters/slime2.tscn"),
	"slime3": preload("res://scenes/characters/slime3.tscn"),
	
	"jabich": preload("res://scenes/characters/jabich.tscn"),
	
	"placeholder": preload("res://scenes/character.tscn"),
}


func get_character_scene(character: String) -> PackedScene:
	return character_packed_scenes.get(character, preload("res://scenes/character.tscn"));
