extends CharacterBody2D

@export var speed = 300
@export var playerSprite = Sprite2D
@export var direction : Vector2 = Vector2(0,0)
@export var health = 100.0

@export_group("challenge")
#Challenge: Create a reload mechanic
@export var isReloading: bool = false
@export var score = 0

signal GameOver

func CheckIsMoving():
	if isReloading:
		return
	if velocity.length() > 0.0:
		# play the animation
		playerSprite.play_run_animation()
	else:
		playerSprite.play_idle_animation()
			
func CheckIfReload() -> void:
	if Input.is_action_just_released("reload"):
		playerSprite.player_shoot_animation()
		isReloading = true
		await playerSprite.getAnimator().animation_finished
		isReloading = false

func CheckHurtBox():
	var collidingEnemies = %DamageBox.get_overlapping_bodies()
	if collidingEnemies.size() > 0:
		for mob in collidingEnemies:
			if not mob.isAttacking and not mob.isHurt:
				health -= mob.GetDamageValue()
				%HealthBar.value = health
				mob.Attack()
				print_debug("player health: " + str(health))
			if health <= 0.0:
				playerSprite.PlayDeadAnimation()
				await playerSprite.getAnimator().animation_finished
				playerSprite.visible = false
				
				# Show GameOver
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				%GameOverMenu.UpdateScore(score)
				%GameOverMenu.visible = true


func _ready():
	print_debug("hello world!")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		# escape key pressed
	if event.is_action_pressed("ui_cancel"):
		# releases cursor allowing the player to move 
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	

func _physics_process(delta):
	if health > 0 and not isReloading:
		direction = Input.get_vector("left", "right", "up", "down")
		velocity = direction * speed 
		CheckIfReload()
		CheckIsMoving()
		CheckDirection(direction)
		move_and_slide()
		CheckHurtBox()

func CheckDirection(dir) -> void:
	var directionInput = Input.get_axis("left", "right")
	if directionInput < 0:
		%PlayerSprite.flip_h = true
	if directionInput > 0:
		%PlayerSprite.flip_h = false

func _on_increasePlayerScore(scoreValue):
	score += scoreValue
	print_debug("Player score: ",score)
	
