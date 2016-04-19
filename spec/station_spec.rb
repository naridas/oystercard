require 'station'

describe Station do
  subject(:station) {described_class.new(name = "Euston", zone = 1)}

  it 'knows its name' do                      
    expect(station.name).to eq("Euston")              
  end                                                   

  it 'knows its zone' do                                                     
    expect(station.zone).to eq(1)                                 
  end
end