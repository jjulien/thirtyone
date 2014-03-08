class Person < ActiveRecord::Base

  def fullname
    firstname if not lastname else "#{firstname} #{lastname}"
  end

end
