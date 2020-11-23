require 'test_helper'
require 'generators/dockerfile/dockerfile_generator'

class DockerfileGeneratorTest < Rails::Generators::TestCase
  tests DockerfileGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
