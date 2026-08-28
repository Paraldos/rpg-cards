@tool
extends CanvasLayer

const PAGE_SIZE := Vector2i(1240, 1754)
const OUTPUT_PATH := "res://page.png"
var viewport: SubViewport

@export_tool_button("PNG exportieren", "Image")
var export_button: Callable = export_png

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
	viewport.size = PAGE_SIZE
	viewport.transparent_bg = false
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	EditorInterface.get_base_control().add_child(viewport)

func _fill_viewport() -> void:
	var page_copy := duplicate()
	# Verhindert, dass die Kopie das Tool-Script ausführt.
	page_copy.set_script(null)
	viewport.add_child(page_copy)

func _wait_for_render() -> void:
	var scene_tree := EditorInterface.get_base_control().get_tree()
	await scene_tree.process_frame
	await scene_tree.process_frame
	await RenderingServer.frame_post_draw

func _save_image() -> Error:
	var image := viewport.get_texture().get_image()
	return image.save_png(OUTPUT_PATH)

func _cleanup() -> void:
	viewport.queue_free()
	viewport = null

func _report_result(error: Error) -> void:
	if error != OK:
		push_error("PNG-Export fehlgeschlagen: %s" % error_string(error))
		return
	var absolute_path := ProjectSettings.globalize_path(OUTPUT_PATH)
	print("PNG erfolgreich erstellt: ", absolute_path)
	EditorInterface.get_resource_filesystem().scan()
