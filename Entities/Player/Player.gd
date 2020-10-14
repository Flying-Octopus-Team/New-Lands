extends KinematicBody2D

export var health = 100
export var movement_speed = 300
export var damage_modifier = 0
export var attack_speed_modifier = 0
export var magic_bonus = 0

onready var weapon = $Weapon
onready var  animationTree = $AnimationTree
onready var animationState = animationTree.get('parameters/playback')

var Item = preload("res://Items/shared/Item.tscn")

onready var items = {
	"sword": $Weapon, 
	"axe": null, 
	"spear": null, 
	"chestplate": null, 
	"helmet": null, 
	"leggings": null, 
	"boots": null, 
	"ring": null,
	"necklace": null
}


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
	
	# TODO: Delete this block when testing is over. It's here for development only
	if Input.is_action_just_pressed("ui_accept"):
		print("health: ", health)
		print("movement_speed: ", movement_speed)
		print("damage_modifier: ", damage_modifier)
		print("magic_bonus: ", magic_bonus)


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


func apply_items_modifiers(item):
	health += item.hp_modifier
	movement_speed += item.speed_modifier
	magic_bonus += item.magic_modifier
	damage_modifier += item.damage_modifier
	attack_speed_modifier += item.attack_speed_modifier


func _ready():
	for item in items.keys():
		item = items[item]
		if item != null:
			apply_items_modifiers(item)


func _process(delta):
	listen_inputs(delta)
