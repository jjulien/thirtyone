class PeopleSearch
  attr_reader :query
  def initialize
    @query = "firstname LIKE ?"
  end

  def add_conditional(param)
    @query += param.length > 1 ? " AND " : " OR "
    @query += "lastname LIKE ? "
  end

  def finalize_query(names)
    @query = Person.includes(:user).where(query, "%#{names.first}%", "%#{names.last}%")
  end

  def add_user_restriction(arg)
    @query += " AND users.id IS NOT NULL " if arg == 'true'
  end

  def prepare_query(params)
    search = JSON.parse(params[:search])
    add_conditional(search)
    add_user_restriction(params[:users_only])
    finalize_query(search)
    query.references(:users)
  end

  def self.query(params)
    new.prepare_query(params)
  end
end
