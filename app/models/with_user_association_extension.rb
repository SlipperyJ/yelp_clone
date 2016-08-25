module WithUserAssociationExtension
  def create_with_user(attributes = {}, user)
   attributes[:user] ||= user
   create(attributes)
  end

  def create_with_user!(attributes = {}, user)
    attributes[:user] ||= user
    create!(attributes)
  end

  def build_with_user(attributes = {}, user)
    attributes[:user] ||= user
    build(attributes)
  end

  def build_review(attributes={}, user)
    review =  review.build(attributes)
    review.user = user
    review
  end
end
