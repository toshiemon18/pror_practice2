class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  
  def show
    @book = Book.find(params[:id])
    respond_to do |fomat|
      fomat.html
      fomat.csv
    end
    # render :show
  end

  private 
  def set_book 
  	@book = Book.find(params[:id])
  end
end
