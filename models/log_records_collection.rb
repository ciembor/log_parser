class LogRecordsCollection
  def initialize(collection = [])
    self.collection = collection
  end

  def all
    collection
  end

  def uniq
    LogRecordsCollection.new(
      collection.uniq { |record| [record.address, record.client_ip] }
    )
  end

  def <<(record)
    collection << record
  end

  def group_by_address
    all.group_by(&:address)
  end

  def addresses_sorted_by_number_of_visits
    group_by_address
      .map { |address, records| [address, records.count] }
      .sort_by { |_address, records_count| -records_count }
  end

  private

  attr_accessor :collection
end
