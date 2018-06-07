extends Camera2D

onready var vp = get_viewport()

var screenSize = Vector2(256, 144)

func _ready():
	vp.connect("size_changed", self, "resize")
	Global.zoom = zoom
func _process(delta):
	Global.zoom = zoom
func resize():
#	var z = ((OS.window_size.y / screenSize.y)) / 1
#	print(z)
#	zoom = Vector2(z,z)
#	Global.zoom = z
	pass