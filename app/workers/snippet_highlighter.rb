class SnippetHighlighter
	@queue = "snippet_queue"

	def self.perform(snippet_id)
		snippet = Snippet.find(snippet_id)
		snippet.plain_code << "  xxxxxxx "
		snippet.update_attribute(:highlighted_code, snippet.plain_code.upcase)
	end
	
	
end