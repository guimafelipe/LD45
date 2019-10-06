extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -500

const GUN_ROTATION_SPEED = 0.5
var gun_rotation = 0

var is_flipped = false

var can_move = false

signal morri

func _physics_process(delta):
	motion.y += GRAVITY
	
	if can_move and Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		is_flipped = false
		if is_on_floor():
			$Sprite.play("walking")
	elif can_move and Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		is_flipped = true
		if is_on_floor():
			$Sprite.play("walking")
	else:
		if is_on_floor():
			$Sprite.play("idle")
		motion.x = 0
	
	if is_flipped:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	
	flip_gun(is_flipped)
	
	if can_move and Input.is_action_pressed("w"):
		gun_rotation -= delta*GUN_ROTATION_SPEED
	elif can_move and Input.is_action_pressed("s"):
		gun_rotation += delta*GUN_ROTATION_SPEED
	
	if is_on_floor():
		if can_move and Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT
	else:
		$Sprite.play("jump")
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	motion = move_and_slide(motion, UP)
	
	set_gun_rotation()

func hit():
	emit_signal("morri")
	queue_free()

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
	var actual_gun_rotation = gun_rotation
	if is_flipped:
		actual_gun_rotation = -gun_rotation
	if $Pistola.visible:
		$Pistola.set_rotation(actual_gun_rotation)
	if $Metralhadora.visible:
		$Metralhadora.set_rotation(actual_gun_rotation)

func shoot():
	if $Pistola.visible:
		$Pistola.shoot()
	if $Metralhadora.visible:
		$Metralhadora.shoot()

func flip_gun(to_left):
	if(to_left):
		if $Faca.visible :
			if $Faca.position.x > 0:
				$Faca.position.x *= -1
				$Faca/Sprite.flip_h = true
		if $Pistola.visible:
			$Pistola.flipped = true
		if $Metralhadora.visible:
			$Metralhadora.flipped = true
	else:
		if $Faca.visible:
			if $Faca.position.x < 0:
				$Faca.position.x *= -1
				$Faca/Sprite.flip_h = false
		if $Pistola.visible:
			$Pistola.flipped = false
		if $Metralhadora.visible:
			$Metralhadora.flipped = false
