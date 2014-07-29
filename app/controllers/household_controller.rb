class HouseholdController < ApplicationController

  def index
    @households = Household.all
    if params[:ajax]
      render partial: 'search'
    end
  end

  def search
    wild_card_query_fields = %w(people.firstname people.lastname)
    sql_params = []
    sql_where = ''

    rowlimit = params[:rowlimit] || 10
    search_keys = JSON.parse(params[:search]).to_a

    wild_card_query_fields.each do |field|
      search_keys.each do |key|
        sql_where += ' OR ' if sql_where != ''
        sql_where += "#{field} LIKE ?"
        sql_params.push("#{key}%")
      end
    end

    @households = Household.joins(:person).where(sql_where, *sql_params).order('people.lastname').first(rowlimit.to_i)

    #@people = Person.where("firstname LIKE ? #{sql_conditional} lastname LIKE ?", firstname_key, lastname_key).first(rowlimit.to_i)
    @new_household = Household.new
    respond_to do |format|
      format.html {
        if params[:ajax]
          render :partial => 'search_results'
        else
          render action: 'index'
        end
      }
      format.json { render action: 'index.json' }
    end
  end
end
