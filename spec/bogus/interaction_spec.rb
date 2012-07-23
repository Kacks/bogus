require 'spec_helper'

describe Bogus::Interaction do
  same = [
    [[:foo, [:bar], "value"], [:foo, [:bar], "value"]],
    [[:foo, [:bar]], [:foo, [:bar], "value"]],
    [[:foo, [:bar], "value"], [:foo, [:bar]]],
    [[:foo, [:bar]], [:foo, [:bar]]]
  ]

  different = [
    [[:foo, [:bar], "value"], [:foo, [:bar], "value2"]],
    [[:foo, [:bar], "value"], [:baz, [:bar], "value"]],
    [[:foo, [:baz], "value"], [:foo, [:bar], "value"]],
    [[:foo, [:bar]], [:foo, [:baz]]],
    [[:baz, [:bar]], [:foo, [:bar]]]
  ]

  def create_interaction(interaction)
    method_name, args, return_value = interaction
    if return_value
      Bogus::Interaction.new(method_name, args) { return_value }
    else
      Bogus::Interaction.new(method_name, args)
    end
  end

  same.each do |first_interaction, second_interaction|
    it "returns true for #{first_interaction.inspect} and #{second_interaction.inspect}" do
      first = create_interaction(first_interaction)
      second = create_interaction(second_interaction)

      first.should == second
    end
  end

  different.each do |first_interaction, second_interaction|
    it "returns false for #{first_interaction.inspect} and #{second_interaction.inspect}" do
      first = create_interaction(first_interaction)
      second = create_interaction(second_interaction)

      first.should_not == second
    end
  end
end