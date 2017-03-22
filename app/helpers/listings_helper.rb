module ListingsHelper

def owner?
  if current_user.id == @listing.user_id
    true
  else
    false
  end
end

end
