extends Control

func _ready():
	var _connect = get_tree().connect("network_peer_connected", self, "_player_connected")

func _on_Play_pressed():
	var _scene = get_tree().change_scene("res://Game.tscn")

func _on_Quit_pressed():
	get_tree().quit()
