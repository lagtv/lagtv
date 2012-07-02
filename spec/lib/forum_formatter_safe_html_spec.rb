require 'spec_helper'

describe ForumFormatterSafeHtml do
  context "When formatting forum inputted content" do
    it "disallows script tags" do
      input_html = 'Hello<script>alert("Hello");</script>World'
      ForumFormatterSafeHtml.format(input_html).should == 'Helloalert("Hello");World'
    end

    it "allows p tags" do
      input_html = '<p>Hello World</p>'
      ForumFormatterSafeHtml.format(input_html).should == '<p>Hello World</p>'
    end

    it "allows b tags" do
      input_html = '<b>Hello World</b>'
      ForumFormatterSafeHtml.format(input_html).should == '<b>Hello World</b>'
    end

    it "allows ul and li tags" do
      input_html = '<ul><li>Hello</li><li>World</li></ul>'
      ForumFormatterSafeHtml.format(input_html).should == "<ul>\n<li>Hello</li>\n<li>World</li>\n</ul>"
    end

    it "allows img tags" do
      input_html = '<img src="http://github.com/andy.jpg" />'
      ForumFormatterSafeHtml.format(input_html).should == '<img src="http://github.com/andy.jpg">'
    end    

    it "allows font tags" do
      input_html = 'You dude<div><hr><b><font size="4" color="#ff0033">WTF</font></b></div>'
      ForumFormatterSafeHtml.format(input_html).should == "You dude<div>\n<hr>\n<b><font size=\"4\" color=\"#ff0033\">WTF</font></b>\n</div>"
    end    

    it "allows font tags" do
      input_html = '<div style="text-align: right;"><b style="font-size: medium; "><i><u>blah</u></i></b></div><div style="text-align: right;"><b style="font-size: medium; "><i><u><br></u></i></b></div><div style="text-align: right;"><ul><li><span style="font-size: medium; "><strike>123</strike></span><br></li></ul><div><font size="3"><strike style="background-color: rgb(255, 0, 51);">red</strike></font></div><div><font size="3"><strike style="background-color: rgb(255, 0, 51);"><br></strike></font></div><div><img src="http://www.gravatar.com/avatar/196ab25f16dcfd37518a41ceb15e0da0?s=60" alt="" align="none"><font size="3"><strike style="background-color: rgb(255, 0, 51);"><br></strike></font></div></div>'
      ForumFormatterSafeHtml.format(input_html).gsub("\n", "").should == "<div style=\"text-align: right;\"><b style=\"font-size: medium; \"><i><u>blah</u></i></b></div><div style=\"text-align: right;\"><b style=\"font-size: medium; \"><i><u><br></u></i></b></div><div style=\"text-align: right;\"><ul><li><span style=\"font-size: medium; \"><strike>123</strike></span><br></li></ul><div><font size=\"3\"><strike style=\"background-color: rgb(255, 0, 51);\">red</strike></font></div><div><font size=\"3\"><strike style=\"background-color: rgb(255, 0, 51);\"><br></strike></font></div><div><img src=\"http://www.gravatar.com/avatar/196ab25f16dcfd37518a41ceb15e0da0?s=60\" alt=\"\" align=\"none\"><font size=\"3\"><strike style=\"background-color: rgb(255, 0, 51);\"><br></strike></font></div></div>"
    end
  end
end