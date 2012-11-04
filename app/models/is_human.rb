require 'digest/sha1'

class IsHuman
  attr_accessor :numbers, :primary_category, :secondary_category, :items, :salt
  cattr_accessor :salt

  CATEGORIES = {
    :flowers => %w{roses tulips daffodils lilies daisies},
    :fruits  => %w{apples bananas pears oranges mangoes},
    :animals => %w{cats dogs mice cows horses},
    :clothes => %w{shirts hats jackets socks gloves}
  }

  def initialize(model)
    pick_numbers
    pick_categories_and_items    
    build_items_list

    model.class.module_eval { attr_accessor :is_human_attempt, :is_human_hash }
  end

  def question
    "If I had #{@items[0]}, #{@items[1]} and #{@items[2]}. How many #{@primary_category} do I have?"
  end

  def answer
    @numbers[0] + @numbers[1]
  end

  def hashed_answer
    IsHuman.hash_answer(answer.to_words.downcase)
  end

  def self.correct?(params)
    attempt = params.delete(:is_human_attempt)
    secret_hash = params.delete(:is_human_hash)

    attempt = convert_attempt_to_words(attempt)

    hashed_attempt = self.hash_answer(attempt)
    hashed_attempt == secret_hash
  end

  private
    def self.convert_attempt_to_words(attempt)
      return attempt.downcase if attempt.to_i == 0
      attempt.to_i.to_words
    end

    def self.hash_answer(ans)
      Digest::SHA1.hexdigest "#{ans}_#{self.salt}"
    end

    def pick_numbers
      @numbers = Array.new(3).map{ Random.new.rand(2..10) }
    end

    def pick_categories_and_items
      keys = CATEGORIES.keys
      @primary_category = select_category(keys)
      @secondary_category = select_category(keys)
      @primary_items = CATEGORIES[@primary_category].shuffle[0..1]
      @secondary_item = CATEGORIES[@secondary_category].sample
    end

    def build_items_list
      items = []
      items << "#{@numbers[0].to_words} #{@primary_items[0]}"
      items << "#{@numbers[1].to_words} #{@primary_items[1]}"
      items << "#{@numbers[2].to_words} #{@secondary_item}"
      @items = items.shuffle
    end

    def select_category(keys)
      i = rand(keys.count)
      keys.delete_at(i)
    end
end