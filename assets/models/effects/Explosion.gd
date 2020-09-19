extends Area

signal explode

export var damage := 40

func explode() -> void:
	$Particles.emitting = true
	$Particles2.emitting = true
	var query = PhysicsShapeQueryParameters.new()
	query.set_transform(global_transform)
	query.set_shape($CollisionShape.shape)
	query.collision_mask = collision_mask
	var space_state = get_world().get_direct_space_state()
	var results = space_state.intersect_shape(query)
	emit_signal("explode")
	for body in results:
		if body.collider.has_method("hurt"):
			# the direction of hurt is the vector from center of the explosion to center of the colliding body
			body.collider.hurt(damage, global_transform.origin.direction_to(body.collider.global_transform.origin))
