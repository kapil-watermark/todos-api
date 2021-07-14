class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: [:show, :update, :destroy]

  # GET /todo_items
  # GET /todo_items?search_by_tag=car
  api :GET, '/todo_items',  "List of Todo items"
  api :GET, '/todo_items?search_by_tag=car',  "Search all Todo items by tag"
  def index
    @todo_items = if params[:search_by_tag]
                    TodoItem.where("tags.content" => /#{params[:search_by_tag]}/i)
                  else
                    TodoItem.all
                  end
    render :index
  end

   # POST /todo_items
   api :POST, "/todo_items", "Create a Todo item"
   param :todo_item, Hash, :desc => "Todo items info" do
    param :title, String, :desc => "Todo item's Title", :required => true
    param :status, String, :desc => "Todo item's Status, and status value can be start, finish or not start", :required => true
    param :tags_attributes, Array, :desc => "Todo item's tag" do
      param :content, String, :desc => "content of the tag"
    end
  end
  def create
    @todo_item = TodoItem.new(todo_params)

    if @todo_item.save
      render :show
    else
      render json: { errors: @todo_item.errors }, status: 422
    end
  end

  # GET /todo_items/:id
  api :GET, '/todo_items/:id',  "Show Todo item"
  param :id, String, desc: 'id of the requested todo_item', :required => true
  def show
  end

  # PUT /todo_items/:id
  api :PUT, '/todo_items/:id',  "Update a Todo item"
  param :id, String, desc: 'id of the requested todo_item', :required => true
  def update
    @todo_item.update(update_params)
    render :show, status: 204
  end

  # DELETE /todo_items/:id
  api :DELETE, '/todo_items/:id',  "Delete a Todo item"
  param :id, String, desc: 'id of the requested todo_item', :required => true
  def destroy
    if @todo_item
      @todo_item.destroy
      render json: { message: "Todo item successfully deleted." }, status: 204
    else
      render json: { errors: "Not found todo item" }
    end
  end

  # PUT /todo_items/:id/undo_deleted_item
  api :PUT, '/todo_items/:id/undo_deleted_item',  "Undo deleted Todo item"
  param :id, String, desc: 'id of the requested todo_item', :required => true
  def undo_deleted_item
    @todo_item = TodoItem.unscoped.find(params[:id])
    if @todo_item
      @todo_item.update(deleted_at: nil)
      render json: { message: "Successfully undo deleted todo item." }, status: 200
    else
      render json: { errors: "Not found todo item" }
    end
  end

  private

  def todo_params
    # whitelist params
    params.require(:todo_item).permit(:title, :status, tags_attributes: [:content])
  end

  def update_params
    params.require(:todo_item).permit(:title, :status)
  end

  private

  def set_todo_item
    @todo_item = TodoItem.find(params[:id])
  end
end
