require_relative '../../presenters/log_records_presenter'

describe LogRecordsPresenter do
  let(:log_records) { double('log_records') }
  let(:addresses_with_number_of_visits) do
    [
      ['/index/2', 4],
      ['/about', 2]
    ]
  end
  subject { LogRecordsPresenter.new(log_records) }

  describe '#ordered_addresses_with_number_of_unique_visits' do
    let(:expected_result) do
      <<~RESULT
        List of webpages with number of unique views ordered by number of unique views:

        /index/2 4 unique views
        /about 2 unique views

      RESULT
    end

    it 'returns formatted message with addresses and numbers of unique visits' do
      allow(log_records)
        .to receive_message_chain(:uniq, :addresses_sorted_by_number_of_visits)
        .and_return(addresses_with_number_of_visits)

      expect(subject.ordered_addresses_with_number_of_unique_visits).to eq expected_result
    end
  end

  describe '#ordered_addresses_with_number_of_all_visits' do
    let(:expected_result) do
      <<~RESULT
        List of webpages with number of all views ordered by number of these views:

        /index/2 4 visits
        /about 2 visits

      RESULT
    end

    it 'returns formatted message with addresses and numbers of all visits' do
      allow(log_records)
        .to receive(:addresses_sorted_by_number_of_visits)
        .and_return(addresses_with_number_of_visits)

      expect(subject.ordered_addresses_with_number_of_all_visits).to eq expected_result
    end
  end
end
