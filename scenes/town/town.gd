extends Node2D


@onready
var shop : Shop = $UI/Panel/MarginContainer/Shop;


func _ready() -> void:
	shop.update_all();
