# a simple class to generate search results, you can provide a block if you have different data attributes

class RecordSearcher
  attr_reader :records

  def initialize(records, params = {}, scope = :search)
    unless records.respond_to? scope
      raise ArgumentError, "records must repond to #{scope}"
    end

    default_params = {
      query: nil,
      page: nil,
      limit: nil
    }

    params.reverse_merge!(default_params)
    @records = records.send(scope, params[:query]).page(params[:page]).per(params[:limit])
  end

  def call(&block)
    {
      total: records.total_count,
      records: records.map do |record|
        if block_given?
          block.call(record)
        else
          { name: record.name, id: record.id }
        end
      end
    }
  end

  def self.call(records, params = {}, &block)
    new(records, params).call(&block)
  end

end
