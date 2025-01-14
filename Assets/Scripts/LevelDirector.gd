extends Node2D


func SpawnKnight():
	var new_mob = preload("res://Assets/Scenes/enemy1.tscn").instantiate()
	%KnightSpawnPoints.progress_ratio = randf()
	new_mob.global_position = %KnightSpawnPoints.global_position
	add_child(new_mob)


func _on_knight_spawn_timer_timeout() -> void:
	print_debug("spawn a knight")
	SpawnKnight()


func _on_player_game_over() -> void:
	get_tree().paused = true
