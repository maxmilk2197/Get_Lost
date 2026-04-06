extends CharacterBody3D

@export var 走路速度: float = 5.0
@export var 奔跑速度: float = 8.0      # 按住 Shift 时的速度
@export var 跳跃速度: float = 4.5

func _physics_process(delta: float) -> void:
	# 重力
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 跳跃（使用自定义动作 "跳跃" 或保留 "ui_accept"）
	if Input.is_action_just_pressed("移动_跳") and is_on_floor():
		velocity.y = 跳跃速度

	# 获取移动输入（左/右/前/后）
	var input_dir := Input.get_vector("移动_左", "移动_右", "移动_前", "移动_后")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# 根据是否按住 Shift（奔跑键）选择速度
	var 当前速度 = 奔跑速度 if Input.is_action_pressed("移动_跑") else 走路速度
	
	if direction:
		velocity.x = direction.x * 当前速度
		velocity.z = direction.z * 当前速度
	else:
		velocity.x = move_toward(velocity.x, 0, 走路速度)
		velocity.z = move_toward(velocity.z, 0, 走路速度)

	move_and_slide()
