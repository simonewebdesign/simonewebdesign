---
layout: page
title: Projects
comments: false
sharing: false
footer: false
sidebar: false
---

<ul class="projects">{% for proj in site.data.projects %}
<li><a href="{{ proj.url }}">{{ proj.title }}</a>
{% endfor %}</ul>
