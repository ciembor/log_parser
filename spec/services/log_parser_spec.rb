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
    let(:log_records) do
      [
        ['/index', '316.433.849.805'],
        ['/about/2', '444.701.448.104'],
        ['/contact', '543.910.244.929'],
        ['/about/2', '126.318.035.038'],
        ['/about/2', '836.973.694.403'],
        ['/index', '802.683.925.780']
      ]
    end
    let(:expected_stdout) do
      <<~OUTPUT
        /about/2 3 unique views
        /index 2 unique views
        /contact 1 unique view
      OUTPUT
    end

    before do
      log_records.each do |record|
        subject.add_record(record)
      end
    end

    it 'prints addresses sorted by number of unique visits to standard output' do
      expect { subject.print }.to output(expected_stdout).to_stdout
    end
  end
end
