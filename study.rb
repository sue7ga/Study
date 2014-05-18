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
 
 def schoolname
  doc = self.query(13,"電子")
  schoolname = []

  doc.elements['results'].each{
   |element|
   schoolname << element.elements['name']
  }

  newschoolname = schoolname.compact

  schoolname = []

  newschoolname.each{
   |school|
   school = school.to_s
   schoolname << school.gsub(/<name>(.+)<\/name>/,'\1')
  }
   
  return schoolname
 end

end

school = School.new
schoolname = school.schoolname

schoolname.each{
  |school|
  puts school
}


















