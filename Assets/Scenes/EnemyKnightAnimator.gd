extends Node2D

@onready var sprite = %KnightSprite

func PlayRunAnimation():
	%EnemyAnimator.play("run")

func PlayHurtAnimation():
	%EnemyAnimator.play("hurt")

func PlayDeadAnimation():
	%EnemyAnimator.play("dead")

func PlayAttackAnimation():
	%EnemyAnimator.play("attack")
	
func PlayIdleAnimation():
	%EnemyAnimator.play("idle")

func stopAnimation():
	%EnemyAnimator.stop()

func getIsPlaying() -> bool:
	return %EnemyAnimator.is_playing()
	
func getAnimator() -> AnimationPlayer:
	return %EnemyAnimator
