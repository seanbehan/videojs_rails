module VideojsRails
  module Tags
    class Tag
      include ActionView::Helpers::TagHelper
      include ActionView::Context
      include ActionView::Helpers::TextHelper
    end
  end
end
