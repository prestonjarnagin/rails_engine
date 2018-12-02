class Revenue
  attr_reader :revenue,
              :id

  def initialize(revenue, id = 1)
    @revenue = revenue
    @id = id
  end
end
