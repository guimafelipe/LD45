extends Node

func _ready():
	$Fade.fade_in()
	$Jeremias.enable_metralhadora()
	$Fade/Timer.connect("timeout", self, "comecar")
	$Bazookeiro/Timer.start()

func comecar():
	$Jeremias.can_move = true
	$Bazookeiro.connect("morri", self, "finalizar")
	$Jeremias.connect("morri", self, "recomecar")

func finalizar():
	$Fade/Timer.disconnect("timeout", self, "comecar")
	$Fade/Timer.connect("timeout", self, "next_level")
	$Fade.fade_out()

func recomecar():
	$Fade/Timer.disconnect("timeout", self, "comecar")
	$Fade/Timer.connect("timeout", self, "same_level")
	$Fade.fade_out()

func next_level():
	get_tree().quit()

func same_level():
	get_tree().change_scene("res://Levels/Level3.tscn")