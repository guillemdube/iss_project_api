class CurrentUserController < ApplicationController
  # before_action :authenticate_user!
  def index
    render json: UserSerializer.new(current_user).serializable_hash[:data][:attributes], status: :ok
  end

  def retrieve_image
    if current_user.image_url != nil
      render json: {image: current_user.image_url}, status: :ok
    else
      render json: {message: "No image found"}, status: :not_found
    end
  end

  def delete_image
    if current_user.update(image_url: nil)
      render json: {message: "Image successfuly deleted"}, status: :ok
    else
      render json: {message: "No user found"}, status: :not_found
    end
  end

  def create_image
    image = Cloudinary::Uploader.upload(params[:image])
    if current_user.update(image_url: image["url"])
      render json: {image_url: image["url"], message: "Image successfuly uploaded"}, status: :ok
    else
      render json: {message: "No user found"}, status: :not_found
    end
  end

  def update_user  
    if current_user.update(user_params)
      render json: { user: current_user, message: "User successfully updated" }, status: :ok
    else
      render json: { errors: current_user.errors.full_messages, message: "Failed to update user" }, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :id, :image_url)
  end

end
