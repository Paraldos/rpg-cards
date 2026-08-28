@tool
extends ColorRect
class_name A4Page

const PORTRAIT_SIZE := Vector2(1240, 1754)
const LANDSCAPE_SIZE := Vector2(1754, 1240)
const OUTPUT_DIRECTORY := "res://results"
var viewport: SubViewport

@export_tool_button("Change Mode")
var change_mode_btn = change_mode

@export_tool_button("PNG exportieren", "Image")
var export_button = export_png

func _ready() -> void:
	if not Engine.is_editor_hint():
		return
	call_deferred("_initialize_page_size")

func _initialize_page_size() -> void:
	if size != PORTRAIT_SIZE and size != LANDSCAPE_SIZE:
		_set_page_size(PORTRAIT_SIZE)

func _set_page_size(new_size: Vector2) -> void:
	custom_maximum_size = new_size
	custom_minimum_size = new_size
	size = new_size

func change_mode() -> void:
	if size == PORTRAIT_SIZE:
		_set_page_size(LANDSCAPE_SIZE)
	else:
		_set_page_size(PORTRAIT_SIZE)

func export_png() -> void:
	if not Engine.is_editor_hint(): return
	_create_viewport()
	_fill_viewport()
	await _wait_for_render()
	var error := _save_image()
	_cleanup()
	_report_result(error)

func _create_viewport() -> void:
	viewport = SubViewport.new()
	viewport.size = Vector2i(size)
	viewport.transparent_bg = false
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	EditorInterface.get_base_control().add_child(viewport)

func _fill_viewport() -> void:
	var page_copy := duplicate()
	page_copy.set_script(null)
	viewport.add_child(page_copy)

func _wait_for_render() -> void:
	var scene_tree := EditorInterface.get_base_control().get_tree()
	await scene_tree.process_frame
	await scene_tree.process_frame
	await RenderingServer.frame_post_draw

func _cleanup() -> void:
	viewport.queue_free()
	viewport = null

# ==================================================== save
func _get_output_path() -> String:
	return OUTPUT_DIRECTORY.path_join(name + ".png")

func _create_output_directory() -> void:
	var absolute_path := ProjectSettings.globalize_path(OUTPUT_DIRECTORY)
	DirAccess.make_dir_recursive_absolute(absolute_path)

func _save_image() -> Error:
	_create_output_directory()
	var image := viewport.get_texture().get_image()
	return image.save_png(_get_output_path())

# ==================================================== report
func _report_result(error: Error) -> void:
	if error != OK:
		push_error("PNG-Export fehlgeschlagen: %s" % error_string(error))
		return
	var output_path := _get_output_path()
	var absolute_path := ProjectSettings.globalize_path(output_path)
	print("PNG erfolgreich erstellt: ", absolute_path)
	EditorInterface.get_resource_filesystem().scan()
