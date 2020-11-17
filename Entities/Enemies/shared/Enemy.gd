extends KinematicBody2D

export var movement_speed = 150
export var health = 100
export var damage = 20
export var drop_chance = 30

onready var  animationTree = $AnimationTree
onready var animationState = animationTree.get('parameters/playback')
onready var map = get_parent().get_parent()
var seen_player = false
var target_cords = Vector2(0, 0)
var player_reference = null
var is_attacking = false
var path = []

var modulate_timer = Timer.new()	# timer to end modulate at enemy took damage

func _ready():
	$HitboxArea.connect("deal_damage", self, "take_damage")
	modulate_timer.connect("timeout",self, 'modulate_end')
	add_child(modulate_timer)

func _process(delta):
	if(animationState.get_current_node() != "Attack"):
		is_attacking = false
		
	if(seen_player == true and player_reference.alive == false):
		seen_player = false
	if(seen_player and !is_attacking and path.size() > 0):
		rotate_to_player()
		chase_player(delta)
	else:
		stand_still()
		

func attack():
	var vector = player_reference.global_position - self.global_position
	animationTree.set('parameters/Attack/blend_position', vector)
	animationState.travel("Attack")
	
	get_node("EnemyAttackHitbox/AnimationTree").set('parameters/Attack/blend_position', vector)
	get_node("EnemyAttackHitbox/AnimationTree").get('parameters/playback').travel("Attack")
	
func rotate_to_player():
	var vector = player_reference.global_position - self.global_position
	animationTree.set('parameters/Standing/blend_position', vector)
	animationTree.set('parameters/Moving/blend_position', vector)
	animationState.travel("Moving")

func stand_still():
	animationState.travel("Standing")

func _on_AggroArea_body_entered(body):
	if(body.get_name() == "Player"):
		target_cords = body.global_position
		seen_player = true
		player_reference = body
		path = get_path_to_target(body)
		

func chase_player(delta):
	var target = path[0]
	var collision = null
	
	var distance_to_walk = movement_speed * delta
	while distance_to_walk > 0 and path.size() > 0:
		var distance_to_next_point = global_position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			move_and_slide(global_position.direction_to(path[0]).normalized() * movement_speed )
		else:
			global_position = path[0]
			path = get_path_to_target(player_reference)
			path.remove(0)
			
		distance_to_walk -= distance_to_next_point
	
	for slide_count in get_slide_count():
		collision = get_slide_collision(slide_count)
		if collision.collider.name == "Player":
			is_attacking = true
			attack()
		else:
			path = get_path_to_target(player_reference)
	
func take_damage(dmg):
	health -= dmg
	if health <= 0:
		die()
	# modulate enemy color to give player feedback at enemy took damage
	modulate = Color(1, 0, 0, 1)
	modulate_timer.start(0.1)
		
func modulate_end():
	modulate_timer.stop()
	modulate = Color(1, 1, 1, 1)
		
func die():
	randomize()
	if randi() % 100 < drop_chance:
		drop_item()
	self.queue_free()
	
func get_path_to_target(target):
	var path = map.get_simple_path(global_position, target.global_position, false)
	return path

func drop_item():
	var rarity_tier = EquipmentManager.items[get_weighted_random_rarity()]
	var item = rarity_tier[randi() % rarity_tier.size()].instance()
	item.get_node("Sprite").texture = item.texture
	item.global_position = global_position
	get_parent().get_parent().add_child(item)

func get_weighted_random_rarity():
	var random_number =  randi() % 32
	if random_number < 18:
		return EquipmentManager.RARITIES.COMMON
	elif random_number < 26:
		return EquipmentManager.RARITIES.UNCOMMON
	elif random_number < 29:
		return EquipmentManager.RARITIES.RARE
	elif random_number < 31:
		return EquipmentManager.RARITIES.EPIC
	else:
		return EquipmentManager.RARITIES.LEGENDARY
