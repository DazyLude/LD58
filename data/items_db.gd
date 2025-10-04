extends Node
class_name ItemsDBClass

const ROOT := "res://scenes/items/";
var items : Dictionary[String, PackedScene] = {};

var item_skills : Dictionary[String, Script] = {
	"shield": Block.Shield,
}


func _init() -> void:
	for file in DirAccess.get_files_at(ROOT):
		var path = ROOT.path_join(file);
		if ResourceLoader.exists(path):
			var resource := load(path);
			if resource is PackedScene:
				var instance = resource.instantiate();
				if instance is Item:
					items[instance.item_name] = resource;


func get_item(item: String) -> PackedScene:
	return items.get(item, items[Item.PLACEHOLDER_NAME]);


func get_item_skill(item: String) -> Script:
	return item_skills.get(item, null);
