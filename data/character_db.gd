extends Node
class_name CharactersDBClass


var character_packed_scenes : Dictionary[String, PackedScene] = {
	"frogbert": preload("res://scenes/characters/frogbert.tscn"),
	"placeholder": preload("res://scenes/character.tscn"),
}


func get_character_scene(character: String) -> PackedScene:
	return character_packed_scenes.get(character, preload("res://scenes/character.tscn"));
