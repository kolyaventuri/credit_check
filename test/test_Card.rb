require "minitest"
require "minitest/autorun"
require "minitest/pride"

require "./lib/Card"

class CardTest < Minitest::Test

  def setup
    @valid_cards = ["5541808923795240", "4024007136512380", "6011797668867828"]
    @invalid_cards = ["5541801923795240", "4024007106512380", "6011797668868728"]
    @all_cards = ["5541808923795240", "4024007136512380", "6011797668867828",
                  "5541801923795240", "4024007106512380", "6011797668868728"]

    @all_doubles =[
        [10, 5, 8, 1, 16, 0, 16, 9, 4, 3, 14, 9, 10, 2, 8, 0],
        [8, 0, 4, 4, 0, 0, 14, 1, 6, 6, 10, 1, 4, 3, 16, 0],
        [12, 0, 2, 1, 14, 9, 14, 6, 12, 8, 16, 6, 14, 8, 4, 8],

        [10, 5, 8, 1, 16, 0, 2, 9, 4, 3, 14, 9, 10, 2, 8, 0],
        [8, 0, 4, 4, 0, 0, 14, 1, 0, 6, 10, 1, 4, 3, 16, 0],
        [12, 0, 2, 1, 14, 9, 14, 6, 12, 8, 16, 6, 16, 7, 4, 8]
    ]

    @all_10_sums =[
        [1, 5, 8, 1, 7, 0, 7, 9, 4, 3, 5, 9, 1, 2, 8, 0],
        [8, 0, 4, 4, 0, 0, 5, 1, 6, 6, 1, 1, 4, 3, 7, 0],
        [3, 0, 2, 1, 5, 9, 5, 6, 3, 8, 7, 6, 5, 8, 4, 8],

        [1, 5, 8, 1, 7, 0, 2, 9, 4, 3, 5, 9, 1, 2, 8, 0],
        [8, 0, 4, 4, 0, 0, 5, 1, 0, 6, 1, 1, 4, 3, 7, 0],
        [3, 0, 2, 1, 5, 9, 5, 6, 3, 8, 7, 6, 7, 7, 4, 8]
    ]

    @all_sums = [70, 50, 80, 65, 44, 81]


  end

  def test_card_object_exists
    @all_cards.each do |card_number|
      card = Card.new(card_number)
      assert_instance_of Card, card
    end

  end

  def test_card_object_contains_number
    @all_cards.each do |card_number|
      card = Card.new(card_number)
      assert_equal card_number, card.number
    end
  end

  def test_card_object_doubles_correctly
    @all_cards.each.with_index do |card_number, index|
      card = Card.new(card_number)
      assert_equal @all_doubles[index], card.double_digits
    end
  end

  def test_card_object_sums_over_10_correctly
    @all_cards.each.with_index do |card_number, index|
      card = Card.new(card_number)
      doubled = card.double_digits
      assert_equal @all_10_sums[index], card.sum_over_10(doubled)
    end
  end

  def test_card_object_sums_array_correctly
    @all_cards.each.with_index do |card_number, index|
      card = Card.new(card_number)
      doubled = card.double_digits
      summed_10 = card.sum_over_10(doubled)
      assert_equal @all_sums[index], card.sum_array(summed_10)
    end
  end

  # def test_card_object_calculates_checksum_correctly
  #   @all_cards.each.with_index do |card_number, index|
  #     card = Card.new(card_number)
  #     doubled = card.double_digits
  #     summed_10 = card.sum_over_10(doubled)
  #     summed = card.sum_array(summed_10)
  #     assert_equal @all_check_digits[index], card.get_check_digit(summed)
  #   end
  # end

  def test_valid_card_object_returns_valid
    @valid_cards.each.with_index do |card_number, index|
      card = Card.new(card_number)
      assert_equal true, card.valid?
    end
  end

  def test_card_object_returns_invalid
    @invalid_cards.each.with_index do |card_number, index|
      card = Card.new(card_number)
      assert_equal false, card.valid?
    end
  end

  def test_card_object_can_handle_valid_ae_card
    card = Card.new("342804633855673")
    assert_equal true, card.valid?
  end

  def test_card_object_can_handle_invalid_ae_card
    card = Card.new("342801633855673")
    assert_equal false, card.valid?
  end

end
