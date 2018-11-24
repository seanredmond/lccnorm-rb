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

  describe "#valid?" do
    it "Returns true for valid LCCNs" do
      # 8 digits
      expect(Lccnorm::valid?('79139101')).to be true

      # 1 alphabetic character + 8 digits
      expect(Lccnorm::valid?('n78890351')).to be true

      # 2 alphabetic characters + 8 digits
      expect(Lccnorm::valid?('gm71005810')).to be true

      # 2 digits + 8 digits
      expect(Lccnorm::valid?('2001000002')).to be true

      # 1 alphabetic character + 2 alphabetic characters + 8 digits
      expect(Lccnorm::valid?('agr14000102')).to be true

      # 1 alphabetic character + 2 digits + 8 digits
      expect(Lccnorm::valid?('a2002003456')).to be true
      
      # 2 alphabetic characters + 10 digits
      expect(Lccnorm::valid?('mm2002084896')).to be true
    end

    it "Returns false for invalid LCCNS" do
      # not enough characters
      expect(Lccnorm::valid?('7913910')).to be false

      # 1 character prefix, but not a letter
      expect(Lccnorm::valid?('078890351')).to be false

      # 2 character prefix, mixed letter and number
      expect(Lccnorm::valid?('a078890351')).to be false

      # 3 character prefix, doesn't start with a letter
      expect(Lccnorm::valid?('4gr14000102')).to be false

      # 3 character prefix, 2nd & 3rd characters mixed letter and number
      expect(Lccnorm::valid?('ag414000102')).to be false

      # 1 alphabetic character + 11 digits
      expect(Lccnorm::valid?('m02002084896')).to be false
    end
  end
end
