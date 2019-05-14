class AddressController < ApplicationController

def index
   @address = ["This","is","my","address"]
   render_multi_threaded
end



end