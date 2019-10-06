extends Node

func _ready():
	$Fade.fade_in()
	$Fade/Timer.connect("timeout", self, "comecar")

func comecar():
	$Jeremias.can_move = true
	$Inocente.connect("morri", self, "finalizar")
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
	get_tree().change_scene("res://Levels/Level1.tscn")

func same_level():
	get_tree().change_scene("res://Levels/Level0.tscn")