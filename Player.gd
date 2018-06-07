extends KinematicBody2D

var vel = 0
var ace = 512
var ter = 256

var canJump = false
var jumpTimer = 0.5

func _ready():
	pass

func _physics_process(delta):
	var motion = Vector2()
	if Input.is_action_pressed("ui_left"):
		motion.x -= 128
	if Input.is_action_pressed("ui_right"):
		motion.x += 128
	move_and_slide(motion, Vector2(0,-1))
	move_and_slide(Vector2(0,vel), Vector2(0,-1))

func _process(delta):
	vel += ace * delta
	if vel > ter:
		vel = ter
	if is_on_floor():
		canJump = true
		jumpTimer = 0.5
		vel = 0
	else:
		jumpTimer -= delta
		if jumpTimer <= 0:
			canJump = false
	
	if Input.is_action_pressed("ui_up") && canJump:
		vel = -64-4
	
	
	pass
