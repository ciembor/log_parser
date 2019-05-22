require_relative '../../models/log_records_collection'

describe LogRecordsCollection do
  subject { LogRecordsCollection.new }

  describe '#all' do
    it 'is empty by default' do
      expect(subject.all).to be_empty
    end
  end

  describe '#<<' do
    it 'adds record to the collection' do
      record = double
      expect { subject << record }.to change { subject.all }.from([]).to([record])
    end
  end

  context 'with four records from which three are unique' do
    let(:records) do
      [
        double(address: '/index', client_ip: '123.123.123.123'),
        double(address: '/index', client_ip: '1.2.3.4'),
        double(address: '/index', client_ip: '123.123.123.123'),
        double(address: '/about', client_ip: '123.123.123.123')
      ]
    end

    before do
      records.each do |record|
        subject << record
      end
    end

    describe '#uniq' do
      it 'returns only unique records' do
        expect(subject.uniq).to eq [records[0], records[1], records[3]]
      end
    end

    describe '#group_by_number_of_unique_visits' do
      let(:expected_result) do
        {
          '/about' => [records[3]],
          '/index' => [records[0], records[1]]
        }
      end

      it 'returns addresses with unique client ids' do
        expect(subject.group_by_number_of_unique_visits).to eq expected_result
      end
    end

    describe '#addresses_sorted_by_number_of_unique_visits' do
      let(:expected_result) { [['/index', 2], ['/about', 1]] }

      it 'returns addresses sorted by number of unique visits' do
        expect(subject.addresses_sorted_by_number_of_unique_visits).to eq expected_result
      end
    end
  end
end
