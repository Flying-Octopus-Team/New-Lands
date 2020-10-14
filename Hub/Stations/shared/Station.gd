extends KinematicBody2D


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
	if Input.is_action_just_pressed("ui_home"):
		station_used()


# This method should be overridden in inheriting nodes.
# It should contain all functions of the station
func station_used():
	print("STATION NOT IMPLEMENTED")
