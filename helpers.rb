helpers do
  def title(str)
    # lceil rfloor, lfloor rceil, sdot, bull, mdash
    @title = str + " &mdash; Seclusion"
  end

  def path_to_post(post)
    if post.class == Post
      return '/post/' + post.id
    else
      return '/post/' + post.to_s
    end
  end

  def link_to_post(post, text)
    return "<a href=\"#{path_to_post(post)}\">"+text+"</a>"
  end
end