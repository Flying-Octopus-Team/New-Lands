extends Area2D

signal get_damage(damage)
signal deal_damage(damage)



func _on_HitboxArea_area_entered(area):
	if(area.get_name() == "Weapon"):
		var total_damage = area.damage + area.get_parent().damage_modifier
		emit_signal("deal_damage", total_damage)
		
	elif(area.get_name() == "EnemyAttackHitbox"):
		var total_damage = area.get_parent().damage
		emit_signal("get_damage", total_damage)
