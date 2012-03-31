class App
  module Views
    class Home < Layout
    	def username
        @current_user.username
      end
    end
  end
end
