class Trip < ActiveRecord::Base
  has_one :source, :class_name => Location
  has_one :destination, :class_name => Location
  has_and_belongs_to_many :users
  attr_accessible :time, :source, :destination, :passengers, :host, :notes, :from, :to

  def max_passengers
    return 4
  end

  def empty_seats
    return (max_passengers - self.users.count)
  end

end
