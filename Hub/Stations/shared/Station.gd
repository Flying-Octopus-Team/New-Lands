extends KinematicBody2D

"""
Station is any object placed in hub, that player can interact with
"""

# Station lights up and starts accepting input
# TODO: Look into giving stations border by using shaders
func _on_DetectionRange_body_entered(body):
	if body.name == "Player":
		$ProximityIndicator.visible = true
		set_process(true)


# Start returns back to normal and stops accepting input
func _on_DetectionRange_body_exited(body):
	if body.name == "Player":
		$ProximityIndicator.visible = false
		set_process(false)


# Station shouldn't accept input by default
func _ready():
	set_process(false)


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		station_used()
	if Input.is_action_just_pressed("ui_cancel"):
		use_canceled()


# This method should be overridden in inheriting nodes.
# It should contain all functions of the station
func station_used():
	print("STATION NOT IMPLEMENTED")

# This method should be overridden in inheriting nodes that show UI
# It should contain code responsible for deleting this UI
func use_canceled():
	pass
