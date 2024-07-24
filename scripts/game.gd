extends Node

@onready var player : Player = $/root/scene/player
@onready var fx_material : CanvasItem = $fx_layer/display_fade_blur
@onready var camera : Camera2D = $/root/scene/camera

var last_viewport_pos: Vector2 = Vector2.ZERO

func _ready():
	assert(player, "Player node not found.")
	assert(fx_material, "Shader material not found.")
	assert(camera, "Camera node not found.")

	# Disable the viewport clear mode to allow nice effect
	RenderingServer.viewport_set_clear_mode(
		get_viewport().get_viewport_rid(),
		RenderingServer.VIEWPORT_CLEAR_ONLY_NEXT_FRAME
	)

func _process(_delta):
	var cam_pos = camera.get_screen_center_position()
	var delta_viewport_pos = last_viewport_pos - cam_pos
	last_viewport_pos = cam_pos
	fx_material.material.set_shader_parameter("camera_pos", cam_pos)
	fx_material.material.set_shader_parameter("camera_delta", delta_viewport_pos)