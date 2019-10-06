extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -500

const GUN_ROTATION_SPEED = 0.5
var gun_rotation = 0


func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	else:
		motion.x = 0

	if Input.is_action_pressed("w"):
		gun_rotation -= delta*GUN_ROTATION_SPEED
	elif Input.is_action_pressed("s"):
		gun_rotation += delta*GUN_ROTATION_SPEED
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	motion = move_and_slide(motion, UP)
	
	set_gun_rotation()

func hit():
	print("morri")

func enable_faca():
	$Faca.visible = true
	$Faca.get_node("CollisionShape2D").disabled = false

func enable_pistola():
	$Pistola.visible = true

func enable_metralhadora():
	$Metralhadora.visible = true

func _on_Faca_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage()

func set_gun_rotation():
	if $Pistola.visible:
		$Pistola.set_rotation(gun_rotation)
	if $Metralhadora.visible:
		$Metralhadora.set_rotation(gun_rotation)

func shoot():
	if $Pistola.visible:
		$Pistola.shoot()
	if $Metralhadora.visible:
		$Metralhadora.shoot()
