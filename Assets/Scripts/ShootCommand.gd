extends Node2D

@onready var aimDirectionIcon = %AimDirection

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

func shootBullet():
	const BULLET = preload("res://Assets/Scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	# instantiate bullet at the position of the new bullet object
	new_bullet.global_rotation = %marker.global_rotation
	new_bullet.transform = %marker.global_transform
	#shoot_point.add_child(new_bullet)
	owner.get_parent().add_child(new_bullet)


# We connected the Timer Node to the Aim node
func _on_shoot_cool_down_timeout() -> void:
	shootBullet()
