describe 'parser' do
  let(:command) { './parser.rb spec/fixtures/webserver.test.log' }
  let(:expected_output) do
    <<~OUTPUT
      /about/2 3 unique views
      /index 2 unique views
      /contact 1 unique view
    OUTPUT
  end

  it 'runs with parameter and returns 0 status code' do
    expect(system(command)).to be true
  end

  it 'returns website names with number of visits ordered by number of visits' do
    expect(`#{command}`).to eq expected_output
  end
end
