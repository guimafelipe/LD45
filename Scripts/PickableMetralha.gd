extends Area2D

func _on_PickableMetralha_body_entered(body):
	if body.has_method("enable_metralhadora") :
		body.enable_metralhadora()
		queue_free()