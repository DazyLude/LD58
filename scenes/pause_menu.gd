extends Control


var MasterBusIndex: int = AudioServer.get_bus_index("Master");
var MusicBusIndex: int = AudioServer.get_bus_index("Music");
var EffectsBusIndex: int = AudioServer.get_bus_index("Effects");


func _on_continue_button_pressed() -> void:
	pass; # TODO


func _on_mainmenu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn");


func _on_music_toggle() -> void:
	AudioServer.set_bus_mute(MusicBusIndex, not AudioServer.is_bus_mute(MusicBusIndex));


func _on_effects_toggle() -> void:
	AudioServer.set_bus_mute(EffectsBusIndex, not AudioServer.is_bus_mute(EffectsBusIndex));


func _ready() -> void:
	var is_music_muted: bool = AudioServer.is_bus_mute(MusicBusIndex);
	var is_effects_muted: bool = AudioServer.is_bus_mute(EffectsBusIndex);
	$SoundButtons/ToggleMusic.set_pressed_no_signal(is_music_muted);
	$SoundButtons/ToggleSFX.set_pressed_no_signal(is_effects_muted);
	
	$MainButtons/Continue.pressed.connect(_on_continue_button_pressed);
	$MainButtons/MainMenu.pressed.connect(_on_mainmenu_button_pressed);
	
	$SoundButtons/ToggleMusic.pressed.connect(_on_music_toggle);
	$SoundButtons/ToggleSFX.pressed.connect(_on_effects_toggle);
