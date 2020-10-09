extends KinematicBody2D

export var health = 100
export var movement_speed = 300

onready var  animationTree = $AnimationTree
onready var animationState = animationTree.get('parameters/playback')

func listen_inputs(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * movement_speed
	
	if Input.is_action_just_pressed("Attack"):
		velocity = Vector2(0, 0)
		attack()
	elif(animationState.get_current_node() != "Attack"):
		move_and_collide(velocity * delta)
		rotate_to_mouse(velocity)


func attack():
	var mouse_pos = get_global_mouse_position()
	var mouse_vector = mouse_pos - self.global_position
	animationTree.set('parameters/Attack/blend_position', mouse_vector)
	animationState.travel("Attack")
	
func rotate_to_mouse(velocity):
	var mouse_pos = get_global_mouse_position()
	var mouse_vector = mouse_pos - self.global_position
	
	if(velocity != Vector2(0, 0)):
		animationTree.set('parameters/Standing/blend_position', mouse_vector)
		animationTree.set('parameters/Moving/blend_position', mouse_vector)
		animationState.travel("Moving")
	else:
		animationTree.set('parameters/Standing/blend_position', mouse_vector)
		animationTree.set('parameters/Moving/blend_position', mouse_vector)
		animationState.travel("Standing")

func _process(delta):
	listen_inputs(delta)
	
