extends Area2D

onready var PlayerClass = preload("res://Scripts/Jeremias.gd")

func _on_FacaPickable_body_entered(body):
	if body is PlayerClass:
		body.enable_faca()
		queue_free()