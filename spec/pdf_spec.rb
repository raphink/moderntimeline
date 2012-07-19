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
    fonts = Array.new()
    reader.pages[1].fonts.keys.each do |f|
      fonts.push(reader.pages[1].fonts[f][:BaseFont])
    end
    fonts.should eq([:"MPHCCP+CMTT9", :"LTYYLY+CMTT10", :"OHGNUH+CMR10"])
  end
  it 'should start with a title' do
    reader.pages[0].text.should match('Themoderntimelinepackage.*')
  end
end
