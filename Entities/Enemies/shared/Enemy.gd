extends KinematicBody2D

export var movement_speed = 150
export var health = 100
export var damage = 20

onready var  animationTree = $AnimationTree
onready var animationState = animationTree.get('parameters/playback')
var seen_player = false
var target_cords = Vector2(0, 0)
var player_reference = null
var is_attacking = false

func _ready():
	$HitboxArea.connect("deal_damage", self, "take_damage")

func _process(delta):
	if(animationState.get_current_node() != "Attack"):
		is_attacking = false
		
	if(seen_player == true and player_reference.alive == false):
		seen_player = false
		
	if(seen_player and !is_attacking):
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

func chase_player(delta):
	var chase_vector = player_reference.global_position - self.global_position
	var collision = move_and_collide(chase_vector.normalized() * movement_speed * delta)
	
	if(collision):
		is_attacking = true
		attack()
	
func take_damage(dmg):
	health -= dmg
	if health <= 0:
		die()
		
func die():
	self.queue_free()
	
