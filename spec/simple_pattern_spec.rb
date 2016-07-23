require "spec_helper"

describe SimplePattern do
  it "has a version number" do
    expect(SimplePattern::VERSION).not_to be nil
  end

  it "works at case-when" do
    words = [
      ["the",         :english],
      ["little",      :english],
      ["Schrödinger", :german],
      ["rendezvous",  :french],
    ]

    expected_values = [
       "English stopword",
       "English word",
       "German word",
       "French word",
    ]

    words.zip(expected_values) do |word, expected_value|
      value =
        case word
        when SimplePattern[Any["a", "an", "the"], :english]
          "English stopword"
        when SimplePattern[Any, :english]
          "English word"
        when SimplePattern[Any, Not[:french]]
          "German word"
        else
          "French word"
        end
      expect(value).to eq(expected_value)
    end
  end

  describe "#===" do
    it "returns true if none of the evaluated conditions are false or nil" do
      expect(SimplePattern[String] === ["foo"]).to be_truthy
      expect(SimplePattern[String, Integer] === ["foo", 10]).to be_truthy
    end

    it "returns false if at least one of the evaluated conditions is false or nil" do
      expect(SimplePattern[Integer] === ["foo"]).to be_falsey
      expect(SimplePattern[->(x) { nil }] === ["foo"]).to be_falsey
      expect(SimplePattern[Integer, Integer] === ["foo", 10]).to be_falsey
    end
  end

  describe SimplePattern::All do
    describe "#===" do
      it "returns true if none of the evaluated conditions are false or nil" do
        expect(All[String] === "foo").to be_truthy
        expect(All[String, /\w/, ->(s) { s.length == 3 }] === "foo").to be_truthy
      end

      it "returns false if at least one of the evaluated conditions is false or nil" do
        expect(All[Integer] === "foo").to be_falsey
        expect(All[String, /\w/, ->(s) { s.length == 4 }] === "foo").to be_falsey
      end
    end
  end

  describe SimplePattern::Any do
    describe ".===" do
      it "always returns true" do
        expect(Any === "foo").to be_truthy
        expect(Any === "").to be_truthy
        expect(Any === 10).to be_truthy
        expect(Any === true).to be_truthy
        expect(Any === false).to be_truthy
        expect(Any === nil).to be_truthy
      end
    end

    describe "#===" do
      it "returns true if at least one of the evaluated conditions is not false or nil" do
        expect(Any["foo"] === "foo").to be_truthy
        expect(Any["foo", "bar"] === "foo").to be_truthy
        expect(Any[String, Integer] === "foo").to be_truthy
        expect(Any[->(x) { nil }, 10] === 10).to be_truthy
      end

     it "returns false if all evaluated conditions are false or nil" do
        expect(Any["foo"] === "bar").to be_falsey
        expect(Any[Regexp, Integer] === "foo").to be_falsey
        expect(Any[->(x) { nil }, 20] === 10).to be_falsey
      end
    end
  end

  describe SimplePattern::Not do
    describe "#===" do
      context "number of arguments is 1" do
        it "returns true if the evaluated condition is false or nil" do
          expect(Not[Integer] === "foo").to be_truthy
          expect(Not[->(x) { nil }] === "foo").to be_truthy
        end

        it "returns false if the evaluated condition is not false or nil" do
          expect(Not[String] === "foo").to be_falsey
          expect(Not[/\w/] === "foo").to be_falsey
        end
      end

      context "number of arguments is 2 or more" do
        it "returns true if  all evaluated conditions are false or nil" do
          # "foo" is not Integer nor Array
          expect(Not[Integer, Array] === "foo").to be_truthy
          expect(Not[->(x) { nil }, Array] === "foo").to be_truthy
        end

        it "returns false if at least one of the evaluated conditions is not false or nil" do
          expect(Not[String, /\w/] === "foo").to be_falsey
          expect(Not[Integer, String] === "foo").to be_falsey
          expect(Not[->(x) { nil }, String] === "foo").to be_falsey
        end
      end
    end
  end
end
