extends Area2D

func _on_EndGate_body_entered(body):
	if(body.get_name() == "Player"):
		get_tree().change_scene("res://Hub/Hub.tscn")
