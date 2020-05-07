class Search
  include ActiveModel::Model
  attr_accessor :text, :klass
  validates :text, presence: true

  def perform
    if valid?
      text = self.text.downcase
      REDIS.sinter(text.split.map {|i| index_key(i)}).map {|result| Search::Result.new(search_string: text, redis_set: result)}
    end
  end

  def perform_lazy
    if valid?
      text = self.text.downcase
      REDIS.sinter(text.split.map {|i| index_key(i)}).map {|result| result.split(":").last.to_i }
    end
  end

  private

    def index_key(i)
      if self.klass
        "index:#{i}:#{klass.to_s.downcase}"
      else
        "index:#{i}"
      end
    end
end
