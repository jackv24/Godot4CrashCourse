extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	update_animation_parameters(input_direction)
	pick_new_state(input_direction)
	
	velocity = input_direction * move_speed  
	
	move_and_slide()
	
func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)
		
func pick_new_state(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		state_machine.travel("Walk", false)
	else:
		state_machine.travel("Idle", false)
