extends Node
class_name PolyphonicSfxPlayer


func play_sound(sound: AudioStream) -> void:
	var node := AudioStreamPlayer.new();
	node.bus = &"Effects";
	node.stream = sound;
	add_child(node);
	node.play()
	await node.finished;
	node.queue_free();
