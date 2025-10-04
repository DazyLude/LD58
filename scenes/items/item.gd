extends Node2D
class_name Item


signal picked(event_pos)
signal dropped(event_pos)


var hovered : bool = false;
var held : bool = false;


@export var item_name : String = "placeholder item";


func _ready() -> void:
	$Area2D.mouse_entered.connect(_on_hover);
	$Area2D.mouse_exited.connect(_on_stop_hover);


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_LEFT when event.pressed and hovered and not held:
				_on_pick(event.position);
				get_viewport().set_input_as_handled();
			MOUSE_BUTTON_LEFT when not event.pressed and held:
				_on_drop(event.position);
				get_viewport().set_input_as_handled();


func _on_hover() -> void:
	hovered = true;


func _on_stop_hover() -> void:
	hovered = false;


func _on_pick(mouse_pos: Vector2) -> void:
	picked.emit(mouse_pos);


func _on_drop(mouse_pos: Vector2) -> void:
	dropped.emit(mouse_pos);
