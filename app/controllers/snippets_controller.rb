class SnippetsController < ApplicationController
  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(snippet_params)
    if @snippet.save
      # uri = URI.parse('http://pygments.appspot.com/')
      # request = Net::HTTP.post_form(uri, {'lang' => @snippet.language, 'code' => @snippet.plain_code})
      Resque.enqueue(SnippetHighlighter, @snippet.id)

      # @snippet.update_attribute(:highlighted_code, @snippet.plain_code.upcase)
      redirect_to @snippet, :notice => "Successfully created snippet."
    else
      render 'new'
    end
  end

  def show
    @snippet = Snippet.find(params[:id])
  end


  private 
    def snippet_params
      params.require(:snippet).permit(:name, :language, :plain_code, :highlighted_code)
    end
end
