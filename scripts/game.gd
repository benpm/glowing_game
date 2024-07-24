extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	RenderingServer.viewport_set_clear_mode(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_CLEAR_NEVER)

