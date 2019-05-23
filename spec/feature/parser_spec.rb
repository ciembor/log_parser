describe 'parser' do
  let(:command) { './parser.rb spec/fixtures/webserver.test.log' }
  let(:expected_output_of_all_visits) do
    <<~OUTPUT
      List of webpages with number of all views ordered by number of these views:

      /about/2 4 visits
      /index 2 visits
      /contact 2 visits

    OUTPUT
  end

  let(:expected_output_of_unique_visits) do
    <<~OUTPUT
      List of webpages with number of unique views ordered by number of unique views:

      /about/2 3 unique views
      /index 2 unique views
      /contact 1 unique view

    OUTPUT
  end

  let(:expected_output) { expected_output_of_all_visits + expected_output_of_unique_visits }

  it 'runs with parameter and returns 0 status code' do
    expect(system(command)).to be true
  end

  it 'returns ordered lists of website names with all and unique visits' do
    expect(`#{command}`).to eq expected_output
  end
end
