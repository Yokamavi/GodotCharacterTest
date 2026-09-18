extends CharacterBody2D
@export var material_personaje_rojo: ShaderMaterial
@export var animacion: AnimatedSprite2D
@export var area_2d : Area2D

var jumpCont: int = 3
var _velocidad: float = 100.0
var _velocidad_salto: float = -300.0
var gravedad: bool = true
var _muerto: bool


func _ready() -> void:
	area_2d.body_entered.connect(_on_area_2d_body_entered)


func _physics_process(delta: float) -> void:
	if _muerto:
		return
	#Toggle gravedad 0
	if Input.is_action_just_pressed("E"):
		gravedad = not gravedad
	
	#Cálculos de gravedad
	if not is_on_floor():
		if gravedad: #Si la gravedad cero no esta activada (true)
			velocity = velocity + get_gravity() * delta
		else:  #Si la gravedad cero esta activada (false)
			velocity = velocity + get_gravity() * delta * 0.1
	else:
		jumpCont = 3
		
	#Salto
	if Input.is_action_just_pressed("ui_accept") and jumpCont != 0:
		velocity.y = _velocidad_salto
		jumpCont = jumpCont - 1
	
		
	#Movimiento lateral
	if Input.is_action_pressed("ui_left"):
		velocity.x = -_velocidad
		animacion.flip_h = false
		
	elif Input.is_action_pressed("ui_right"):
		velocity.x = _velocidad
		animacion.flip_h = true
		
	else:
		velocity.x = 0
	move_and_slide()
	
	#Animaciónes
	if !is_on_floor():
		animacion.play("saltar")
	elif velocity.x != 0:
		animacion.play("correr")
	else:
		animacion.play("idle")
		
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	animacion.material = material_personaje_rojo
	_muerto = true
