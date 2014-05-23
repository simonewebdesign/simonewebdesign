---
title: How to put online your WampServer
layout: post
permalink: /blog/how-to-put-online-your-wampserver
date: 2013-07-20
comments: true
dsq_thread_id:
  - 1513101928
categories:
  - PHP
tags:
  - allow
  - apache
  - conf
  - deny
  - forward
  - gateway
  - host
  - httpd
  - httpd.conf
  - ip
  - ip address
  - ip forwarding
  - listen
  - local
  - localhost
  - online
  - port
  - port forwarding
  - private
  - public
  - request
  - router
  - server
  - servername
  - wampserver
  - web
  - webserver
---

<p>
  <img src="/images/wampserver-logo.png" alt="WampServer Logo" width="200" height="200" class="basic-alignment left" />On your Windows machine you run an <strong>Apache web server</strong> with some <abbr title="PHP: Hypertext Preprocessor (recursive acronym)">PHP</abbr> websites in there. What if you want to show all of them to your friends, or want to be <strong>reachable by the whole Internet</strong>? This may sound quite difficult to achieve, but actually it&#8217;s fairly straightforward to <strong>put online a web server</strong>: let&#8217;s see how.
</p>

<h3>
  Publishing your Website on the Internet
</h3>

<p>
  First of all, you need to get your WAMP stack up and running on your local host. I&#8217;ll assume you already have a web application hosted on your own PC, and that is reachable by just typing this <abbr title="Uniform Resource Locator">URL</abbr> in the address bar:
</p>

```
http://localhost/    # or http://127.0.0.1
```

<p>
  Now you should access to your router web interface. Usually it is reachable by navigating to:
</p>

```
http://192.168.1.1
```

<p>
  However this may vary, depending on your router model. When in doubt, open the command prompt (<code>cmd</code>), type <code>ipconfig</code> and press enter. You should see something like this:
</p>

```
C:\>ipconfig

Ethernet adapter Local Area Connection:

  Connection-specific DNS Suffix  . :
  IP Address. . . . . . . . . . . . : 192.168.1.27
  Subnet Mask . . . . . . . . . . . : 255.255.255.0
  Default Gateway . . . . . . . . . : 192.168.1.1
```

<p>
  Please take note of the <abbr title="Internet Protocol">IP</abbr> address: that&#8217;s your private address, which uniquely identifies you in your local network. If you try it in your browser, you should be able to see the public contents of your server.
</p>

<h3>
  Port Forwarding
</h3>

<p>
  In order to be reached by the world, you should tell your gateway where is your web server. All incoming request on port <code>80</code> should be redirected to your own private <abbr title="Internet Protocol">IP</abbr> address. Even this process may vary; it really depends on your router. By the way, this is what you basically want to do: <strong>forward every request</strong> on port <code>80</code> to <code>192.168.1.27</code> (of course you must use your own <abbr title="Internet Protocol">IP</abbr> address). But since the router&#8217;s web server already keeps the port <code>80</code> busy, here&#8217;s what you can do:
</p>

<ul>
  <li>
    Move the gateway&#8217;s web interface to another port;
  </li>
  <li>
    Move your web server to another port.
  </li>
</ul>

<p>
  I&#8217;ll pick the last one, since it&#8217;s usually easier to do, and the first option is not always possible. So, let&#8217;s <strong>change the port</strong>: open the <code>httpd.conf</code> and find this row:
</p>

```
Listen 80
```

<p>
  replace it with:
</p>

```
Listen &lt;port number>
```

<p>
  for example:
</p>

```
Listen 8080
```

<p>
  And <strong>restart the server</strong>. Now go to <code>http://localhost:8080</code> and check that everything went as expected.
</p>

<h3>
  Routing the outside web traffic to your own web server
</h3>

<p>
  All respectable routers have an advanced section called <strong><abbr title="Internet Protocol">IP</abbr>/Port Forwarding</strong>: find yours. If you don&#8217;t have this, I&#8217;m afraid you cannot be reachable by the outside.
</p>

<p>
  Usually you need to add two separate entries: one for TCP and one for UDP packets. Something like this will do the work:
</p>

```
Private IP     Private Port   Type   Public IP/mask   Public Port
192.168.1.27   8081 	        TCP    0.0.0.0/0        8081
192.168.1.27   8081 	        UDP    0.0.0.0/0        8081
```

<p>
  Apply the changes and restart your router.
</p>

<h3>
  Configuring the server to be reachable by everyone
</h3>

<p>
  The last step! Open your <code>httpd.conf</code> and find this line:
</p>

```
ServerName localhost:80
```

<p>
  Change it to:
</p>

```
ServerName &lt;your private IP>:80
```

<p>
  Example:
</p>

```
ServerName 192.168.1.27:80
```

<p>
  <small>Just a quick note: you can jump over the step below. It can be done in an easier way by just clicking on the green <strong>WampServer tray icon</strong> and choosing &#8220;Put Online&#8221;.</small>
</p>

<p>
  Also find this line:
</p>

```
Order Deny,Allow
Deny from all
Allow from 127.0.0.1
```

<p>
  Change it to:
</p>

```
Order Allow,Deny
Allow from all
```

<p>
  Restart your web server. Now just find out what&#8217;s your current public <abbr title="Internet Protocol">IP</abbr> address and try to go to:
</p>

```
http://&lt;public IP address>:&lt;port>/
```

<p>
  i.e.:
</p>

```
http://13.37.223.21:8080/
```

<p>
  It should work now! &#8230; Or, at least, it worked for me.
</p>

<p>
  Problems? Thoughts? As always, feel free to leave a comment.
</p>
