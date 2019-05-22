require_relative '../../models/log_record'

describe LogRecord do
  let(:address) { '/index' }
  let(:client_ip) { '123.123.123.123' }
  subject { LogRecord.new(address, client_ip) }

  describe '#address' do
    it 'returns proper address' do
      expect(subject.address).to eq address
    end
  end

  describe '#client_ip' do
    it 'returns proper client_id' do
      expect(subject.client_ip).to eq client_ip
    end
  end
end
