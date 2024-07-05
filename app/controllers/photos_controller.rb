class PhotosController < ApplicationController
    def index
        @photos = [
            {
                image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjzC2JyZDZ_RaWf0qp11K0lcvB6b6kYNMoqtZAQ9hiPZ4cTIOB",
                title: "vankha",
                description: "check here",
                number_like: 1,
                created_at: ""
            }
        ]
    end

    def new 
        
    end

    def edit
         
    end
    
end