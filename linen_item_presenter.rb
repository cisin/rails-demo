class LinenItemPresenter
  attr_reader :linen_item

  def initialize(linen_item)
    @linen_item = linen_item
  end

  def as_json( include_root = false )
    resultset = @linen_item.map do |linen_item|
      {
        :id               => linen_item.id,
        :label            => linen_item.description,
        :description      => linen_item.description,
        :clothing_type    => linen_item.clothing_type_humanize,
        :linen_type       => linen_item.linen_type_humanize,
        :color            => linen_item.color_humanize,
        :fibre_type       => linen_item.fibre_type_humanize,
        :informal         => with_informal_label(linen_item)
      }
    end
    resultset + [{:label => 'NAO ENCONTRADO'}]
  end

private

  def with_informal_label(linen_item)
    [
      "Clothing Type: #{linen_item.clothing_type_humanize}",
      "Color: #{linen_item.color_humanize}",
      "Fibre type: #{linen_item.fibre_type_humanize}"
    ]
  end
end
