extends Node


enum SoundID {
	Music1,
	Music2
}


const uid_per_sound_id : Dictionary[SoundID, String] = {
	SoundID.Music1: "",
	SoundID.Music2: ""
}


const TRANSITION_TIME : float = 2.0;


var current_track : SoundID = -1;
var last_player : AudioStreamPlayer;
var player_tweens : Dictionary[AudioStreamPlayer, Tween];


func add_player() -> AudioStreamPlayer:
	var new_player = AudioStreamPlayer.new();
	new_player.bus = &"Music";
	
	player_tweens[new_player] = null;
	add_child(new_player);
	
	return new_player;


func remove_player(player: AudioStreamPlayer) -> void:
	if player_tweens[player]:
		player_tweens[player].kill();
	
	player_tweens.erase(player);
	remove_child(player);


func change_track(new_track: SoundID) -> void:
	if new_track == current_track:
		return;
	current_track = new_track;
	
	if last_player != null:
		if player_tweens[last_player]:
			player_tweens[last_player].kill();
		var lp_tween = create_tween();
		lp_tween.set_trans(Tween.TRANS_QUINT);
		player_tweens[last_player] = lp_tween;
		
		lp_tween.tween_property(last_player, ^"volume_linear", 0.0, TRANSITION_TIME);
		lp_tween.tween_callback(remove_player.bind(last_player));
	
	var new_player = add_player();
	last_player = new_player;
	
	var stream := ResourceLoader.load(uid_per_sound_id[new_track]);
	match stream: # set up looping
		_ when stream is AudioStreamWAV:
			stream.loop_mode = AudioStreamWAV.LoopMode.LOOP_FORWARD;
			stream.loop_end = stream.get_length() * stream.mix_rate;
		_ when stream is AudioStreamMP3 or stream is AudioStreamOggVorbis:
			stream.loop = true;
		_:
			# other cases not implemented
			push_warning(
				"unexpected music stream type for %s, looping won't work"
				% SoundID.find_key(new_track)
			);
	
	new_player.stream = stream;
	new_player.volume_linear = 0.0;
	
	var np_tween = create_tween();
	np_tween.set_trans(Tween.TRANS_QUINT);
	player_tweens[new_player] = np_tween;
	
	np_tween.tween_property(new_player, ^"volume_linear", 1.0, TRANSITION_TIME);
	new_player.play();


func _ready() -> void:
	pass;
