extends Control


var MasterBusIndex: int = AudioServer.get_bus_index("Master");
var MusicBusIndex: int = AudioServer.get_bus_index("Music");
var EffectsBusIndex: int = AudioServer.get_bus_index("Effects");


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level/level.tscn");
	
	
func _on_tutorial_button_pressed() -> void:
	pass


func _on_music_toggle() -> void:
	AudioServer.set_bus_mute(MusicBusIndex, not AudioServer.is_bus_mute(MusicBusIndex));


func _on_effects_toggle() -> void:
	AudioServer.set_bus_mute(EffectsBusIndex, not AudioServer.is_bus_mute(EffectsBusIndex));


func _ready() -> void:
	$MainButtons/PlayButton.pressed.connect(_on_play_button_pressed);
	$MainButtons/TutorialButton.pressed.connect(_on_tutorial_button_pressed);
	
	$SoundButtons/ToggleMusic.pressed.connect(_on_music_toggle);
	$SoundButtons/ToggleSFX.pressed.connect(_on_effects_toggle);
	
	# BgmPlayer.change_track(BgmPlayer.SoundID.Music1);
