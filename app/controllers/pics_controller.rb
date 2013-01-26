class PicsController < ApplicationController
  
  def users
    @userList = []
    for user in User.find(:all)
      @userList = @userList + [user]
    end
  end
  
  def search_results
    @resultPhotos = Photo.all
    if (params[:substr] != nil)
      if (!params[:substr].empty?)
        substring = params[:substr]
        @resultPhotos = []
        for comment in Comment.all
          if comment.comment.downcase =~ /#{substring}(.*)/
            photo = Photo.find(comment.photo_id)
            if !@resultPhotos.include?(photo)
              @resultPhotos = @resultPhotos + [photo]
            end
          end
        end
        for tag in Tag.all
          user = User.find(tag.user_id)
          if (user.first_name.downcase =~ /#{substring}(.*)/ ||
              user.last_name.downcase =~ /#{substring}(.*)/)
            photo = Photo.find(tag.photo_id)
            if !@resultPhotos.include?(photo)
              @resultPhotos = @resultPhotos + [photo]
            end
          end
        end
      end
    end
    render :partial => "thumbnails", :locals => {:photos => @resultPhotos}
  end
  
  def user
    @user = User.find(params[:id])
  end
  
  def comment
    @photo = Photo.find(params[:id])
    @comment = Comment.new
  end
  
  def post_comment
    @comment = Comment.new(params[:comment])
    @comment.photo_id = params[:id]
    @comment.user_id = User.find(session[:user])
    @comment.date_time = DateTime.now
    @comment.comment = params[:comment][:comment]
    @comment.save
    if !@comment.valid?
      flash[:alert] = "No comment entered!"
    end
    redirect_to(:action => :comment)
  end
  
  def photo
  end
  
  def post_photo
    if params[:photo] == nil
      redirect_to(:action => :photo)
      return
    end
    
    # Save File to directory
    fileName = params[:photo][:file].original_filename
    directory = "public/images"
    path = File.join(directory, fileName)
    File.open(path, "wb") { |f| f.write(params[:photo][:file].read) }
    
    # Update database
    photo = Photo.new
    photo.user_id = session[:user]
    photo.date_time = DateTime.now
    photo.file_name = fileName
    photo.save
    redirect_to(:controller => :pics, :action => :user, :id => session[:user], :anchor => "photo" + photo.id.to_s)
  end
  
  def tag
    @photo = Photo.find(params[:id])
    @tag = Tag.new
  end
  
  def post_tag
    @tag = Tag.new()
    @tag.photo_id = params[:id]
    @tag.user_id = params[:tag][:user_id]
    @tag.x_coord = params[:tag][:x_coord]
    @tag.y_coord = params[:tag][:y_coord]
    @tag.width = params[:tag][:width]
    @tag.height = params[:tag][:height]
    @tag.save
    redirect_to(:action => :tag)
  end
  
end