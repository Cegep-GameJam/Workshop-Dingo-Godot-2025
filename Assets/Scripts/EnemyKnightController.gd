extends CharacterBody2D

@export var direction : Vector2 = Vector2(0,0)
@export var speed = 100.0
@onready var player = get_node("/root/GameScene/Player")
@export var enemySprite = Node2D
@export var health = 3
@export var damage = 20.0

@export_group("states")
@export var isHurt = false
@export var isDead = false
@export var isAttacking = false

#preload the smoke and instatiate smoke

func _init():
	print_debug("enemy mob initiated")

func CheckIsMoving():
	if velocity.length() > 0.0:
		# play the animation
		enemySprite.PlayRunAnimation()
	else:
		enemySprite.PlayIdleAnimation()

func GetDamageValue() -> int:
	return damage

func FlipSprite():
	if player.position.x < position.x:
		enemySprite.sprite.flip_h = true
	else:
		enemySprite.sprite.flip_h = false

func take_damage():
	if health == 0:
		isDead = true
		%Audio.play()
		enemySprite.PlayDeadAnimation()
		await enemySprite.getAnimator().animation_finished
		queue_free()
	else:
		health -= 1
		isHurt = true
		enemySprite.PlayHurtAnimation()
		await enemySprite.getAnimator().animation_finished
		isHurt = false

func Attack():
	isAttacking = true
	enemySprite.PlayAttackAnimation()
	await  enemySprite.getAnimator().animation_finished
	isAttacking = false

func _physics_process(delta):
	if not isHurt and not isDead and not isAttacking:
		FlipSprite()
		CheckIsMoving()
		direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
