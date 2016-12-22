require_relative 'test_helper'
require './lib/firing_rules.rb'
require 'pry'

class FiringRulesTest < Minitest::Test
  include FiringRules
  def test_knows_if_coords_exist
    coord_1 = "D4"
    coord_2 = "D3"
    coord_3 = "D2"
    coord_4 = "D1"
    coord_5 = "C4"
    coord_6 = "C3"
    coord_7 = "C2"
    coord_8 = "C1"
    coord_9 = "B4"
    coord_10 = "B3"
    coord_11 = "B2"
    coord_12 = "B1"
    coord_13 = "A4"
    coord_14 = "A3"
    coord_15 = "A2"
    coord_16 = "A1"
    assert FiringRules.coords_exist?(coord_1)
    assert FiringRules.coords_exist?(coord_2)
    assert FiringRules.coords_exist?(coord_3)
    assert FiringRules.coords_exist?(coord_4)
    assert FiringRules.coords_exist?(coord_5)
    assert FiringRules.coords_exist?(coord_6)
    assert FiringRules.coords_exist?(coord_7)
    assert FiringRules.coords_exist?(coord_8)
    assert FiringRules.coords_exist?(coord_9)
    assert FiringRules.coords_exist?(coord_10)
    assert FiringRules.coords_exist?(coord_11)
    assert FiringRules.coords_exist?(coord_12)
    assert FiringRules.coords_exist?(coord_13)
    assert FiringRules.coords_exist?(coord_14)
    assert FiringRules.coords_exist?(coord_15)
    assert FiringRules.coords_exist?(coord_16)
    refute FiringRules.coords_exist?("D16")
    refute FiringRules.coords_exist?("Ajfksl")
    refute FiringRules.coords_exist?("B81")
    refute FiringRules.coords_exist?("aa")
  end
end
