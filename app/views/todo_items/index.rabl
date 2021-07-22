collection @todo_items
attributes :id, :title, :status
child(:tags) { attributes :content }
