extends Spatial
class_name Orb

signal orb_collected(orb_color)

enum OrbColor {
	RED,
	GREEN,
	BLUE,
	YELLOW,
}

export(OrbColor) var orb_color


func _on_Area_body_entered(body: Node):
	if body.is_in_group("player"):
		emit_signal("orb_collected", orb_color)
		queue_free()
