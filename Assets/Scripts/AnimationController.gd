extends Sprite2D

func play_idle_animation():
	%PlayerAnimation.play("Idle")


func play_run_animation():
	%PlayerAnimation.play("Run")

func player_shoot_animation():
	%PlayerAnimation.play("Shoot")

func stopAnimation():
	%PlayerAnimation.stop()

func PlayDeadAnimation():
	%PlayerAnimation.play("Dead")

func getIsPlaying() -> bool:
	return %PlayerAnimation.is_playing()
	
func getAnimator() -> AnimationPlayer:
	return %PlayerAnimation
