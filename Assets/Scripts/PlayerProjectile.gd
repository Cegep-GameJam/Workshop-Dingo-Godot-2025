extends Area2D


const PROJECTILE_SPEED  = 750
const RANGE = 1200

@export var bullet_direction : Vector2 = Vector2(0,0) 
@export var bullet_range = 0

func checkTravelExpiry(range):
	if bullet_range > RANGE:
		queue_free()

func _physics_process(delta):
	bullet_direction = Vector2.RIGHT.rotated(rotation)
	position += bullet_direction * PROJECTILE_SPEED * delta
	bullet_range += PROJECTILE_SPEED * delta
	
	#check for travel range and then expire
	checkTravelExpiry(bullet_range)

func _on_body_entered(body: Node2D) -> void:
	%AnimatedSprite2D.play("explode")
	if body.has_method("take_damage"):
		body.take_damage()
	## wait until the explosion is finished before removing the gameobject
	await %AnimatedSprite2D.animation_finished	
	queue_free()
