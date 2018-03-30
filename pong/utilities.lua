function replaceAt(str, pos, char)
	return str:sub(1, pos - 1) .. char .. str:sub(pos + 1)
end

--comment test