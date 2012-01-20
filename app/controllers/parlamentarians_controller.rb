class ParlamentariansController < ApplicationController
  require 'will_paginate/array'
  RESULTS_PER_PAGE = 20

  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 6
  end

  # GET /parlamentarians
  # GET /parlamentarians.json
  def index
    page = params[:page]
    page = 1 if page.nil? || page == 0
    offset = (Integer(page) - 1) * RESULTS_PER_PAGE
    offset = offset + 1 if Integer(page) > 1
    @parlamentarians = Parlamentarian.find_all(true, RESULTS_PER_PAGE, offset)
    @paginated_parlamentarians = @parlamentarians.paginate(:page => page, :per_page => RESULTS_PER_PAGE, :total_entries => Parlamentarian.count)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parlamentarians }
    end
  end

  # GET /parlamentarians/1
  # GET /parlamentarians/1.json
  def show
    @parlamentarian = Parlamentarian.find_by_id(params[:rdf_uri])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parlamentarian }
    end
  end
end
