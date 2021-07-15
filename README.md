# todos-api

## Stack

- Ruby On Rails
- Database - MongoDB

## Getting Started

To get a local copy up and running follow these simple steps.

### Install

- Follow this steps according to get you running
1. clone the repo

```sh
git clone https://github.com/kapil-watermark/todos-api.git
```
2. change directory 
```sh
cd todos-api
```
3. install dependencies

```sh
bundle install
```
4. start the project

```sh
rails s
```

## Usage

  There are several endpoint in this API and we'll be discussing the functionalities of each endpoint
  - GET - for List of Todo items
  ```sh
  /todo_items
  ```
  - GET - for Search all Todo items by tag
  ```sh
  /todo_items?search_by_tag=car
  ```
  - POST - for Create a Todo item
  ```sh
  /todo_items
  ```
  - GET - for Show Todo item
  ```sh
  /todo_items/:id
  ```
  - PUT - for Update a Todo item
  ```sh
  /todo_items/:id
  ```
  - DELETE - for Delete a Todo item
  ```sh
  /todo_items/:id
  ```
  - PUT - for Undo deleted Todo item
  ```sh
  /todo_items/:id/undo_deleted_item
  ```
