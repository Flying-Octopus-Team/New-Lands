extends Area2D

signal player_enter_gate

func _on_EndGate_body_entered(body):
	if(body.get_name() == "Player"):
		emit_signal("player_enter_gate")
