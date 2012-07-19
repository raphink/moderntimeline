require 'pdf/reader'

describe 'Moderntimeline PDF' do
  reader = PDF::Reader.new('moderntimeline.pdf')
  it 'should have 8 pages' do
    reader.page_count.should eq(8)
  end
  it 'should be made by TeX' do
    reader.info[:Creator].should eq('TeX')
  end
  it 'should have page 1 with given media box' do
    reader.pages[0].attributes[:MediaBox].should eq([0, 0, 612, 792])
  end
  it 'should have page 2 with given fonts' do
    reader.pages[1].fonts.keys.should eq([:F31, :F32, :F8])
  end
  it 'should start with a title' do
    reader.pages[0].text.should match('Themoderntimelinepackage.*')
  end
end
