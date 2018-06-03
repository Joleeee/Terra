tool
extends Node2D

export(bool) var reset = false setget onReset


#config
var tileSize = 8
var tileCount = 2
var sheet = preload("res://tiles.png")
var scene
var shape

func _ready():
	pass

func onReset(isTriggered):
	if isTriggered:
		reset = false
#		for c in get_child_count():
#			remove_child(get_child(0))
		
		var y = 0
		var tileset = TileSet.new()
		for x in tileCount:
			var shape = RectangleShape2D.new()
			shape.extents = Vector2(tileSize/2,tileSize/2)
#			print(shape.extents)
#			tileset.tile_add_shape(x, shape, Transform2D(0, Vector2(0,0)))
			tileset.create_tile(x)
			tileset.tile_set_texture(x, sheet)
			tileset.tile_set_region(x, Rect2(x*tileSize, y*tileSize, tileSize, tileSize)) 
			tileset.tile_set_name(x, str(x))
#			tileset.tile_set_shape(x, 0, shape)
			tileset.tile_add_shape(x, shape, Transform2D(0, Vector2(tileSize/2, tileSize/2)))
#			tileset.tile_set_shape_transform(x, 0, Transform2D(0, Vector2(tileSize/2, tileSize/2)))
		
#		var dir = Directory.new()
#		print(dir.remove("res://set.tres"))
		
		ResourceSaver.save("res://set.tres", tileset)