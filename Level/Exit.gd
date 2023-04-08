extends Area

func _on_Exit_body_entered(body):
	var _scene = get_tree().change_scene("res://UI/Win.tscn")
