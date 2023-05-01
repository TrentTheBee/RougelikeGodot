extends Node2D

@export var speed = 200
@export var lifetime = 3.0

var direction = Vector2.ZERO

@onready var hitbox = $Hitbox
@onready var timer = $Timer
@onready var arcane_effect_7 = $ArcaneEffect7
@onready var impact_detector = $ImpactDetector

func _ready():
	set_as_top_level(true)
	
