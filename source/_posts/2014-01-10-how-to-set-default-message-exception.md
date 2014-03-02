---
title: How to set a default message in your exception
author: Simone Vittori
layout: post
permalink: /how-to-set-default-message-exception/
dsq_thread_id:
  - 2102362575
categories:
  - Ruby
tags:
  - catch
  - custom
  - error
  - exception
  - message
  - raise
---
<div id="jbID-1068" class="jbPost">
  <p>
    Today I was thinking about a way to define custom exceptions with a predefined error message. For example, instead of doing this:
  </p>
  
  <pre>raise MyError, "Something went wrong."</pre>
  
  <p>
    We want to simply do:
  </p>
  
  <pre>raise MyError</pre>
  
  <p>
    This could be useful because if we need to raise that same exception again and again, we don&#8217;t have to specify the error message every time.
  </p>
  
  <p>
    Well, how can we do that?<p>
      <p>
        I spent all day figuring out the best way, actually doing very bad things &#8211; I&#8217;ve even attempted to monkey-patch the Kernel module!<br />So &#8211; believe me &#8211; it&#8217;s not as simple as it appears to be. Or, at least, I thought this until I stumbled across <a href="http://ablogaboutcode.com/2011/01/03/using-custom-error-messages-for-cleaner-code/" title="Using Custom Error Messages for Cleaner Code" target="_blank">this article</a>.
      </p>
      
      <p>
        In short, you just need to override <code>Exception#message</code>.
      </p>
      
      <p>
        For example:
      </p>
      
      <pre>class MyError &lt; Exception
  def message
    "a predefined message"
  end
end

raise MyError
# => MyError: a predefined message</pre>
      
      <p>
        Quick note: I&#8217;m inheriting from <code>StandardError</code>, not <code>Exception</code>, because extending the <code>Exception</code> class in Ruby is considered really bad. Please don&#8217;t inherit from it: see <a href="https://stackoverflow.com/questions/10048173/why-is-it-bad-style-to-rescue-exception-e-in-ruby" title="Why is it bad style to rescue exception in Ruby?" target="_blank">here</a> and <a href="http://www.skorks.com/2009/09/ruby-exceptions-and-exception-handling/" title="Ruby exceptions and exceptions handling" target="_blank">here</a> for the reason (in few words it&#8217;s because you may catch errors that are not meant to be catched, such as <code>SyntaxError</code>).<p>
          <p>
            Of course you could also create a module with your own exceptions in it:
          </p>
          
          <pre>module CustomError
  class AnError &lt; StandardError
    def message
      "A more specific error"
    end
  end

  class AnotherError &lt; StandardError
    def message
      "just another error"
    end
  end
end</pre>
          
          <p>
            Or even a subclass of your custom error class:
          </p>
          
          <pre>module CustomError
  class Error &lt; StandardError
    def message
      "default error"
    end
  end
  
  class SpecificError &lt; Error
    def message
      "a more specific error"
    end
  end
end</pre>
          
          <p>
            However, this is not very useful. What I find useful, though, is that you can bring shared pieces of information from the base class to the subclasses, which is <abbr title="In my opinion">IMO</abbr> very desirable in error handling.
          </p>
          
          <p>
            Since <code>Exception#message</code> is nothing but an alias of <code>exception.to_s</code>, we can call <code>super</code> to get the superclass' message. For example, this is what I ended up doing:
          </p>
          
          <pre>module CustomError

  class Error &lt; StandardError
    def initialize(msg=nil)
      @message = msg
    end

    def message
      "Message from main class: #{@message}."
    end
  end

  class SpecificError &lt; Error
    def message
      super + " We also got a specific error."
    end
  end
end</pre>
          
          <p>
            And here's the result:
          </p>
          
          <pre>
raise CustomError::SpecificError, "fubar"
# => CustomError::SpecificError: Message from main class: fubar. We also got a specific error.</pre>
          
          <p>
            This demonstrates that we can potentially carry whatever information (i.e. instances of objects involved in the error) in order to better handle errors in our applications.
          </p>
          
          <p>
            That's it.<br /> As always, please feel free to share your thoughts by commenting below.
          </p></div>