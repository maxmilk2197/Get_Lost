extends CharacterBody3D

# 基础移动参数
@export var 走路速度: float = 5.0
@export var 奔跑速度: float = 8.0
@export var 跳跃速度: float = 4.5

# 手感调校参数
@export var 加速度: float = 12.0          # 地面加速
@export var 减速度: float = 18.0          # 地面刹车
@export var 空中转向系数: float = 0.25    # 空中灵活性（0 = 完全无法变向）

# 手电筒相关
@export var 手电筒_光: SpotLight3D
@onready var 原始手电筒位置: Vector3 = 手电筒_光.position

# 物理更新（每帧调用）
func _physics_process(delta: float) -> void:
	# ---------- 重力 ----------
	if not is_on_floor():
		velocity += get_gravity() * delta

	# ---------- 跳跃 ----------
	if Input.is_action_just_pressed("移动_跳") and is_on_floor():
		velocity.y = 跳跃速度

	# ---------- 输入处理 ----------
	var input_dir := Input.get_vector("移动_左", "移动_右", "移动_前", "移动_后")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# 当前允许的最高速度
	var current_max_speed: float = 奔跑速度 if Input.is_action_pressed("移动_跑") else 走路速度

	# 目标水平速度（显式声明类型，避免编译错误）
	var target_velocity: Vector3 = direction * current_max_speed

	# 当前水平速度
	var current_horizontal := Vector3(velocity.x, 0, velocity.z)
	var new_horizontal := current_horizontal

	# 根据是否着地决定加速度强度
	var accel: float = 加速度
	if not is_on_floor():
		accel = 加速度 * 空中转向系数

	# 平滑加速 / 减速
	if direction:
		new_horizontal = current_horizontal.move_toward(target_velocity, accel * delta)
	else:
		new_horizontal = current_horizontal.move_toward(Vector3.ZERO, 减速度 * delta)

	velocity.x = new_horizontal.x
	velocity.z = new_horizontal.z

	# 应用移动
	move_and_slide()

	# 更新手电筒晃动效果
	_更新手电筒晃动(delta)

func _更新手电筒晃动(delta: float) -> void:
	if not 手电筒_光.visible:
		手电筒_光.position = 原始手电筒位置
		return

	var speed_ratio: float = velocity.length() / 奔跑速度
	if is_on_floor() and velocity.length() > 0.5:
		var sway_amount: float = 0.04 * speed_ratio
		var time: float = Time.get_ticks_msec() / 200.0
		手电筒_光.position.x = 原始手电筒位置.x + sin(time) * sway_amount
		手电筒_光.position.y = 原始手电筒位置.y + cos(time * 1.7) * sway_amount * 0.6
	else:
		手电筒_光.position = 原始手电筒位置

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("手电筒_开关"):
		手电筒_光.visible = not 手电筒_光.visible
