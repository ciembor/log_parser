require_relative '../models/log_record'
require_relative '../models/log_records_collection'

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
    log_records.addresses_sorted_by_number_of_unique_visits.each do |address, number_of_visits|
      message = "#{address} #{number_of_visits} unique view"
      message += 's' if number_of_visits > 1
      puts message
    end
  end

  attr_reader :log_records

  private

  attr_reader :log_filename
  attr_writer :log_records, :log_filename
end
