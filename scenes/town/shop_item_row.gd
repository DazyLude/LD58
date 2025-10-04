extends Panel
class_name ShopItemRow


signal pressed;


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			pressed.emit();
			get_viewport().set_input_as_handled();


func set_item(item: String, description: String, count: int, price: int) -> void:
	visible = count >= 1;
	
	$HBoxContainer/ItemIcon.set_item(item, count);
	$HBoxContainer/ItemIcon.tooltip_text = description;
	$HBoxContainer/Name.text = item;
	$HBoxContainer/Cost.text = "%d" % price;
