extends Node2D

signal asteroid_hit()

export var asteroid_count = 10
export var spread_radius = 1000

var asteriod_scene = preload("res://scenes/asteroid/asteroid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Add child asteroids
	for _i in range(asteroid_count):
		var asteroid = asteriod_scene.instance()
		# Subscribe for events
		asteroid.connect("asteroid_hit", self, "on_asteroid_hit")
		add_child(asteroid)
		# Set random position within a circle with spread_radius
		asteroid.position = random_position_within_circle(spread_radius)

		# asteroid.velocity = Vector2(rand_range(-100, 100), rand_range(-100, 100))
		asteroid.rotation = rand_range(0, 2 * PI)
		asteroid.angular_velocity = rand_range(-1, 1)

func random_position_within_circle(spread_radius):
	while true:
		var position = Vector2(rand_range(-spread_radius, spread_radius), rand_range(-spread_radius, spread_radius))
		# if position is inside the circle with radius spread_radius, return it
		if position.length() < spread_radius:
			return position

func on_asteroid_hit():
	emit_signal("asteroid_hit")

