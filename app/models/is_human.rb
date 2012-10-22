class IsHuman
  attr_accessor :first, :second, :third, :primary_category, :secondary_category

  def initialize
    @first = Random.new.rand(2..10)
    @second = Random.new.rand(2..10)
    @third = Random.new.rand(2..10)

    keys = categories.keys
    @primary_category = select_category(keys)
    @secondary_category = select_category(keys)
    @primary_items = categories[@primary_category].sort_by{rand}[0..1]
    @secondary_item = categories[@secondary_category].sample
  end

  def question
    "If I had #{@first} #{@primary_items[0]}, #{@second} #{@primary_items[1]} and #{@third} #{@secondary_item}. How many #{@primary_category} do I have?"
  end

  def answer
    @first + @second
  end

  private
    def categories
      {
        :flowers => %w{roses tulips daffodils lilies daisies},
        :fruits  => %w{apples bananas pears oranges mangoes},
        :animals => %w{cats dogs mice cows horses},
        :clothes => %w{shirts hats jackets socks gloves}
      }
    end

    def select_category(keys)
      i = rand(keys.count)
      keys.delete_at(i)
    end
end