extends Control


func _on_go_main_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/MainMenu.tscn")


func _on_restart_game_pressed() -> void:
	get_tree().reload_current_scene()

func UpdateScore(score):
	%HighScore.text = "High Score: " + str(score)
