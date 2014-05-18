# -*- coding: utf-8 -*-
require 'rexml/document'
require 'open-uri'
require 'nkf'
 
class School 
 @@baseurl = 'http://webservice.recruit.co.jp/shingaku/school/v1/?key='

 def initialize(apikey = "ad425e84441a387a")
  @apikey = apikey
 end

 def apikey
  @apikey
 end

 def url
   @@baseurl + @apikey
 end
 
 def query(pref_cd,keyword) 
   url = self.url
   query = url + "&pref_cd=#{pref_cd}" + "&keyword=#{keyword}"
   query 
   escape_url =  URI.escape(query)
   parse_url = URI.parse(escape_url)
   result =open(parse_url)
   doc = REXML::Document.new(result) 
   return doc
 end

end

school = School.new
doc = school.query(12,"数学")

puts doc.elements['school/code'].text













