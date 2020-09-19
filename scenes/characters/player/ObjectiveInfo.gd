extends Label

signal game_completed

onready var red_orb := get_tree().get_root().find_node("RedOrb", true, false) as Orb
onready var green_orb := get_tree().get_root().find_node("GreenOrb", true, false) as Orb
onready var blue_orb := get_tree().get_root().find_node("BlueOrb", true, false) as Orb
onready var yellow_orb := get_tree().get_root().find_node("YellowOrb", true, false) as Orb


var orbs_collected = {
	"red": false,
	"yellow": false,
	"green": false,
	"blue": false
}
var all_orbs_collected := false

func orb_collection_update(orb_color):
	match orb_color:
		Orb.OrbColor.RED:
			orbs_collected.red = true
		Orb.OrbColor.GREEN:
			orbs_collected.green = true
		Orb.OrbColor.BLUE:
			orbs_collected.blue = true
		Orb.OrbColor.YELLOW:
			orbs_collected.yellow = true
	check_all_orbs_collected()
	update_text()

func check_all_orbs_collected():
	var temp = true
	for orb in orbs_collected:
		if not orbs_collected[orb]:
			temp = false
	all_orbs_collected = temp

func _ready():
	if red_orb:
		red_orb.connect("orb_collected", self, "orb_collection_update")
	if green_orb:
		green_orb.connect("orb_collected", self, "orb_collection_update")
	if blue_orb:
		blue_orb.connect("orb_collected", self, "orb_collection_update")
	if yellow_orb:
		yellow_orb.connect("orb_collected", self, "orb_collection_update")
	
	update_text()


func update_text():
	var final_text = "Objectives:\n"
	if not all_orbs_collected:
		final_text += "Collect Red Orb {0}/1\n".format(["1" if orbs_collected.red else "0"])
		final_text += "Collect Blue Orb {0}/1\n".format(["1" if orbs_collected.blue else "0"])
		final_text += "Collect Green Orb {0}/1\n".format(["1" if orbs_collected.green else "0"])
		final_text += "Collect Yellow Orb {0}/1\n".format(["1" if orbs_collected.yellow else "0"])
	else:
		emit_signal("game_completed")
	text = final_text
