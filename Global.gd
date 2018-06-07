extends Node2D

onready var vp = get_viewport()

var screenSize = Vector2(256, 144)
var zoom

func _ready():
	print(vp)
	vp.connect("size_changed", self, "resize")
	
#	resize()


func resize():
#	print("OK")
#	var a = vp.size.y / screenSize.y
#	print(vp.size.y / screenSize.y)
##	return
##	return
##	var zoom = min(vp.size.x / screenSize.x, vp.size.y / screenSize.y)
#	var zoom = vp.size.y / screenSize.y
#	print(zoom)
#	var tree = get_node("/root/World").get_tree()
#	print(tree)
#	print("A")
##	return
#	print("c")
#	print(int(zoom))
#	var z = str(int(zoom))
#	tree.set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED, SceneTree.STRETCH_ASPECT_KEEP_HEIGHT, screenSize, zoom)
	pass