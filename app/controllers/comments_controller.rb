class CommentsController < InheritedResources::Base
  load_and_authorize_resource
  
  belongs_to :user , :optional => true
  
  def index
    @commentable = find_commentable
    @comments = @commentable.comments
    
  end

  def edit
    @comment = Comment.find(params[:id])
    session[:go_to_after_update_comment] = @comment.commentable
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(:back, :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => :back, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update 
    @comment = Comment.find(params[:id])  
    @comment.save
    update! {session[:go_to_after_update_comment] }
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
  
#private

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
end
