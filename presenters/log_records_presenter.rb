class LogRecordsPresenter
  def initialize(log_records_collection)
    self.log_records = log_records_collection
  end

  def ordered_addresses_with_number_of_unique_visits
    message = "List of webpages with number of unique views ordered by number of unique views:\n\n"
    log_records.uniq
               .addresses_sorted_by_number_of_visits
               .each do |address, number_of_visits|
      message += "#{address} #{number_of_visits} unique view"
      message += 's' if number_of_visits > 1
      message += "\n"
    end
    message + "\n"
  end

  def ordered_addresses_with_number_of_all_visits
    message = "List of webpages with number of all views ordered by number of these views:\n\n"
    log_records
      .addresses_sorted_by_number_of_visits
      .each do |address, number_of_visits|
        message += "#{address} #{number_of_visits} visit"
        message += 's' if number_of_visits > 1
        message += "\n"
      end
    message + "\n"
  end

  private

  attr_accessor :log_records
end
