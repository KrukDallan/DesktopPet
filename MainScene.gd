extends Node2D

var trot = false
var movement = 100
var was_flipped = false
var rng = RandomNumberGenerator.new()

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
	var should_move = false
	var additional_movement = 0
	if rng.randi_range(0,1) == 1:
		should_move = true
	if $Timer.time_left < 0.1:
		if !trot:
			if should_move:
				$AnimatedSprite2D.play('trot')
				trot = true
				additional_movement = rng.randi_range(100,300)
				if was_flipped:
					$AnimatedSprite2D.set_flip_h(trot)
				
				$Timer.start(rng.randi_range(5,8))
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
			$Timer.start(rng.randi_range(5,15))
	if trot:
			$AnimatedSprite2D.position.x += int(delta*(movement+additional_movement))
