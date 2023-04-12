---
layout: post
title: "SOS: Web Design Needs Conventions"
date: 2014-09-29 08:35:34 +0100
categories:
published: false
---

I've been designing websites for 11 years, and the web is changed a lot. New technologies come out every day, making things better for the users, and far more enjoyable for us developers to build. However, developing websites is still a massive pain in the bottom. Sometimes it takes weeks, sometimes months.

## There's a lack of conventions.

Let's think about it: what are the usual parts of a website? I'd say that:

- a **site** has many **pages**;
- each page might be built with a different **template**;
- each **template** may have several **components**;


## But why is that?

I think it's because we're used to **reinvent the wheel** every day.

Let's be honest here: how many times have you built a shopping cart from scratch? Or a pagination system? Or a contact form?!
<!--
Let's focus on the pagination system. If you are using Rails you could have used the `will_paginate` gem. Or, if you are exclusively a front end developer, how many times did you type "header" and "footer"? Maybe in a 2000 lines long stylesheet. To be honest, that's what I did for a long time. But now it's time to change. -->

## Web Components to the rescue

Thinking about the pagination system, imagine if you could just drop a `<paginate>` tag in your HTML page and that will just work. Would't that be brilliant? Or imagine a `<template>` tag that you just paste in your page instead of copy pasting an entire block of messy HTML that some other developer wrote before you. That would be **amazing**.

Creating your own custom HTML elements sounds great, and the good news is you can already do it! ...Well, in some browsers anyway.

## But what about *conventions*?

What we need to do, at least for the time being.

js and css and html need to be together.

> Templates separate technologies, not concerns.
