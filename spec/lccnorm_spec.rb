RSpec.describe Lccnorm do
  it "has a version number" do
    expect(Lccnorm::VERSION).not_to be nil
  end

  describe "#normalize" do
    it "does not alter a normalized LCCN" do
      expect(Lccnorm::normalize('n78890351')).to eq('n78890351')
    end

    it "normalizes LCCNs" do
      expect(Lccnorm::normalize('n78-890351')).to eq('n78890351')
      expect(Lccnorm::normalize('n78-89035')).to eq('n78089035')
      expect(Lccnorm::normalize('n 78890351 ')).to eq('n78890351')
      expect(Lccnorm::normalize(' 85000002 ')).to eq('85000002')
      expect(Lccnorm::normalize('85-2 ')).to eq('85000002')
      expect(Lccnorm::normalize('2001-000002')).to eq('2001000002')
      expect(Lccnorm::normalize('75-425165//r75')).to eq('75425165')
      expect(Lccnorm::normalize(' 79139101 /AC/r932')).to eq('79139101')
    end

    it "detects some invalid LCCNs" do
      # Too many characters to the right of the hyphen
      expect { Lccnorm::normalize('n78-8903510') }.
        to raise_error(Lccnorm::InvalidLccnError)

      # Non-numeric character to the right of the hyphen
      expect{ Lccnorm::normalize('n78-890351a') }.
        to raise_error(Lccnorm::InvalidLccnError)
    end
  end
end
