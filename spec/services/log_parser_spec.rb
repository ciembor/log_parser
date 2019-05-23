require_relative '../../services/log_parser'

describe LogParser do
  let(:log_filename) { 'spec/fixtures/webserver.test.log' }

  subject { LogParser.new(log_filename) }

  describe '#add_record' do
    let(:record) { ['/index', '123.123.123.123'] }

    it 'adds record with address' do
      log_record_instance = double
      expect(LogRecord).to receive(:new).with(*record).and_return(log_record_instance).once
      expect(subject.log_records).to receive(:<<).with(log_record_instance).once
      subject.add_record(record)
    end
  end

  describe '#perform' do
    it 'loads log file and prints output' do
      expect(subject).to receive(:read_log_from_file).with(log_filename).once
      expect(subject).to receive(:print).once
      subject.perform
    end
  end

  describe '#read_log_from_file' do
    let(:log_content) do
      <<~LOG
        /index 316.433.849.805
        /about/2 444.701.448.104
        /contact 543.910.244.929
        /about/2 126.318.035.038
        /about/2 836.973.694.403
        /index 802.683.925.780
      LOG
    end

    let(:log_lines) { log_content.lines }

    it 'reads log content from file to the instance variable' do
      allow(File).to receive(:open).with(log_filename, 'r').and_return(log_content)
      log_lines.each do |line|
        record = line.split
        expect(subject).to receive(:add_record).with(record).once
      end
      subject.read_log_from_file(log_filename)
    end
  end

  describe '#print' do
    let(:presenter) { double('presenter') }

    it 'prints addresses sorted by number of unique visits to standard output' do
      unique_visits_message = double('unique_visits_message')
      allow(presenter)
        .to receive(:ordered_addresses_with_number_of_unique_visits)
        .and_return(unique_visits_message)
      expect(LogRecordsPresenter)
        .to receive(:new)
        .with(subject.log_records)
        .and_return(presenter).once
      expect(STDOUT).to receive(:puts).with(unique_visits_message).once
      subject.print
    end
  end
end
