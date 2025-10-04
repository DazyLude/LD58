extends Control
class_name ItemIcon

const SIZE := Vector2(64.0, 64.0);
const SHAKE_AMP : float = 3.0;

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


func shake() -> void:
	if item_scene != null:
		var item_rect := item_scene.sprite.get_rect();
		var scale_vec := SIZE / item_rect.size;
		var scale_factor := minf(scale_vec.x, scale_vec.y);
		var rand_vec = Vector2(randf_range(-SHAKE_AMP, SHAKE_AMP), randf_range(-SHAKE_AMP, SHAKE_AMP));
		
		item_scene.position = -item_rect.position * scale_factor + rand_vec;
		item_scene.rotation_degrees = randf_range(-SHAKE_AMP, SHAKE_AMP);


func reset_shake() -> void:
	if item_scene != null:
		var item_rect := item_scene.sprite.get_rect();
		var scale_vec := SIZE / item_rect.size;
		var scale_factor := minf(scale_vec.x, scale_vec.y);
		
		item_scene.position = -item_rect.position * scale_factor;
		item_scene.rotation = 0.0;
