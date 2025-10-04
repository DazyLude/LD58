extends Control
class_name ItemIcon

const SIZE := Vector2(64.0, 64.0);

var item_scene : Item;


func set_item(item: String, count: int) -> void:
	if item_scene != null:
		remove_child(item_scene);
		item_scene.queue_free();
	
	item_scene = ItemsDB.get_item(item).instantiate();
	add_child(item_scene);
	
	var item_rect := item_scene.sprite.get_rect();
	var scale_vec := SIZE / item_rect.size;
	var scale_factor := minf(scale_vec.x, scale_vec.y);
	
	item_scene.position = -item_rect.position * scale_factor;
	item_scene.scale = Vector2(scale_factor, scale_factor);
	
	move_child($Label, item_scene.get_index())
	$Label.position = SIZE * 0.4;
	$Label.text = "%d" % count;
