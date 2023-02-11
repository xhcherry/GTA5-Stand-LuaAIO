function acknowledgement()
	menu.divider(acknowledgement_list,"lua作者")
		menu.action(acknowledgement_list,"heezy", {}, "",function()	
		end)
		menu.action(acknowledgement_list,"夜幕", {}, "",function()	
		end)
	menu.divider(acknowledgement_list ,"特别鸣谢")
		menu.action(acknowledgement_list,"你", {}, "当然，我们还鸣谢使用的你",function()	
		end)

end
