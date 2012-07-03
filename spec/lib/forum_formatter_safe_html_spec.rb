require 'spec_helper'

describe ForumFormatterSafeHtml do
  context "When sanitizing the content" do
    it "returns the unaltered content as the format mathod takes care of everything" do
      ForumFormatterSafeHtml.sanitize("<b>hello</b>").should == "<b>hello</b>"
    end
  end

  context "When formatting forum inputted content" do
    it "replaces a simple emojis with an img tag" do
      input_html = ':2:'
      ForumFormatterSafeHtml.format(input_html).should == '<img src="/assets/emojis/2.png">'
    end

    it "replaces duplicate emojis with img tags" do
      input_html = 'This is cool :2: and so is this :2:'
      ForumFormatterSafeHtml.format(input_html).should == 'This is cool <img src="/assets/emojis/2.png"> and so is this <img src="/assets/emojis/2.png">'
    end

    it "replaces listed emojis with img tags" do
      input_html = ':2::3::4:'
      ForumFormatterSafeHtml.format(input_html).should == '<img src="/assets/emojis/2.png"><img src="/assets/emojis/3.png"><img src="/assets/emojis/4.png">'
    end

    it "replaces listed emojis with img tags" do
      input_html = ':2: :3: :4:'
      ForumFormatterSafeHtml.format(input_html).should == '<img src="/assets/emojis/2.png"><img src="/assets/emojis/3.png"><img src="/assets/emojis/4.png">'
    end

    it "replaces word emojis with img tags" do
      input_html = 'Now this is bouse :kiss:'
      ForumFormatterSafeHtml.format(input_html).should == 'Now this is bouse <img src="/assets/emojis/kiss.png">'
    end    

    it "replaces emojis containing symbols with img tags" do
      input_html = ':+1: :-1:'
      ForumFormatterSafeHtml.format(input_html).should == '<img src="/assets/emojis/plus1.png"><img src="/assets/emojis/-1.png">'
    end  
          
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

    it "allows blockquotes tags" do
      input_html = '<blockquote>Hello World</blockquote>'
      ForumFormatterSafeHtml.format(input_html).should == '<blockquote>Hello World</blockquote>'
    end
  end
end