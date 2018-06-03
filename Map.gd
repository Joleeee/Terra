extends TileMap

var mapWidth = 300
var mapHeight = 1

onready var tilemap = get_parent().find_node("TileMap")
onready var vp = get_viewport()
onready var cam = get_parent().find_node("Camera2D")

enum TILE {DIRT, GRASS}

var snscript = preload("res://SoftNoise/softnoise.gd")
var softnoise

func _ready():
	print(snscript)
	randomize()
	
	softnoise = snscript.SoftNoise.new()
	
	
	for x in 30:
		var a = softnoise.openSimplex2D(x-1,0)
		var b = softnoise.openSimplex2D(x+1,0)
#		print(softnoise.linearInterpolation(a,b,0.5)*10)
	
	var _bigNoise = []
	for x in 5:
		var r = (randf() * 16)-8
		_bigNoise.append(r)
#		print(r)
	
	var bigNoise = []
	for x in mapWidth:
		var i = (x/(mapWidth/4.0))
#		print(str(i)+"i")ff
		var a = 0
		var b = 0
		a = floor(i)
		b = clamp(ceil(i), a+1, a+1)
		var aV = _bigNoise[a]
		var bV = _bigNoise[b]
#		print("a"+str(a)+"b"+str(b))
		var result = softnoise.linearInterpolation(aV,bV,1-(b-i))
		print(str(b-i))
		bigNoise.append(result)
#		print("result"+str(result))
#	print(bigNoise)
	
	var noise = []
	for x in mapWidth:
#		var tot = 0
#		for i in range(x-2,x+2):
#			tot += softnoise.openSimplex2D(i,0)
		noise.append(softnoise.openSimplex2D(x,0)*3)
	
	
	
	for x in mapWidth:
		for y in mapHeight:
			set_cell(x - mapWidth/2, bigNoise[x], TILE.DIRT)
	updateBlocks()
	pass

func updateBlock(x, y):
	var i = tilemap.get_cell(x,y)
	if i != -1:
		if tilemap.get_cell(x,y-1) != -1:
			tilemap.set_cell(x,y,TILE.DIRT)
		else:
			tilemap.set_cell(x,y,TILE.GRASS)

	pass

func updateBlocks():
	for a in tilemap.get_used_cells():
		updateBlock(a.x, a.y)
	pass

func isInAir(x, y):	
	if tilemap.get_cell(x+1,y) != -1 || tilemap.get_cell(x-1,y) != -1 || tilemap.get_cell(x,y+1) != -1 || tilemap.get_cell(x,y-1) != -1:
		return false
	else:
		return true
	pass

func _process(delta):
	var mouse = vp.get_mouse_position()
	var pos = tilemap.global_position - cam.global_position
	var tile = tilemap.world_to_map(mouse-pos-vp.get_visible_rect().size/2)
#	print(tile)
	if Input.is_mouse_button_pressed(1) && !isInAir(tile.x, tile.y):
		tilemap.set_cellv(tile, 0)
		updateBlock(tile.x, tile.y)
		updateBlock(tile.x, tile.y+1)
	if Input.is_mouse_button_pressed(2):
		tilemap.set_cellv(tile, -1)
		updateBlock(tile.x, tile.y)
		updateBlock(tile.x, tile.y+1)
#	print(get_viewport().get_visible_rect())
	pass