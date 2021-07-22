require 'rails_helper'

RSpec.describe 'Todo items API', type: :request do
  # initialize test data 
  let!(:todo_item) { create(:todo_item) }
  let!(:todo_item_with_tags) { create(:todo_item_with_tags) }
  let(:item_id) { todo_item.id }

  # Test suite for GET /todo_items
  describe 'GET /todo_items' do
    before { get '/todo_items' }

    it 'returns todo_items' do
      expect(assigns(:todo_items)).not_to be_nil
      expect(assigns(:todo_items).size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    context 'search_by_tag' do
      let(:tag) { todo_item_with_tags.tags.first }
      before { get "/todo_items?search_by_tag=#{tag.content}" }

      it 'returns all Todo items by tag' do
        expect(assigns(:todo_items).first).to eq(todo_item_with_tags)
        expect(assigns(:todo_items).size).to eq(1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /todo_items/:id' do
    before { get "/todo_items/#{item_id}" }

    context 'when the record exists' do
      it 'returns the todo item' do
        expect(assigns(:todo_item)).to eq(todo_item)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:item_id) { 100 }

      it 'returns empty json' do
        expect(response.body).to match(/{\"tags\":{}}/)
      end
    end
  end

  # Test suite for POST /todo_items
  describe 'POST /todo_items' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn Elm', status: 'start' } }

    context 'when the request is valid' do
      before { post '/todo_items', params: {todo_item: valid_attributes} }

      it 'creates a todo item' do
        expect(assigns(:todo_item).title).to eq('Learn Elm')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: 'Learn Elm', status: 'test' } }
      before { post '/todo_items', params: {todo_item: invalid_attributes} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Status can be start, finish or not start/)
      end
    end
  end

  # Test suite for PUT /todo_items/:id
  describe 'PUT /todo_items/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/todo_items/#{item_id}", params: {todo_item: valid_attributes} }

      it 'updates the record' do
        expect(assigns(:todo_item).title).to eq('Shopping')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /todo_items/:id
  describe 'DELETE /todo_items/:id' do
    before { delete "/todo_items/#{item_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
