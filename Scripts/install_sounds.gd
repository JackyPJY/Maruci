extends Node

@export var root_path : NodePath

# create audio player instances
@onready var sounds = {
	&"UI_Hover" : AudioStreamPlayer.new(),
	&"UI_Click" : AudioStreamPlayer.new(),
	&"UI_Slider_Drag_Start" : AudioStreamPlayer.new(),
	}

func _ready() -> void:
	assert(root_path != null, "Empty root path for Interface Sounds!")

	# set up audio stream players and load sound files
	for i in sounds.keys():
		sounds[i].stream = load("res://Assets/Sound/SFX/" + str(i) + ".wav")
		# assign output mixer bus
		sounds[i].bus = &"SFX"
		# add them to the scene tree
		add_child(sounds[i])

	# connect signals to the method that plays the sounds
	install_sounds(get_node(root_path))

#Add new ones for other nodes you want sound for
func install_sounds(node: Node) -> void:
	for i in node.get_children():
		if i is Button:
			i.mouse_entered.connect( ui_sfx_play.bind(&"UI_Hover") )
			i.pressed.connect( ui_sfx_play.bind(&"UI_Click") )
		elif i is OptionButton:
			i.mouse_entered.connect( ui_sfx_play.bind(&"UI_Hover") )
			i.pressed.connect( ui_sfx_play.bind(&"UI_Click") )
		elif i is TextureButton:
			i.mouse_entered.connect( ui_sfx_play.bind(&"UI_Hover") )
			i.pressed.connect( ui_sfx_play.bind(&"UI_Click") )
		elif i is TabContainer:
			i.tab_hovered.connect( ui_sfx_play.bind(&"UI_Hover") )
			i.tab_clicked.connect( ui_sfx_play.bind(&"UI_Hover") )
		elif i is Slider:
			i.drag_started.connect ( ui_sfx_play.bind(&"UI_Slider_Drag_Start") )
			i.drag_ended.connect ( ui_sfx_play.bind(&"UI_Click") )
			i.mouse_entered.connect( ui_sfx_play.bind(&"UI_Hover") )
		install_sounds(i)


func ui_sfx_play(sound : String) -> void:
#	print("Playing sound:", sound)
	sounds[sound].play()
