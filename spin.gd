extends Sprite2D

var t: float = 0.0;
var lastPos: Vector2 = Vector2(0, 0);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += delta
	var deltaMove = (get_global_mouse_position() - position).length()
	position = get_global_mouse_position()
	if deltaMove > 1.0:
		rotation = sqrt(deltaMove) * 0.5
	rotation = lerp_angle(rotation, 0.0, delta)
	
