class CurrentUserController < ApplicationController
  before_action :authenticate_user!
  def index
    render json: UserSerializer.new(current_user).serializable_hash[:data][:attributes], status: :ok
  end

  def retrieveImage
    if current_user.image_url != nil
      render json: {image: current_user.image_url}, status: :ok
    else
      render json: {message: "No image found"}, status: :not_found
    end
  end

  def deleteImage
    if current_user.update(image_url: nil)
      render json: {message: "Image successfuly deleted"}, status: :ok
    else
      render json: {message: "No user found"}, status: :not_found
    end
  end

  def create
    image = Cloudinary::Uploader.upload(params[:image])
    if current_user.update(image_url: image["url"])
      render json: {image_url: image["url"], message: "Image successfuly uploaded"}, status: :ok
    else
      render json: {message: "No user found"}, status: :not_found
    end
  end

end
