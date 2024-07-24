extends CharacterBody2D
class_name Player


const SPEED = 300.0
const JUMP_VELOCITY = -100.0
var jumpAmount = 5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if is_on_floor():
		jumpAmount = 5.0
	if Input.is_action_just_pressed("jump") and jumpAmount > 0.1:
		velocity.y = JUMP_VELOCITY * jumpAmount
		jumpAmount /= 2.0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
