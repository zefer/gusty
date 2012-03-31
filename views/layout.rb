class App
  module Views
    class Layout < Mustache
      def title 
        @title || "Gusty"
      end
    end
  end
end
