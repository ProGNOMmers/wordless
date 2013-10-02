class StringSequence
  def initialize(template_string)
    @next, @template_string = 1, template_string
  end

  def next
    current = @template_string % @next
    @next += 1
    current
  end
end