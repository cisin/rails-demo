require 'spec_helper'

describe LinenItem do
  context "associations" do
    it { should have_one :linen_stock }
    it { should have_one :temp_linen_stock }
    it { should have_one :discard_linen }
    it { should have_many :inventory_linen_items }
    it { should have_many(:inventory_linens).through(:inventory_linen_items) }
    it { should have_one :linen_kit }
    it { should have_one :dispatch_linen_item }
  end

  context "validations" do
    it { should validate_presence_of :description }
    it { should validate_presence_of :clothing_type }
    it { should validate_presence_of :linen_type }
    it { should validate_presence_of :color }
    it { should validate_presence_of :fibre_type }
    it { should validate_numericality_of :weight }
    it { should ensure_length_of(:description).is_at_most(100) }
  end
end
