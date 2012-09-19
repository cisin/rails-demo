# encoding: utf-8
class LinenItem < Salus::Model
  include EnumerateIt

  has_enumeration_for :color, :with => LinenItem::Color, :create_helpers => true

  has_one :linen_stock
  has_one :temp_linen_stock
  has_one :discard_linen
  has_many :inventory_linen_items , :class_name => 'Inventory::LinenItem'
  has_many :inventory_linens , :through => :inventory_linen_items
  has_one :linen_kit
  has_one :dispatch_linen_item

  validates :description, :clothing_type, :linen_type, :color, :fibre_type, :presence => true
  validates_numericality_of :weight,  :greater_than => 0
  validates :description, :length => { :maximum => 100 }

  scope :search, lambda { |description| where({:description.matches => "#{description}%"} | { :id.eq => "#{description}%"})}
  scope :ordered, order(:description)
end
