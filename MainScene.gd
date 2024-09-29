extends Node2D

var trot = false
var movement = 100
var was_flipped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play('default')
	var size = DisplayServer.screen_get_size()
	print (size)
	$AnimatedSprite2D.position.y += 735
	print($AnimatedSprite2D.position)

	# Set region, using array
	var packed = PackedVector2Array([Vector2(0,0), Vector2(1,0), Vector2(0,1)])
	DisplayServer.window_set_mouse_passthrough(packed)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Timer.time_left < 0.1:
		if !trot:
			$AnimatedSprite2D.play('trot')
			trot = true
			if was_flipped:
				$AnimatedSprite2D.set_flip_h(trot)
			$Timer.start(5)
		else:
			$AnimatedSprite2D.play('default')
			trot = false		
			movement *= -1
			if was_flipped:
				$AnimatedSprite2D.set_flip_h(trot)
				was_flipped = false
			else:
				$AnimatedSprite2D.set_flip_h(not trot)
				was_flipped = true
			$Timer.start(5)
	if trot:
			$AnimatedSprite2D.position.x += int(delta*movement)
