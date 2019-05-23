require_relative '../models/log_record'
require_relative '../models/log_records_collection'
require_relative '../presenters/log_records_presenter'

class LogParser
  def initialize(log_filename)
    self.log_filename = log_filename
    self.log_records = LogRecordsCollection.new
  end

  def perform
    read_log_from_file(log_filename)
    print
  end

  def read_log_from_file(filename)
    File.open(filename, 'r').each_line do |line|
      add_record(line.split)
    end
  end

  def add_record(record)
    log_records << LogRecord.new(*record)
  end

  def print
    presenter = LogRecordsPresenter.new(log_records)
    puts presenter.ordered_addresses_with_number_of_unique_visits
  end

  attr_reader :log_records

  private

  attr_reader :log_filename
  attr_writer :log_records, :log_filename
end
