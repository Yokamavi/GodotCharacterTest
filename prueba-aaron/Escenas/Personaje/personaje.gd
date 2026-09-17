extends CharacterBody2D

@export var animacion: AnimatedSprite2D
@export var area_2d : Area2D
var jumpCont: int = 3
var _velocidad: float = 100.0
var _velocidad_salto: float = -300.0
var gravedad: bool = true


func _ready() -> void:
	area_2d.body_entered.connect(_on_area_2d_body_entered)

func _physics_process(delta: float) -> void:
	
	#gravedad
	if Input.is_action_just_pressed("E"):
		gravedad = not gravedad
		
	if not is_on_floor():
		if gravedad: #Si la gravedad cero no esta activada (true)
			velocity = velocity + get_gravity() * delta
		else:  #Si la gravedad cero esta activada (false)
			velocity = velocity + get_gravity() * delta * 0.5
	else:
		jumpCont = 3
		
	#salto
	if Input.is_action_just_pressed("ui_accept") and jumpCont != 0:
		velocity.y = _velocidad_salto
		jumpCont = jumpCont - 1
	
		
	#movimiento lateral
	if Input.is_action_pressed("ui_left"):
		velocity.x = -_velocidad
		animacion.flip_h = false
		
	elif Input.is_action_pressed("ui_right"):
		velocity.x = _velocidad
		animacion.flip_h = true
		
	else:
		velocity.x = 0
	move_and_slide()
	
	#animacion
	
	if !is_on_floor():
		animacion.play("saltar")
	elif velocity.x != 0:
		animacion.play("correr")
	else:
		animacion.play("idle")
		
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	print("muerto")
