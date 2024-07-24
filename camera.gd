extends Camera2D

var t: float = 0.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	position.x = cos(t) * 100
	position.y = sin(t) * 100
	zoom = Vector2.ONE * (1.0 + sin(t) * 0.5)
