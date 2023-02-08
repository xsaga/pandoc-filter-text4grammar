-- pandoc lua filter to transform .tex file into simple text with no markup
-- to use in grammarly or other spell checkers.
-- info to debug lua filters: https://github.com/wlupton/pandoc-lua-logging

-- 2023/02/08

-- pandoc --wrap=none --lua-filter text4grammar.lua -o output.txt sample.tex

-- function Header ()
--    return {}
-- end

function Cite ()
   return pandoc.Str("(Reference 2023, 3)")
end

function Strong (elem)
   return elem.content
end

function Emph (elem)
   return elem.content
end

function SmallCaps (elem)
   return elem.content
end

function Span (elem)
   if elem.classes[1] == "sans-serif" then
      return elem.content
   end
   return elem
end

function Code (elem)
   return pandoc.RawInline("tex", elem.text)
end

function Link (elem)
   if elem.attr.attributes["reference-type"] == "ref" then
      return pandoc.Str("1")
   end

   if elem.attr.attributes["reference-type"] == "eqref" then
      return pandoc.Str("(1)")
   end
end

function Math (elem)
   if elem.mathtype == "InlineMath" then
      return pandoc.RawInline("tex", elem.text)
   end
   return {}
end

function Image (elem)
   return pandoc.Span(elem.caption)
end

function Table (elem)
   return pandoc.Span(elem.caption)
end

