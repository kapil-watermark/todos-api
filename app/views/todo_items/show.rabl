object @todo_item
attributes :id, :title, :status
child(:tags) { attributes :content }