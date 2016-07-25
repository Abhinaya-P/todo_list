module ApplicationHelper
	def full_title(pagetitle)
		basetitle = "TodoList App"
		if pagetitle.empty?
			basetitle
		else
			"#{basetitle} | #{pagetitle}"
		end
    end
end
