extends CharacterBody3D


@export var 速度 = 5.0
@export var 跳跃速度 = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = 跳跃速度

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("移动_左", "移动_右", "移动_前", "移动_后")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * 速度
		velocity.z = direction.z * 速度
	else:
		velocity.x = move_toward(velocity.x, 0, 速度)
		velocity.z = move_toward(velocity.z, 0, 速度) 

	move_and_slide()
