# frozen_string_literal: true

require "spec_helper"

RSpec.describe TinyVerbs::Action do
  let(:action) { described_class }

  describe ".build" do
    context "raises abstract class error" do
      subject { -> { action.build } }

      it { is_expected.to raise_error(TinyVerbs::Errors::AbstractClassError) }
    end

    context "returns action instance" do
      subject { action.build }

      let(:action) do
        class TestActionX < described_class
          def call
            "🍕"
          end
        end

        TestActionX
      end

      it { is_expected.to respond_to(:call) }
      it { is_expected.to be_an_instance_of(action) }
      it { expect(subject.call).to eq("🍕") }
    end

    context "assigns dependencies" do
      subject { action.build }

      let(:action) do
        class TestActionY < described_class
          def self.build(**deps)
            deps[:pizza] ||= "delicious"
            new(**deps)
          end
        end

        TestActionY
      end

      it { expect(subject.instance_variable_get(:@pizza)).to eq('delicious') }

      context "assigns external dependencies" do
        subject { action.build(pizza: "luxurious") }

        it { expect(subject.instance_variable_get(:@pizza)).to eq('luxurious') }
      end
    end
  end

  describe ".new" do
    context "raises abstract class error" do
      subject { -> { action.new } }

      it { is_expected.to raise_error(NoMethodError) }
    end
  end

  describe "action" do
    subject { -> { action.build.call } }

    context "raises when missing #call" do
      let(:action) do
        class TestActionA < described_class; end

        TestActionA
      end

      it { is_expected.to raise_error(TinyVerbs::Errors::MissingCallMethodError) }
    end

    context "raises when defining .call" do
      let(:action) do
        class TestActionB < described_class
          def self.call
            "🍕"
          end
        end

        TestActionB
      end

      it { is_expected.to raise_error(TinyVerbs::Errors::ProtectedCallClassMethodError) }
    end

    context "raises when calling .new" do
      subject { -> { action.new } }

      let(:action) do
        class TestActionC < described_class; end

        TestActionC
      end

      it { is_expected.to raise_error(NoMethodError) }
    end
  end
end
