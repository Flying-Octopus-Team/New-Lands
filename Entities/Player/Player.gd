extends KinematicBody2D

signal hp_changed
signal player_died

export var health = 100
export var movement_speed = 300
export var damage_modifier = 0
export var attack_speed_modifier = 0
export var magic_bonus = 0

onready var weapon = $Weapon
onready var  animationTree = $AnimationTree
onready var animationState = animationTree.get('parameters/playback')


var alive = true

var items = EquipmentManager.worn_items

func _ready():
	$HitboxArea.connect("get_damage", self, "take_damage")
	apply_items_modifiers()

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
		move_and_slide(velocity)
		rotate_to_mouse(velocity)
	
	# TODO: Delete this block when testing is over. It's here for development only
	if Input.is_action_just_pressed("ui_home"):
		print("health: ", health)
		print("movement_speed: ", movement_speed)
		print("damage_modifier: ", damage_modifier)
		print("magic_bonus: ", magic_bonus)


func attack():
	var mouse_pos = get_global_mouse_position()
	var mouse_vector = mouse_pos - self.global_position
	animationTree.set('parameters/Attack/blend_position', mouse_vector)
	animationState.travel("Attack")
	
	get_node("Weapon/AnimationTree").set('parameters/Attack/blend_position', mouse_vector)
	get_node("Weapon/AnimationTree").get('parameters/playback').travel("Attack")
	
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


func apply_items_modifiers():
	for item in items.keys():
		item = items[item]
		if item != null:
			apply_item_modifiers(item)


func apply_item_modifiers(item):
	health += item.hp_modifier
	movement_speed += item.speed_modifier
	magic_bonus += item.magic_modifier
	damage_modifier += item.damage_modifier
	attack_speed_modifier += item.attack_speed_modifier

func _process(delta):
	listen_inputs(delta)
	
func take_damage(dmg):
	health -= dmg
	if health <= 0:
		die()
		health = 0
	emit_signal("hp_changed")
		
func die():
	alive = false
	self.set_deferred("disabled", true)
	self.visible = false
	set_process(false)
	emit_signal("player_died")
