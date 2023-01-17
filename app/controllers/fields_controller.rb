# frozen_string_literal: true

class FieldsController < ApplicationController
  before_action :set_todo

  def new
    @field = Field.new({ source: @todo })
  end

  def create
    @field = Field.create({ source: @todo }.merge(field_params.to_h))

    @collections = Collections.new(@todo)
    @filter      = Memoization.new(@todo, {})

    @filter.name ||= Obfuscator.new.encrypt({ name: @todo.items.first.name }.to_json) if @todo.items.any?

    respond_to do |format|
      if @field.save
        format.html { redirect_to todo_url(@todo), notice: "Field was successfully created." }
        format.json { render :show, status: :created, location: @field }
        format.turbo_stream { flash.now[:notice] = "Field was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end

  def field_params
    params.require(:field).permit(:name)
  end
end
