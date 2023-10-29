-- @module Module providing a non-validating XML stream parser in Lua.
--  
--  Features:
--  =========
--  
--      * Tokenises well-formed XML (relatively robustly)
--      * Flexible handler based event API (see below)
--      * Parses all XML Infoset elements - ie.
--          - Tags
--          - Text
--          - Comments
--          - CDATA
--          - XML Decl
--          - Processing Instructions
--          - DOCTYPE declarations
--      * Provides limited well-formedness checking 
--        (checks for basic syntax & balanced tags only)
--      * Flexible whitespace handling (selectable)
--      * Entity Handling (selectable)
--  
--  Limitations:
--  ============
--  
--      * Non-validating
--      * No charset handling 
--      * No namespace support 
--      * Shallow well-formedness checking only (fails
--        to detect most semantic errors)
--  
--  API:
--  ====
--
--  The parser provides a partially object-oriented API with 
--  functionality split into tokeniser and handler components.
--  
--  The handler instance is passed to the tokeniser and receives
--  callbacks for each XML element processed (if a suitable handler
--  function is defined). The API is conceptually similar to the 
--  SAX API but implemented differently.
--
--  XML data is passed to the parser instance through the 'parse'
--  method (Note: must be passed a single string currently)
--
--  License:
--  ========
--
--      This code is freely distributable under the terms of the [MIT license](LICENSE).
--
--
--@author Paul Chakravarti (paulc@passtheaardvark.com)
--@author Manoel Campos da Silva Filho
local xml2lua = {_VERSION = "1.5-2"}

local function load_XmlParser()
    --- @module Class providing the actual XML parser.
    --  Available options are:
    --      * stripWS   
    --        Strip non-significant whitespace (leading/trailing) 
    --        and do not generate events for empty text elements
    --  
    --      * expandEntities 
    --        Expand entities (standard entities + single char 
    --        numeric entities only currently - could be extended 
    --        at runtime if suitable DTD parser added elements
    --        to table (see obj._ENTITIES). May also be possible
    --        to expand multibyre entities for UTF-8 only
    --  
    --      * errorHandler
    --        Custom error handler function 
    --
    --  NOTE: Boolean options must be set to 'nil' not '0'

    ---Converts the decimal code of a character to its corresponding char
    --if it's a graphical char, otherwise, returns the HTML ISO code
    --for that decimal value in the format &#code
    --@param code the decimal value to convert to its respective character
    local function decimalToHtmlChar(code)
        local num = tonumber(code)
        if num >= 0 and num < 256 then
            return string.char(num)
        end

        return "&#"..code..";"
    end

    ---Converts the hexadecimal code of a character to its corresponding char
    --if it's a graphical char, otherwise, returns the HTML ISO code
    --for that hexadecimal value in the format &#xCode
    --@param code the hexadecimal value to convert to its respective character
    local function hexadecimalToHtmlChar(code)
        local num = tonumber(code, 16)
        if num >= 0 and num < 256 then
            return string.char(num)
        end

        return "&#x"..code..";"
    end

    local XmlParser = {
        -- Private attribures/functions
        _XML        = '^([^<]*)<(%/?)([^>]-)(%/?)>',
        _ATTR1      = '([%w-:_]+)%s*=%s*"(.-)"',
        _ATTR2      = '([%w-:_]+)%s*=%s*\'(.-)\'',
        _CDATA      = '<%!%[CDATA%[(.-)%]%]>',
        _PI         = '<%?(.-)%?>',
        _COMMENT    = '<!%-%-(.-)%-%->',
        _TAG        = '^(.-)%s.*',
        _LEADINGWS  = '^%s+',
        _TRAILINGWS = '%s+$',
        _WS         = '^%s*$',
        _DTD1       = '<!DOCTYPE%s+(.-)%s+(SYSTEM)%s+["\'](.-)["\']%s*(%b[])%s*>',
        _DTD2       = '<!DOCTYPE%s+(.-)%s+(PUBLIC)%s+["\'](.-)["\']%s+["\'](.-)["\']%s*(%b[])%s*>',
        --_DTD3       = '<!DOCTYPE%s+(.-)%s*(%b[])%s*>',
        _DTD3       = '<!DOCTYPE%s.->',
        _DTD4       = '<!DOCTYPE%s+(.-)%s+(SYSTEM)%s+["\'](.-)["\']%s*>',
        _DTD5       = '<!DOCTYPE%s+(.-)%s+(PUBLIC)%s+["\'](.-)["\']%s+["\'](.-)["\']%s*>',

        --Matches an attribute with non-closing double quotes (The equal sign is matched non-greedly by using =+?)
        _ATTRERR1   = '=+?%s*"[^"]*$',
        --Matches an attribute with non-closing single quotes (The equal sign is matched non-greedly by using =+?)
        _ATTRERR2   = '=+?%s*\'[^\']*$',
        --Matches a closing tag such as </person> or the end of a openning tag such as <person>
        _TAGEXT     = '(%/?)>',

        _errstr = { 
            xmlErr = "Error Parsing XML",
            declErr = "Error Parsing XMLDecl",
            declStartErr = "XMLDecl not at start of document",
            declAttrErr = "Invalid XMLDecl attributes",
            piErr = "Error Parsing Processing Instruction",
            commentErr = "Error Parsing Comment",
            cdataErr = "Error Parsing CDATA",
            dtdErr = "Error Parsing DTD",
            endTagErr = "End Tag Attributes Invalid",
            unmatchedTagErr = "Unbalanced Tag",
            incompleteXmlErr = "Incomplete XML Document",
        },

        _ENTITIES = { 
            ["&lt;"] = "<",
            ["&gt;"] = ">",
            ["&amp;"] = "&",
            ["&quot;"] = '"',
            ["&apos;"] = "'",
            ["&#(%d+);"] = decimalToHtmlChar,
            ["&#x(%x+);"] = hexadecimalToHtmlChar,
        },
    }

    --- Instantiates a XmlParser object.
    --@param _handler Handler module to be used to convert the XML string
    --               to another formats. See the available handlers at the handler directory.
    --               Usually you get an instance to a handler module using, for instance:
    --               local handler = require("xmlhandler/tree").
    --@param _options Options for this XmlParser instance.
    --@see XmlParser.options
    function XmlParser.new(_handler, _options)
        local obj = {
            handler = _handler,
            options = _options,
            _stack  = {}
        }

        setmetatable(obj, XmlParser)
        obj.__index = XmlParser
        return obj;
    end

    ---Checks if a function/field exists in a table or in its metatable
    --@param table the table to check if it has a given function
    --@param elementName the name of the function/field to check if exists
    --@return true if the function/field exists, false otherwise
    local function fexists(table, elementName)
        if table == nil then
            return false
        end

        if table[elementName] == nil then
            return fexists(getmetatable(table), elementName)
        else
            return true
        end
    end

    local function err(self, errMsg, pos)
        if self.options.errorHandler then
            self.options.errorHandler(errMsg,pos)
        end
    end

    --- Removes whitespaces
    local function stripWS(self, s)
        if self.options.stripWS then
            s = string.gsub(s,'^%s+','')
            s = string.gsub(s,'%s+$','')
        end
        return s
    end

    local function parseEntities(self, s) 
        if self.options.expandEntities then
            for k,v in pairs(self._ENTITIES) do
                s = string.gsub(s,k,v)
            end
        end

        return s
    end

    --- Parses a string representing a tag.
    --@param s String containing tag text
    --@return a {name, attrs} table
    -- where name is the name of the tag and attrs 
    -- is a table containing the atributtes of the tag
    local function parseTag(self, s)
        local tag = {
                name = string.gsub(s, self._TAG, '%1'),
                attrs = {}
              }            

        local parseFunction = function (k, v) 
                tag.attrs[k] = parseEntities(self, v)
                tag.attrs._ = 1 
              end
                              
        string.gsub(s, self._ATTR1, parseFunction) 
        string.gsub(s, self._ATTR2, parseFunction)

        if tag.attrs._ then
            tag.attrs._ = nil
        else 
            tag.attrs = nil
        end

        return tag
    end

    local function parseXmlDeclaration(self, xml, f)
        -- XML Declaration
        f.match, f.endMatch, f.text = string.find(xml, self._PI, f.pos)
        if not f.match then 
            err(self, self._errstr.declErr, f.pos)
        end 

        if f.match ~= 1 then
            -- Must be at start of doc if present
            err(self, self._errstr.declStartErr, f.pos)
        end

        local tag = parseTag(self, f.text) 
        -- TODO: Check if attributes are valid
        -- Check for version (mandatory)
        if tag.attrs and tag.attrs.version == nil then
            err(self, self._errstr.declAttrErr, f.pos)
        end

        if fexists(self.handler, 'decl') then 
            self.handler:decl(tag, f.match, f.endMatch)
        end    

        return tag
    end

    local function parseXmlProcessingInstruction(self, xml, f)
        local tag = {}

        -- XML Processing Instruction (PI)
        f.match, f.endMatch, f.text = string.find(xml, self._PI, f.pos)
        if not f.match then 
            err(self, self._errstr.piErr, f.pos)
        end 
        if fexists(self.handler, 'pi') then 
            -- Parse PI attributes & text
            tag = parseTag(self, f.text) 
            local pi = string.sub(f.text, string.len(tag.name)+1)
            if pi ~= "" then
                if tag.attrs then
                    tag.attrs._text = pi
                else
                    tag.attrs = { _text = pi }
                end
            end
            self.handler:pi(tag, f.match, f.endMatch) 
        end

        return tag
    end

    local function parseComment(self, xml, f)
        f.match, f.endMatch, f.text = string.find(xml, self._COMMENT, f.pos)
        if not f.match then 
            err(self, self._errstr.commentErr, f.pos)
        end 

        if fexists(self.handler, 'comment') then 
            f.text = parseEntities(self, stripWS(self, f.text))
            self.handler:comment(f.text, next, f.match, f.endMatch)
        end
    end

    local function _parseDtd(self, xml, pos)
        -- match,endMatch,root,type,name,uri,internal
        local dtdPatterns = {self._DTD1, self._DTD2, self._DTD3, self._DTD4, self._DTD5}

        for _, dtd in pairs(dtdPatterns) do
            local m,e,r,t,n,u,i = string.find(xml, dtd, pos)
            if m then
                return m, e, {_root=r, _type=t, _name=n, _uri=u, _internal=i} 
            end
        end

        return nil
    end

    local function parseDtd(self, xml, f)
        f.match, f.endMatch, _ = _parseDtd(self, xml, f.pos)
        if not f.match then 
            err(self, self._errstr.dtdErr, f.pos)
        end 

        if fexists(self.handler, 'dtd') then
            local tag = {name="DOCTYPE", value=string.sub(xml, f.match+10, f.endMatch-1)}
            self.handler:dtd(tag, f.match, f.endMatch)
        end
    end

    local function parseCdata(self, xml, f)
        f.match, f.endMatch, f.text = string.find(xml, self._CDATA, f.pos)
        if not f.match then 
            err(self, self._errstr.cdataErr, f.pos)
        end 

        if fexists(self.handler, 'cdata') then
            self.handler:cdata(f.text, nil, f.match, f.endMatch)
        end    
    end

    --- Parse a Normal tag
    -- Need check for embedded '>' in attribute value and extend
    -- match recursively if necessary eg. <tag attr="123>456"> 
    local function parseNormalTag(self, xml, f)
        --Check for errors
        while 1 do
            --If there isn't an attribute without closing quotes (single or double quotes)
            --then breaks to follow the normal processing of the tag.
            --Otherwise, try to find where the quotes close.
            f.errStart, f.errEnd = string.find(f.tagstr, self._ATTRERR1)        

            if f.errEnd == nil then
                f.errStart, f.errEnd = string.find(f.tagstr, self._ATTRERR2)
                if f.errEnd == nil then
                    break
                end
            end
            
            f.extStart, f.extEnd, f.endt2 = string.find(xml, self._TAGEXT, f.endMatch+1)
            f.tagstr = f.tagstr .. string.sub(xml, f.endMatch, f.extEnd-1)
            if not f.match then 
                err(self, self._errstr.xmlErr, f.pos)
            end 
            f.endMatch = f.extEnd
        end 

        -- Extract tag name and attrs
        local tag = parseTag(self, f.tagstr) 

        if (f.endt1=="/") then
            if fexists(self.handler, 'endtag') then
                if tag.attrs then
                    -- Shouldn't have any attributes in endtag
                    err(self, string.format("%s (/%s)", self._errstr.endTagErr, tag.name), f.pos)
                end
                if table.remove(self._stack) ~= tag.name then
                    err(self, string.format("%s (/%s)", self._errstr.unmatchedTagErr, tag.name), f.pos)
                end
                self.handler:endtag(tag, f.match, f.endMatch)
            end
        else
            table.insert(self._stack, tag.name)

            if fexists(self.handler, 'starttag') then
                self.handler:starttag(tag, f.match, f.endMatch)
            end

            -- Self-Closing Tag
            if (f.endt2=="/") then
                table.remove(self._stack)
                if fexists(self.handler, 'endtag') then
                    self.handler:endtag(tag, f.match, f.endMatch)
                end
            end
        end

        return tag
    end

    local function parseTagType(self, xml, f)
        -- Test for tag type
        if string.find(string.sub(f.tagstr, 1, 5), "?xml%s") then
            parseXmlDeclaration(self, xml, f)
        elseif string.sub(f.tagstr, 1, 1) == "?" then
            parseXmlProcessingInstruction(self, xml, f)
        elseif string.sub(f.tagstr, 1, 3) == "!--" then
            parseComment(self, xml, f)
        elseif string.sub(f.tagstr, 1, 8) == "!DOCTYPE" then
            parseDtd(self, xml, f)
        elseif string.sub(f.tagstr, 1, 8) == "![CDATA[" then
            parseCdata(self, xml, f)
        else
            parseNormalTag(self, xml, f)
        end
    end

    --- Get next tag (first pass - fix exceptions below).
    --@return true if the next tag could be got, false otherwise
    local function getNextTag(self, xml, f)
      f.match, f.endMatch, f.text, f.endt1, f.tagstr, f.endt2 = string.find(xml, self._XML, f.pos)
      if not f.match then 
          if string.find(xml, self._WS, f.pos) then
              -- No more text - check document complete
              if #self._stack ~= 0 then
                  err(self, self._errstr.incompleteXmlErr, f.pos)
              else
                  return false 
              end
          else
              -- Unparsable text
              err(self, self._errstr.xmlErr, f.pos)
          end
      end 

      f.text = f.text or ''
      f.tagstr = f.tagstr or ''
      f.match = f.match or 0
      
      return f.endMatch ~= nil
    end

    --Main function which starts the XML parsing process
    --@param xml the XML string to parse
    --@param parseAttributes indicates if tag attributes should be parsed or not. 
    --       If omitted, the default value is true.
    function XmlParser:parse(xml, parseAttributes)
        if type(self) ~= "table" or getmetatable(self) ~= XmlParser then
            error("You must call xmlparser:parse(parameters) instead of xmlparser.parse(parameters)")
        end

        if parseAttributes == nil then
           parseAttributes = true
        end

        self.handler.parseAttributes = parseAttributes

        --Stores string.find results and parameters
        --and other auxiliar variables
        local f = {
            --string.find return
            match = 0,
            endMatch = 0,
            -- text, end1, tagstr, end2,

            --string.find parameters and auxiliar variables
            pos = 1,
            -- startText, endText,
            -- errStart, errEnd, extStart, extEnd,
        }

        while f.match do
            if not getNextTag(self, xml, f) then
                break
            end
            
            -- Handle leading text
            f.startText = f.match
            f.endText = f.match + string.len(f.text) - 1
            f.match = f.match + string.len(f.text)
            f.text = parseEntities(self, stripWS(self, f.text))
            if f.text ~= "" and fexists(self.handler, 'text') then
                self.handler:text(f.text, nil, f.match, f.endText)
            end

            parseTagType(self, xml, f)
            f.pos = f.endMatch + 1
        end
    end

    XmlParser.__index = XmlParser
    return XmlParser

end

local XmlParser = load_XmlParser()

---Recursivelly prints a table in an easy-to-ready format
--@param tb The table to be printed
--@param level the indentation level to start with
local function printableInternal(tb, level)
  if tb == nil then
     return
  end
  
  level = level or 1
  local spaces = string.rep(' ', level*2)
  for k,v in pairs(tb) do
      if type(v) == "table" then
         print(spaces .. k)
         printableInternal(v, level+1)
      else
         print(spaces .. k..'='..v)
      end
  end  
end

---Instantiates a XmlParser object to parse a XML string
--@param handler Handler module to be used to convert the XML string
--to another formats. See the available handlers at the handler directory.
-- Usually you get an instance to a handler module using, for instance:
-- local handler = require("xmlhandler/tree").
--@return a XmlParser object used to parse the XML
--@see XmlParser
function xml2lua.parser(handler)    
    if handler == xml2lua then
        error("You must call xml2lua.parse(handler) instead of xml2lua:parse(handler)")
    end

    local options = { 
            --Indicates if whitespaces should be striped or not
            stripWS = 1, 
            expandEntities = 1,
            errorHandler = function(errMsg, pos) 
                error(string.format("%s [char=%d]\n", errMsg or "Parse Error", pos))
            end
          }

    return XmlParser.new(handler, options)
end

---Recursivelly prints a table in an easy-to-ready format
--@param tb The table to be printed
function xml2lua.printable(tb)
    printableInternal(tb)
end

---Handler to generate a string prepresentation of a table
--Convenience function for printHandler (Does not support recursive tables).
--@param t Table to be parsed
--@return a string representation of the table
function xml2lua.toString(t)
    local sep = ''
    local res = ''
    if type(t) ~= 'table' then
        return t
    end

    for k,v in pairs(t) do
        if type(v) == 'table' then 
            v = xml2lua.toString(v)
        end
        res = res .. sep .. string.format("%s=%s", k, v)    
        sep = ','
    end
    res = '{'..res..'}'

    return res
end

--- Loads an XML file from a specified path
-- @param xmlFilePath the path for the XML file to load
-- @return the XML loaded file content
function xml2lua.loadFile(xmlFilePath)
    local f, e = io.open(xmlFilePath, "r")
    if f then
        --Gets the entire file content and stores into a string
        local content = f:read("*a")
        f:close()
        return content
    end
    
    error(e)
end

---Gets an _attr element from a table that represents the attributes of an XML tag,
--and generates a XML String representing the attibutes to be inserted
--into the openning tag of the XML
--
--@param attrTable table from where the _attr field will be got
--@return a XML String representation of the tag attributes
local function attrToXml(attrTable)
  local s = ""
  attrTable = attrTable or {}
  
  for k, v in pairs(attrTable) do
      s = s .. " " .. k .. "=" .. '"' .. v .. '"'
  end
  return s
end

---Gets the first key of a given table
local function getFirstKey(tb)
   if type(tb) == "table" then
      for k, _ in pairs(tb) do
          return k
      end
      return nil
   end

   return tb
end

--- Parses a given entry in a lua table
-- and inserts it as a XML string into a destination table.
-- Entries in such a destination table will be concatenated to generated
-- the final XML string from the origin table.
-- @param xmltb the destination table where the XML string from the parsed key will be inserted
-- @param tagName the name of the table field that will be used as XML tag name
-- @param fieldValue a field from the lua table to be recursively parsed to XML or a primitive value that will be enclosed in a tag name
-- @param level a int value used to include indentation in the generated XML from the table key
local function parseTableKeyToXml(xmltb, tagName, fieldValue, level)
    local spaces = string.rep(' ', level*2)

    local strValue, attrsStr = "", ""
    if type(fieldValue) == "table" then
        attrsStr = attrToXml(fieldValue._attr)
        fieldValue._attr = nil
        --If after removing the _attr field there is just one element inside it,
        --the tag was enclosing a single primitive value instead of other inner tags.
        strValue = #fieldValue == 1 and spaces..tostring(fieldValue[1]) or xml2lua.toXml(fieldValue, tagName, level+1)
        strValue = '\n'..strValue..'\n'..spaces
    else
        strValue = tostring(fieldValue)
    end

    table.insert(xmltb, spaces..'<'..tagName.. attrsStr ..'>'..strValue..'</'..tagName..'>')
end

---Converts a Lua table to a XML String representation.
--@param tb Table to be converted to XML
--@param tableName Name of the table variable given to this function,
--                 to be used as the root tag. If a value is not provided
--                 no root tag will be created.
--@param level Only used internally, when the function is called recursively to print indentation
--
--@return a String representing the table content in XML
function xml2lua.toXml(tb, tableName, level)
  level = level or 1
  local firstLevel = level
  tableName = tableName or ''
  local xmltb = (tableName ~= '' and level == 1) and {'<'..tableName..attrToXml(tb._attr)..'>'} or {}
  tb._attr = nil

  for k, v in pairs(tb) do
      if type(v) == 'table' then
         -- If the key is a number, the given table is an array and the value is an element inside that array.
         -- In this case, the name of the array is used as tag name for each element.
         -- So, we are parsing an array of objects, not an array of primitives.
         if type(k) == 'number' then
            parseTableKeyToXml(xmltb, tableName, v, level)
         else
            level = level + 1
            -- If the type of the first key of the value inside the table
            -- is a number, it means we have a HashTable-like structure,
            -- in this case with keys as strings and values as arrays.
            if type(getFirstKey(v)) == 'number' then
                for sub_k, sub_v in pairs(v) do
                    if sub_k ~= '_attr' then
                      local sub_v_with_attr = type(v._attr) == 'table' and { sub_v, _attr = v._attr } or sub_v
                      parseTableKeyToXml(xmltb, k, sub_v_with_attr, level)
                    end
                end
            else
               -- Otherwise, the "HashTable" values are objects
               parseTableKeyToXml(xmltb, k, v, level)
            end
         end
      else
         -- When values are primitives:
         -- If the type of the key is number, the value is an element from an array.
         -- In this case, uses the array name as the tag name.
         if type(k) == 'number' then
            k = tableName
         end
         parseTableKeyToXml(xmltb, k, v, level)
      end
  end

  if tableName ~= '' and firstLevel == 1 then
      table.insert(xmltb, '</'..tableName..'>\n')
  end

  return table.concat(xmltb, '\n')
end

local function load_TreeHandler()

    local function init()
        local obj = {
            root = {},
            options = {noreduce = {}}
        }
        
        obj._stack = {obj.root}  
        return obj  
    end

    -- @module XML Tree Handler.
    -- Generates a lua table from an XML content string.
    -- It is a simplified handler which attempts
    -- to generate a more 'natural' table based structure which
    -- supports many common XML formats.
    --
    -- The XML tree structure is mapped directly into a recursive
    -- table structure with node names as keys and child elements
    -- as either a table of values or directly as a string value
    -- for text. Where there is only a single child element this
    -- is inserted as a named key - if there are multiple
    -- elements these are inserted as a vector (in some cases it
    -- may be preferable to always insert elements as a vector
    -- which can be specified on a per element basis in the
    -- options).  Attributes are inserted as a child element with
    -- a key of '_attr'.
    --
    -- Only Tag/Text & CDATA elements are processed - all others
    -- are ignored.
    --
    -- This format has some limitations - primarily
    -- 
    -- * Mixed-Content behaves unpredictably - the relationship
    --   between text elements and embedded tags is lost and
    --   multiple levels of mixed content does not work
    -- * If a leaf element has both a text element and attributes
    --   then the text must be accessed through a vector (to
    --   provide a container for the attribute)
    --
    -- In general however this format is relatively useful.
    --
    -- It is much easier to understand by running some test
    -- data through 'testxml.lua -simpletree' than to read this)
    --
    -- Options
    -- =======
    --    options.noreduce = { <tag> = bool,.. }
    --        - Nodes not to reduce children vector even if only
    --          one child
    --
    --  License:
    --  ========
    --
    --  This code is freely distributable under the terms of the [MIT license](LICENSE).
    --
    --@author Paul Chakravarti (paulc@passtheaardvark.com)
    --@author Manoel Campos da Silva Filho
    local tree = init()

    ---Instantiates a new handler object.
    --Each instance can handle a single XML.
    --By using such a constructor, you can parse
    --multiple XML files in the same application.
    --@return the handler instance
    function tree:new()
        local obj = init()

        obj.__index = self
        setmetatable(obj, self)

        return obj
    end

    --- Recursively removes redundant vectors for nodes
    -- with single child elements
    function tree:reduce(node, key, parent)
        for k,v in pairs(node) do
            if type(v) == 'table' then
                self:reduce(v,k,node)
            end
        end
        if #node == 1 and not self.options.noreduce[key] and 
            node._attr == nil then
            parent[key] = node[1]
        end
    end


    --- If an object is not an array,
    -- creates an empty array and insert that object as the 1st element.
    --
    -- It's a workaround for duplicated XML tags outside an inner tag. Check issue #55 for details.
    -- It checks if a given tag already exists on the parsing stack.
    -- In such a case, if that tag is represented as a single element,
    -- an array is created and that element is inserted on it.
    -- The existing tag is then replaced by the created array.
    -- For instance, if we have a tag x = {attr1=1, attr2=2}
    -- and another x tag is found, the previous entry will be changed to an array
    -- x = {{attr1=1, attr2=2}}. This way, the duplicated tag will be
    -- inserted into this array as x = {{attr1=1, attr2=2}, {attr1=3, attr2=4}}
    -- https://github.com/manoelcampos/xml2lua/issues/55
    --
    -- @param obj the object to try to convert to an array
    -- @return the same object if it's already an array or a new array with the object
    --         as the 1st element.
    local function convertObjectToArray(obj)
        --#obj == 0 verifies if the field is not an array
        if #obj == 0 then
            local array = {}
            table.insert(array, obj)
            return array
        end

        return obj
    end

    ---Parses a start tag.
    -- @param tag a {name, attrs} table
    -- where name is the name of the tag and attrs
    -- is a table containing the atributtes of the tag
    function tree:starttag(tag)
        local node = {}
        if self.parseAttributes == true then
            node._attr=tag.attrs
        end

        --Table in the stack representing the tag being processed
        local current = self._stack[#self._stack]
        
        if current[tag.name] then
            local array = convertObjectToArray(current[tag.name])
            table.insert(array, node)
            current[tag.name] = array
        else
            current[tag.name] = {node}
        end

        table.insert(self._stack, node)
    end

    ---Parses an end tag.
    -- @param tag a {name, attrs} table
    -- where name is the name of the tag and attrs
    -- is a table containing the atributtes of the tag
    function tree:endtag(tag, s)
        --Table in the stack representing the tag being processed
        --Table in the stack representing the containing tag of the current tag
        local prev = self._stack[#self._stack-1]
        if not prev[tag.name] then
            error("XML Error - Unmatched Tag ["..s..":"..tag.name.."]\n")
        end
        if prev == self.root then
            -- Once parsing complete, recursively reduce tree
            self:reduce(prev, nil, nil)
        end

        table.remove(self._stack)
    end

    ---Parses a tag content.
    -- @param t text to process
    function tree:text(text)
        local current = self._stack[#self._stack]
        table.insert(current, text)
    end

    ---Parses CDATA tag content.
    tree.cdata = tree.text
    tree.__index = tree
    return tree

end

xml2lua.TreeHandler = load_TreeHandler()

return xml2lua
